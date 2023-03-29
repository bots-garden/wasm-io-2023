#!/bin/bash
COL='\033[0;31m'
NC='\033[0m'
echo -e "${COL}tinygo build -scheduler=none --no-debug -o hello.wasm -target wasi ./main.go${NC}"

tinygo build -scheduler=none --no-debug -o hello.wasm -target wasi ./main.go

echo -e "${COL}ls -lh *.wasm${NC}"

ls -lh *.wasm
