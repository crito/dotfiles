# Disable the beep
xset -b

# Start a D-Bus session
source /etc/X11/xinit/xinitrc.d/30-dbus
# Start GNOME Keyring
eval $(/usr/bin/gnome-keyring-daemon --start --components=gpg,pkcs11,secrets,ssh)
# You probably need to do this too:
export SSH_AUTH_SOCK
export GPG_AGENT_INFO
export GNOME_KEYRING_CONTROL
export GNOME_KEYRING_PID

xrdb -load ~/.Xresources &
xmodmap ~/.dotfiles/swapkeys &
unclutter -idle 5 &

[[ -f ~/.Xmodmap ]] && xmodmap ~/.Xmodmap

mpd &
dropboxd &

exec dbus-launch i3
