#!/bin/bash
COL='[0;31m'
NC='[0m'
echo -e "${COL}extism call --input \"😀 Hello WASM.IO 2023! (from TinyGo)\" ./hello-go.wasm say_hello --wasi"
echo -e "--config route=https://jsonplaceholder.typicode.com/todos/3${NC}"
echo ""
extism call --input "😀 Hello WASM.IO 2023! (from TinyGo)" ./hello-go.wasm say_hello --wasi \
  --config route=https://jsonplaceholder.typicode.com/todos/3
echo ""
echo ""