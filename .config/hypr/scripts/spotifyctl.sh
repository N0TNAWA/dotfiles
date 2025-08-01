#!/usr/bin/bash

pause_song() {
   command=$(playerctl play-pause --player spotify)

   echo $command
}

next_song() {
  command=$(playerctl next --player spotify)

  echo $command
}

previous_song() {
  command=$(playerctl previous --player spotify)

  echo $command
}

volume() {
  if [ "$1" = "-u" ]; then
    command=$(playerctl volume .05+ --player spotify)
    echo $command
  elif [ "$1" = "-d" ]; then
    command=$(playerctl volume .05- --player spotify)
    echo $command
  else
    echo "Not a valid command"
  fi
}

if [ "$1" == "--pause" ]; then
  pause_song
elif [ "$1" == "--next" ]; then
  next_song
elif [ "$1" == "--previous" ]; then
  previous_song
elif [ "$1" == "--volume" ]; then
  volume "$2"
else
  echo "Usage: $0 [--pause|--next|--previous|--volume -u|-d]"
fi
