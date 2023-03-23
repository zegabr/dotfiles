#!/bin/sh
# used chatgpt to create 99% of this script
# Set up your OpenAI API key by adding it to the openaikey file
export OPENAI_API_KEY=$(cat ~/openaikey)

# Choose the GPT-3 model to use
model="gpt-3.5-turbo"

read -p "just ask me: " prompt
# Generate text using GPT-3
response=$(curl -X POST https://api.openai.com/v1/completions \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $OPENAI_API_KEY" \
  -d '{
    "model": "'"$model"'",
    "prompt": "'"$prompt"'",
    "temperature": 0.9,
    "max_tokens": 4000,
    "frequency_penalty": 0,
    "presence_penalty": 0
  }'
)

# Print the generated text
echo $response | jq -r ".choices[].text"
