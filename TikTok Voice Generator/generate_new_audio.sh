#!/bin/bash

# Outline:
# Play file.
# Write Text.
# Send text as curl.
# Write that to a temp file.
# Convert that to the new file.

# One last prompt.
echo "Ready to begin?"
read

for file in ./*mp3
do
  # Reading our file.
  echo "Starting $file..."
  ffplay -v quiet -autoexit $file
  
  # Asking the user to write text.
  echo "Write the dialogue:"
  read user_interpet
  
  # Sending the curl request.
  curl -X POST -H "Content-Type: application/json" -d "{\"text\":\"${user_interpet}\",\"voice\":\"en_us_001\"}" "https://tiktok-tts.weilnet.workers.dev/api/generation" | jq .data | base64 -di > temp.mp3
  
  # Playing that new file.
  ffplay -v quiet -autoexit temp.mp3
  
  # Writing that to a new file.
  ffmpeg -i temp.mp3 -ar 44100 "out\\$file"
done

rm temp.mp3

read
