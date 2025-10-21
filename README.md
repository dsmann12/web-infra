# Personal Infrastructure

This project contains the infrastructure setup for my personal website and public applications. It uses nginx as the primary web server for serving static content and as a reverse proxy to route requests to the appropriate sites and applications.

## Overview

- **Web Server**: nginx for reverse proxy and static content delivery
- **Purpose**: Host personal website and public-facing applications

## Getting Started

### Prerequisites

- Docker (recommended) or nginx installed locally
- Basic understanding of nginx configuration

### Setup

1. Clone this repository:
   ```bash
   git clone <repository-url>
   cd <project-directory>
   ```

2. Set up self-signed certs for local deployment
   ```bash
   chmod +x scripts/generate_local_certs.sh
   ./scripts/generate_local_certs.sh
   ```

3. Set up environment for services
   ```
   PORTFOLIO_PORT=8000
   PORTFOLIO_DJANGO_SECRET="choose_your_secret"
   PORTFOLIO_DEBUG=true
   PORTFOLIO_ALLOWED_HOSTS=localhost,portfolio,domain.com
   DOMAIN=domain.com
   PORTFOLIO_SSL_LIVE_DIR=./.certs/live/localhost
   PORTFOLIO_SSL_ARCHIVE_DIR=./.certs/archive/localhost
   PORTFOLIO_SSL_KEYS_DIR=./.certs/keys
   ```

4. Start the services
   ```bash
   docker compose up -d
   ```

### Deployments

1. Bootstrap infrastructure for CI/CD pipeline before any deployments are run
   ```bash
   GITHUB_REPO=dsmann12/web-infra make bootstrap
   ```

## Project Structure

```
.
├── README.md           # This file
├── nginx/              # nginx configuration files (to be created)
```

## Contributing

This is a personal project, but suggestions and improvements are welcome.

## License

AGPL-3.0 - See [LICENSE](LICENSE) file for details