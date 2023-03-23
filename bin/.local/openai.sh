#!/bin/sh

# Set up your OpenAI API key by adding it to the openaikey file
export OPENAI_API_KEY=$(cat ~/openaikey)

read -p "ask to gpt3.5-turbo:" prompt
echo ===============
 curl -s https://api.openai.com/v1/chat/completions -H "Content-Type: application/json" -H "Authorization: Bearer $OPENAI_API_KEY" -d '{
    "model": "gpt-3.5-turbo",
    "messages": [{"role": "user", "content": "'"$prompt"'"}]
  }' | jq -r ".choices[0].message.content"
