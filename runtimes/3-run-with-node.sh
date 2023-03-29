#!/bin/bash
COL='\033[0;31m'
NC='\033[0m'
echo -e "${COL}node --experimental-wasi-unstable-preview1 index.js${NC}"

node --experimental-wasi-unstable-preview1 index.js
