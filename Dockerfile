FROM --platform=linux/amd64 python:3.12-slim-bullseye

# Install needed tools, psql, redis-cli, and Heroku CLI
RUN apt update && apt install -y curl unzip postgresql redis && \
	curl https://cli-assets.heroku.com/install.sh -o /tmp/heroku.sh && \
	chmod +x /tmp/heroku.sh && \
	./tmp/heroku.sh && \
	rm /tmp/heroku.sh

# Install Azure CLI
RUN curl -sL https://aka.ms/InstallAzureCLIDeb -o /tmp/azure-cli.sh && \
	chmod +x /tmp/azure-cli.sh && \
	./tmp/azure-cli.sh && \
	rm /tmp/azure-cli.sh

# Install AWS CLI
RUN curl https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip -o /tmp/awscliv2.zip && \
	unzip /tmp/awscliv2.zip && \
	./aws/install && \
	rm /tmp/awscliv2.zip

# Install Google Cloud CLI
RUN curl https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-cli-linux-x86_64.tar.gz -o /tmp/google-cloud-cli.tar.gz && \
	tar -xf /tmp/google-cloud-cli.tar.gz -C ./ && \
	./google-cloud-sdk/install.sh --quiet --path-update true && \
	rm /tmp/google-cloud-cli.tar.gz

# Cleanup
RUN rm -rf /var/lib/apt/lists/*

