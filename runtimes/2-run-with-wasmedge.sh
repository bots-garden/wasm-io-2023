#!/bin/bash
COL='\033[0;31m'
NC='\033[0m'
echo -e "${COL}wasmedge ./hello/hello.wasm \"Jane Doe\"${NC}"

wasmedge ./hello/hello.wasm "Jane Doe"
