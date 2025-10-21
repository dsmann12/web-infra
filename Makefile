.PHONY: help bootstrap deploy destroy clean

help:
	@echo "Available commands:"
	@echo "  make bootstrap    - Deploy CI/CD infrastructure (one-time setup)"
	@echo "  make deploy       - Deploy application infrastructure"
	@echo "  make destroy      - Delete application stack"
	@echo "  make destroy-all  - Delete all stacks (including bootstrap)"

bootstrap:
	aws cloudformation deploy \
		--template-file infrastructure/ci.yaml \
		--stack-name web-infra-ci \
		--capabilities CAPABILITY_NAMED_IAM \
		--parameter-overrides \
			GitHubRepo=${GITHUB_REPO} \
			AWSAccountId=$$(aws sts get-caller-identity --query Account --output text)

deploy:
	aws cloudformation deploy \
		--template-file infrastructure/infra.yaml \
		--stack-name web-infra \
		--parameter-overrides \
			VpcId=$(VPC_ID) \
			KeyName=$(KEY_NAME) \
			Domain=$(DOMAIN) \
			WebServerHostedZoneId=$(HOSTED_ZONE_ID)

destroy:
	aws cloudformation delete-stack --stack-name web-infra
	aws cloudformation wait stack-delete-complete --stack-name web-infra

destroy-all: destroy
	aws cloudformation delete-stack --stack-name web-infra-ci
	aws cloudformation wait stack-delete-complete --stack-name web-infra-ci

clean:
	@echo "Cleaning up temporary files..."