# Base image
FROM python:3.9-slim

# Set environment variables
ENV ANSIBLE_VERSION=2.14.5

# Install dependencies and Ansible
RUN apt-get update && apt-get install -y --no-install-recommends \
    sshpass \
    openssh-client \
    && pip install --no-cache-dir ansible==$ANSIBLE_VERSION \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Set work directory
WORKDIR /ansible

# Copy Ansible files into the container
COPY . /ansible/

# Make entrypoint script executable
RUN chmod +x /ansible/docker-entrypoint.sh

# Set entrypoint
ENTRYPOINT ["/ansible/docker-entrypoint.sh"]

# Default command
CMD ["ansible-playbook", "--version"]
