#!/bin/bash
xrdb -merge ~/.Xresources
setxkbmap ch
conky -c ~/.config/conky/hw_conky.conf &
conky -c ~/.config/conky/clock_conky.conf &
compton --config ~/.config/compton.conf -b
exec awesome
