#!/bin/bash
# video
xrandr --output VGA-1 --mode 1366x768 --pos 0x312 --rotate normal --output DVI-1-0 --primary --mode 1920x1080 --pos 1366x0 --rotate normal
#tamanho do mouse
gsettings set org.gnome.desktop.interface cursor-size 64
echo "...........feito + mouse  ............."
