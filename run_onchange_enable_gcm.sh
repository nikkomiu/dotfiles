#!/bin/bash

if which git-credential-manager > /dev/null &> /dev/null; then
  if [ "$(which git-credential-manager)" != "$(git config --get credential.helper)" ]; then
    git-credential-manager configure
  fi
fi
