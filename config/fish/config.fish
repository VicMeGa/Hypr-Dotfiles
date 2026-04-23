if status is-interactive
    # Commands to run in interactive sessions can go here
	neofetch
end

set -x XCURSOR_PATH $XCURSOR_PATH ~/.local/share/icons/:~/.icons/:/usr/share/icons/
# set -x XCURSOR_SIZE 64
# set -x XCURSOR_THEME Furina-v2

# Alias comunes
alias OnTailscale="sudo systemctl start tailscaled"
alias OffTailscale="sudo systemctl stop tailscaled"
alias OnDocker="sudo systemctl start docker"
alias OffDocker="sudo systemctl stop docker"
alias OnPython="source /home/victor/mi_python/bin/activate.fish"
alias OffPython="deactivate"
alias OnMariadb="sudo systemctl start mariadb"
alias OffMariadb="sudo systemctl stop mariadb"
alias gg="reboot"

# ASUS RGB profiles
alias gamer="asusctl aura static -c ff0000"
alias chill="asusctl aura static -c ffffff"
alias dark="asusctl -k off"

# Android configuration
#set -gx ANDROID_HOME /home/victor/Android/Sdk
#set -gx PATH $PATH /home/victor/Android/Sdk/platform-tools
#set -gx PATH $PATH /home/victor/Android/Sdk/tools
#set -gx PATH $PATH /home/victor/Android/Sdk/emulator
#set -gx PATH $PATH /opt/android-studio/bin
