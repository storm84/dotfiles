#!/bin/bash

light=$1
# Infinite loop
while true; do
    # Generate random values for the parameters
    random_hue=$(shuf -i 0-359 -n 1)       # Random integer between 0 and 359
    random_brightness=$(awk -v min=0.5 -v max=1 'BEGIN{srand(); print min + rand() * (max - min)}')

    # Run the command with the random values
    dig-cli devices lights set-light-color "$light" "$random_hue" "$random_brightness"

    # Generate a random sleep time between 300 and 2000 milliseconds
    sleep_time=$(awk -v min=0.3 -v max=1.0 'BEGIN{srand(); print min + rand() * (max - min)}')

    # Sleep for the generated random time
    sleep $sleep_time
done
