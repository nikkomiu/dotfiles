FROM debian

ARG GO_VERSION=1.24.6
ARG NVM_VERSION=0.40.3
ARG GIT_CREDENTIAL_MANAGER_VERSION=2.6.1

ENV DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=1

# Install OS dependencies
RUN apt-get update && \
    apt-get install -y \
        # my base tooling for everything
        curl wget sudo zsh git \
        # needed for zsh to render correctly
        locales locales-all \
        # needed by vault install
        gnupg2 lsb-release && \
    locale-gen

# Install chezmoi globally
RUN sh -c "$(curl -fsLS get.chezmoi.io)" -- -b /usr/local/bin

# Install Go
RUN wget -qO go.tar.gz https://go.dev/dl/go$GO_VERSION.linux-amd64.tar.gz && \
    tar -xf go.tar.gz && \
    mv go /usr/local/go && \
    rm go.tar.gz && \
    echo "export PATH=\$PATH:/usr/local/go/bin" >> /etc/zsh/zshrc

# Install Vault CLI
RUN wget -qO - https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg && \
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(grep -oP '(?<=UBUNTU_CODENAME=).*' /etc/os-release || lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list && \
    sudo apt-get update && sudo apt-get install vault

# Install git credential manager
RUN wget -qO gcm.deb https://github.com/git-ecosystem/git-credential-manager/releases/download/v$GIT_CREDENTIAL_MANAGER_VERSION/gcm-linux_amd64.$GIT_CREDENTIAL_MANAGER_VERSION.deb && \
    dpkg -i gcm.deb && \
    rm -rf gcm.deb && \
    git-credential-manager configure --system && \
    echo "export GCM_CREDENTIAL_STORE=cache" >> /etc/zsh/zshrc

# Install VS Code CLI
RUN wget -qO vscode.tar.gz "https://code.visualstudio.com/sha/download?build=stable&os=cli-alpine-x64" && \
    tar -xf vscode.tar.gz && \
    mv code /usr/local/bin/code && \
    rm -rf vscode.tar.gz

# Copy the entrypoint script
COPY docker-entrypoint /usr/local/bin/docker-entrypoint
COPY reload-container /usr/local/bin/reload-container

# Create the user
RUN useradd -m --uid 1000 --shell /bin/zsh coder && \
    usermod -aG sudo coder && \
    echo "%sudo ALL=(ALL:ALL) NOPASSWD: ALL" > /etc/sudoers.d/sudo && \
    mkdir /workspaces && chown coder:coder /workspaces

USER coder

# Install NVM (user)
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v$NVM_VERSION/install.sh | bash

# Set up Oh My Zsh
RUN sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" && \
    sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="agnoster"/g' ~/.zshrc && \
    sed -i 's/plugins=(git)/plugins=(git npm)/g' ~/.zshrc && \
    echo "DISABLE_UPDATE_PROMPT=true" >> ~/.zshrc

ENTRYPOINT [ "docker-entrypoint" ]

LABEL org.opencontainers.image.source=https://github.com/nikkomiu/dotfiles
LABEL org.opencontainers.image.description="Remote Development Environment"
