# FROM postgres:16.4-bookworm
# FROM mysql:8.0-bookworm
# FROM mongo:8.0.0-rc20
# FROM redis:7.4-bookworm
FROM mcr.microsoft.com/mssql-tools

# Install needed tools
RUN apt update && apt install -y curl zip unzip

# Install Azure CLI
RUN curl -sL https://aka.ms/InstallAzureCLIDeb -o /tmp/azure-cli.sh && \
	chmod +x /tmp/azure-cli.sh && \
	/tmp/azure-cli.sh && \
	rm /tmp/azure-cli.sh

# Install AWS CLI
RUN curl https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip -o /tmp/awscliv2.zip && \
	unzip /tmp/awscliv2.zip -d /tmp && \
	/tmp/aws/install && \
	rm /tmp/awscliv2.zip

# Install Gcloud CLI
RUN curl https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-cli-linux-x86_64.tar.gz -o /tmp/google-cloud-cli.tar.gz && \
	tar -xf /tmp/google-cloud-cli.tar.gz -C /tmp && \
	/tmp/google-cloud-sdk/install.sh --quiet --path-update true && \
	rm /tmp/google-cloud-cli.tar.gz
ENV PATH=$PATH:/tmp/google-cloud-sdk/bin

# Install Heroku CLI
RUN curl https://cli-assets.heroku.com/install.sh -o /tmp/heroku.sh && \
	chmod +x /tmp/heroku.sh && \
	/tmp/heroku.sh && \
	rm /tmp/heroku.sh

# Cleanup
RUN rm -rf /var/lib/apt/lists/*

# Keep the container alive for exec
CMD ["tail", "-f", "/dev/null"]
