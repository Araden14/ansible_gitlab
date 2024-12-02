# Ansible GitLab Deployment

Simple and automated GitLab deployment using Ansible and Docker.

## Quick Start

1. Clone this repository
2. Rename `.env.example` to `.env` and adjust the variables according to your needs
3. Run:

```bash
docker compose up
```

## Project Structure

- `inventory/`: Contains host definitions and group variables
- `vars/`: Global variables and configuration settings
- `roles/`:
  - `common/`: Base system configuration
  - `docker/`: Docker installation and setup
  - `gitlab/`: GitLab deployment and configuration
  - `nginx/`: Nginx reverse proxy setup

## Environment Configuration

The `.env` file is the only file you need to modify. It contains essential configuration variables for your GitLab instance:

- `GITLAB_DOMAIN`: Your GitLab instance domain
- `GITLAB_SSH_PORT`: SSH port for Git operations
- `GITLAB_HTTPS_PORT`: HTTPS port for web interface
- `GITLAB_ROOT_PASSWORD`: Initial root password

## Technical Details

- Uses Ansible roles for modular and reusable configuration
- Variables are managed through:
  - Inventory group_vars
  - Role-specific vars
  - Global vars directory
- Docker-based deployment for consistency and ease of maintenance
- Nginx configured as reverse proxy with SSL support

## Requirements

- Docker
- Docker Compose
