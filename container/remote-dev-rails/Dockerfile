FROM ghcr.io/nikkomiu/dotfiles/remote-dev:main

ARG NODE_VERSION=22
ARG RUBY_VERSION=3.4.5

# Install OS Dependencies
RUN sudo apt-get install -y \
    # Ruby build dependencies
    build-essential autoconf libssl-dev libyaml-dev zlib1g-dev libffi-dev libgmp-dev rustc

# Install NVM
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash

# Install Node.js
ENV NVM_DIR=/home/coder/.nvm
RUN . $HOME/.nvm/nvm.sh && \
    nvm install $NODE_VERSION && \
    nvm use $NODE_VERSION

# Install Rbenv and Ruby
RUN git clone https://github.com/rbenv/rbenv.git ~/.rbenv && \
    export PATH="$HOME/.rbenv/bin:$PATH" && \
    eval "$(rbenv init -)" && \
    git clone https://github.com/rbenv/ruby-build.git "$(rbenv root)"/plugins/ruby-build && \
    rbenv install $RUBY_VERSION
