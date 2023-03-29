#!/bin/bash
COL='\033[0;31m'
NC='\033[0m'
echo -e "${COL}wasmer hello.wasm \"Bob Morane\"${NC}"
wasmer hello.wasm "Bob Morane"
