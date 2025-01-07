#!/bin/bash

light=$1
interval=$2

# Initialize the value
value=100

# Loop indefinitely
while true; do
  # Run the command with the current value
  dig-cli devices lights set-light-level $light "$value" 0
  
  # Toggle the value between 100 and 1
  if [ "$value" -eq 100 ]; then
    value=1
  else
    value=100
  fi
  
  # Sleep for 500ms
  sleep $interval
done
