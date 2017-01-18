#!/usr/bin/env bash
revert() {
  xset dpms 600
}
trap revert SIGHUP SIGINT SIGTERM

xset dpms 5
i3lock -n -t -i /home/bas/.xmonad/lock-image.png
revert
