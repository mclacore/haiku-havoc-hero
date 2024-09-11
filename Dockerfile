FROM python:3.12-slim-bullseye

# Install needed tools
RUN apt update && apt install -y curl zip unzip redis

RUN apt install -y ca-certificates lsb-release && \
	install -d /usr/share/postgresql-common/pgdg && \
	curl -o /usr/share/postgresql-common/pgdg/apt.postgresql.org.asc --fail https://www.postgresql.org/media/keys/ACCC4CF8.asc && \
	sh -c 'echo "deb [signed-by=/usr/share/postgresql-common/pgdg/apt.postgresql.org.asc] https://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list' && \
	apt update && apt install -y postgresql

#TODO: Uncomment to install Azure CLI
# RUN curl -sL https://aka.ms/InstallAzureCLIDeb -o /tmp/azure-cli.sh && \
# 	chmod +x /tmp/azure-cli.sh && \
# 	/tmp/azure-cli.sh && \
# 	rm /tmp/azure-cli.sh

#TODO: Uncomment to install AWS CLI
# RUN curl https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip -o /tmp/awscliv2.zip && \
# 	unzip /tmp/awscliv2.zip -d /tmp && \
# 	/tmp/aws/install && \
# 	rm /tmp/awscliv2.zip

#TODO: Uncomment to install Google Cloud CLI
# RUN curl https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-cli-linux-x86_64.tar.gz -o /tmp/google-cloud-cli.tar.gz && \
# 	tar -xf /tmp/google-cloud-cli.tar.gz -C /tmp && \
# 	/tmp/google-cloud-sdk/install.sh --quiet --path-update true && \
# 	rm /tmp/google-cloud-cli.tar.gz
# ENV PATH=$PATH:/tmp/google-cloud-sdk/bin

# Install Heroku CLI
RUN curl https://cli-assets.heroku.com/install.sh -o /tmp/heroku.sh && \
	chmod +x /tmp/heroku.sh && \
	/tmp/heroku.sh && \
	rm /tmp/heroku.sh

# Cleanup
RUN rm -rf /var/lib/apt/lists/*

# Keep the container alive for exec
CMD ["tail", "-f", "/dev/null"]
