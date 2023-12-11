#!/bin/bash

curl https://ollama.ai/install.sh | sh
ollama serve
ollama pull codellama
ollama pull mistral
