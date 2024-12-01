FROM debian:bullseye-slim

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive

# Install Ansible and dependencies via APT
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    gnupg \
    python3 \
    python3-pip \
    python3-setuptools \
    sshpass \
    openssh-client \
    ansible \
    && rm -rf /var/lib/apt/lists/*

# Verify Ansible installation
RUN ansible --version

# Set working directory
WORKDIR /ansible

# Copy entrypoint script
COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

# Copy project files
COPY . /ansible

# Set entrypoint
ENTRYPOINT ["docker-entrypoint.sh"]

# Default command
CMD ["ansible-playbook", "site.yml"]