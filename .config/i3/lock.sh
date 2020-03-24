#!/bin/bash
set -e
xset s off dpms 0 10 0
i3lock --fuzzy -o --nofork -r 40 -s 50
xset s off -dpms