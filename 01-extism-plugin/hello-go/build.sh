#!/bin/bash
COL='[0;31m'
NC='[0m'
echo -e "${COL}tinygo build -scheduler=none --no-debug -o hello-go.wasm -target wasi main.go${NC}"
tinygo build -scheduler=none --no-debug -o hello-go.wasm -target wasi main.go
echo -e "${COL}ls -lh *.wasm${NC}"
ls -lh *.wasm