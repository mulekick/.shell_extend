# Extend your Bash shell with custom tools
This is a collection of commands and tools that I desined to make my life easier when I'm using the Bash shell, which I do quite regularly.

# Prerequisites
  - Linux distro or WLS2 (debian 10.4.0 recommended)
  - GNU Bash shell (version 5.0.3 recommended)
  - git (version 2.20.1 recommended)

# How to install
  - cd $HOME
  - git clone git@github.com:mulekick/.shell_extend.git
  - . .shell_update.sh

# Installation
  - When prompted to, type the absolute path command archive directory (place it womewhere under your $HOME).
  - Your command archive directory will be automatically created if necessary.
  - Your .bashrc will then be automatically updated to export new environment variables at shell startup.
  - Restart your shell session, and it's all set up.

# Get started
  - Once setup is complete and shell restarted, type cmdhelp to view the list of [available custom commands](../.scripts/README.md)