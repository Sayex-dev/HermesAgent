FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y \
    git \
    curl \
    ca-certificates \
    xz-utils \
    && rm -rf /var/lib/apt/lists/*

RUN install gh

RUN curl -fsSL https://raw.githubusercontent.com/NousResearch/hermes-agent/main/scripts/install.sh | bash

ENV PATH="/root/.local/bin:/usr/local/bin:/root/.hermes/node/bin:${PATH}"
ENV HERMES_HOME=/root/.hermes

WORKDIR /usr/local/lib/hermes-agent
RUN if [ -d "web" ]; then \
    cd web && \
    npm install && \
    npm run build; \
    fi

WORKDIR /root

EXPOSE 9119

CMD ["hermes"]