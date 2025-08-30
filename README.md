# Dotfiles

This repository contains my dotfiles for various tools and configurations I use on different machines.

## Install

The dotfiles in the repo are (mainly) built using [chezmoi](https://www.chezmoi.io/). To install the
dotfiles using chezmoi, run the following command:

```bash
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply nikkomiu
```

## Data

```toml
[data]
# Email address (used by Git)
# email = "other.email@example.com"

# Configuration for the SSH Sign Key script
[data.ssh_sign]
# auth_path = "other-oidc"
# username = "other-user"
```
