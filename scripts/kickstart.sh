#!/usr/bin/env bash

# Run me with:
#
# bash <(curl -Ss raw.githubusercontent.com/01-edu/public/master/scripts/kickstart.sh)

# Treat unset variables as an error when substituting.
set -u

# Exit immediately if a command exits with a non-zero status.
set -e

# Set the variable corresponding to the return value of a pipeline is the status
# of the last command to exit with a non-zero status, or zero if no command
# exited with a non-zero status
set -o pipefail

# Separate tokens on newlines only
IFS='
'

# The value of this parameter is expanded like PS1 and the expanded value is the
# prompt printed before the command line is echoed when the -x option is set
# (see The Set Builtin). The first character of the expanded value is replicated
# multiple times, as necessary, to indicate multiple levels of indirection.
# \D{%F %T} prints date like this : 2019-12-31 23:59:59
PS4='-\D{%F %T} '

# Print commands and their arguments as they are executed.
set -x

# Skip dialogs during apt-get install commands
export DEBIAN_FRONTEND=noninteractive # DEBIAN_PRIORITY=critical

gsettings set org.gnome.desktop.session idle-delay 0
gsettings set org.gnome.desktop.screensaver lock-enabled false

cd
wget github.com/01-edu/public/archive/master.zip
unzip master.zip

cd public-master/scripts
sudo -E ./install_client.sh
cat dconfig.txt | dconf load /

cd
rm -rf master.zip public-master
reboot