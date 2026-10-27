FROM jenkins/jenkins:lts
USER root
ARG TOFU_VERSION=1.9.0
RUN apt-get update \
 && apt-get install -y --no-install-recommends unzip curl git \
 && ARCH=$(dpkg --print-architecture) \
 && curl -fsSL -o /tmp/tofu.zip "https://github.com/opentofu/opentofu/releases/download/v${TOFU_VERSION}/tofu_${TOFU_VERSION}_linux_${ARCH}.zip" \
 && unzip /tmp/tofu.zip tofu -d /usr/local/bin \
 && rm -f /tmp/tofu.zip \
 && rm -rf /var/lib/apt/lists/* \
 && git config --system --add safe.directory '*'
