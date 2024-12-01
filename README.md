# Ansible GitLab Deployment Project

This repository contains Ansible playbooks for deploying and configuring GitLab. Before using this project, you'll need to set up some required files that are not included in the repository for security reasons.

## Required Files Setup

### 1. Inventory File (`inventory.yml`)

Create an `inventory.yml` file in the project root with your server details. Here's the structure:

```yaml
---
all:
  hosts:
    gitlab:
      ansible_host: your_server_ip
      ansible_user: your_ssh_user
      ansible_ssh_pass: your_ssh_password
      ansible_ssh_common_args: '-o StrictHostKeyChecking=no'
  
  children:
    gitlab_servers:
      hosts:
        gitlab:
```

Replace the following values:
- `your_server_ip`: The IP address of your GitLab server
- `your_ssh_user`: SSH username for connecting to the server
- `your_ssh_password`: SSH password for authentication

### 2. Variables File (`vars/vars.yml`)

Create a directory structure `vars/vars.yml` and add your configuration variables. Here's an example structure:

```yaml
---
# GitLab Configuration Variables
---
# Database Configuration
postgresql_host: db ip
postgresql_port: db port (usually 5432)
db_user: db user
db_password: db password
postgresql_user_privileges: "CREATEDB,SUPERUSER"
postgresql_encoding: "UTF-8"

# Environment Settings
project_environment: "dev"  # Can be 'dev', 'stage', or 'prod'

# PostgreSQL Database Configuration
postgresql_databases:
  - name: "gitlab_{{ project_environment }}"
    owner: "{{ db_user }}"


```

Replace:
- `your.gitlab.domain`: Your GitLab instance domain name

## Security Note

⚠️ The `inventory.yml` and `group_vars/all.yml` files are intentionally excluded from version control (via .gitignore) to prevent exposing sensitive information. Always keep your credentials and sensitive configuration data secure and never commit them to the repository.

## Usage

1. Clone this repository
2. Create the required files as described above
3. Run your playbooks with:
   ```bash
   ansible-playbook -i inventory.yml your_playbook.yml
   ```

