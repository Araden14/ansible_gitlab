#!/bin/bash
set -e

# Create vars directory if it doesn't exist
mkdir -p /ansible/vars

# Generate vars/vars.yml
cat > /ansible/vars/vars.yml << EOF
---
# Database Configuration
postgresql_host: "${POSTGRESQL_HOST}"
postgresql_port: ${POSTGRESQL_PORT:-5432}
db_user: "${DB_USER}"
db_password: "${DB_PASSWORD}"
postgresql_user_privileges: "CREATEDB,SUPERUSER"
postgresql_encoding: "UTF-8"

# Environment Settings
project_environment: "${PROJECT_ENVIRONMENT:-dev}"

# PostgreSQL Database Configuration
postgresql_databases:
  - name: "gitlab_${PROJECT_ENVIRONMENT:-dev}"
    owner: "${DB_USER}"
EOF

# Generate inventory.yml
cat > /ansible/inventory.yml << EOF
---
all:
  hosts:
    gitlab:
      ansible_host: "${GITLAB_HOST:-localhost}"
      ansible_user: "${ANSIBLE_USER:-root}"
      ansible_ssh_pass: "${ANSIBLE_SSH_PASS:-}"
      ansible_ssh_common_args: '-o StrictHostKeyChecking=no'
  
  children:
    gitlab_servers:
      hosts:
        gitlab:
EOF

# Make the script executable
chmod +x /ansible/docker-entrypoint.sh

# Execute the original command
exec "$@" 