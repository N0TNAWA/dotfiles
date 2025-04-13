#!/usr/bin/env bash
for i in {1..5}; do
  text=$(curl -s "https://wttr.in/$1?format=1")
  if [[ $? == 0 ]]; then
    text=$(echo "$text" | sed -E "s/\s+/ /g")
    if [[ $? == 0 ]]; then

      numbers=$(echo "$text" | grep -oE '[0-9]+')

      if [[ "$numbers" -le 0 ]]; then
        if [[ $2 == "--tmp" ]]; then
          echo "$numbers"
        elif [[ $2 == "--txt" ]]; then
          echo "Don't catch a cold."
        elif [[ $2 == "--cdn" ]]; then
          echo "Freezing"
        fi

      elif [[ "$numbers" -lt 10 ]]; then
        if [[ $2 == "--tmp" ]]; then
          echo "$numbers"
        elif [[ $2 == "--txt" ]]; then
          echo "Put on a warm coat."
        elif [[ $2 == "--cdn" ]]; then
          echo "Cold"
        fi

      elif [[ "$numbers" -ge 10 ]]; then
        if [[ $2 == "--tmp" ]]; then
          echo "$numbers"
        elif [[ $2 == "--txt" ]]; then
          echo "Perfect temp for a walk."
        elif [[ $2 == "--cdn" ]]; then
          echo "Warm"
        fi

      else [[ "$numbers" -ge 15 ]];
        if [[ $2 == "--tmp" ]]; then
          echo "$numbers"
        elif [[ $2 == "--txt" ]]; then
          echo "Go out and hit some rails."
        elif [[ $2 == "--cdn" ]]; then
          echo "Hot"
        fi
      fi

      exit

    fi
  fi
  sleep 2
done
echo "{\"text\":\"error\", \"tooltip\":\"error\"}"
