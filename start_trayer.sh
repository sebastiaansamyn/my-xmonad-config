#!/bin/bash

pid=$(pidof trayer)

if ! [ -z $pid ] 
then 
  echo "Killing process with pid $pid"
  kill $pid 
fi

echo Starting trayer...

if trayer --align right --SetDockType true --SetPartialStrut true --height 15 --tint 0x444444 --transparent true --alpha 0 $* &
then 
  echo Started trayer.
else
  echo Failed to start trayer: retval $?
fi
