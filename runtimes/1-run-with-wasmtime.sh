#!/bin/bash
COL='\033[0;31m'
NC='\033[0m'
echo -e "${COL}wasmtime ./hello/hello.wasm \"Jane Doe\"${NC}"
wasmtime ./hello/hello.wasm "Jane Doe"
