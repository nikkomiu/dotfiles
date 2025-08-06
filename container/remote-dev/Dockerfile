FROM debian

# Install dependencies
RUN apt-get update && \
    apt-get install -y curl wget sudo zsh git locales locales-all && \
    locale-gen

# Install chezmoi
RUN sh -c "$(curl -fsLS get.chezmoi.io)" -- -b /usr/local/bin

# Install VS Code CLI
RUN wget -O vscode.tar.gz "https://code.visualstudio.com/sha/download?build=stable&os=cli-alpine-x64" && \
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

# Set up Oh My Zsh
RUN sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" && \
    sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="agnoster"/g' ~/.zshrc && \
    sed -i 's/plugins=(git)/plugins=(git npm)/g' ~/.zshrc && \
    echo "DISABLE_UPDATE_PROMPT=true" >> ~/.zshrc

ENTRYPOINT [ "docker-entrypoint" ]

LABEL org.opencontainers.image.source=https://github.com/nikkomiu/dotfiles
LABEL org.opencontainers.image.description="Remote Development Environment"
