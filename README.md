# Extend your Bash shell with custom tools
This is a collection of shell commands and tools that I designed for my personal use.

# Prerequisites
  - Linux distro or WLS2 (debian 11 recommended)
  - GNU Bash shell (version 5.1.4 recommended)
  - git (version 2.30.2 recommended)

# How to install
```bash
# clone the repo into your home directory
cd $HOME && git clone https://github.com/mulekick/.shell_extend.git
# run the shell update script
. .shell_extend/.shell_update.sh
```

# Shell update
  - When prompted to, type the absolute path to your command archive directory (place it somewhere under your ```$HOME```).
  - Your command archive directory will be automatically created if necessary.
  - Your ```.bashrc``` will then be automatically updated to export new aliases and environment variables at shell startup.
  - Restart your shell session, and you're done.

# Get started
  - Once setup is complete and shell restarted, type cmdhelp to view the list of [available custom commands](https://raw.githubusercontent.com/mulekick/.shell_extend/master/.scripts/README.md)