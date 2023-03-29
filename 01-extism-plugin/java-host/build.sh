#!/bin/bash
COL='[0;31m'
NC='[0m'
echo -e "${COL}LD_LIBRARY_PATH=/usr/local/lib mvn clean package${NC}"
LD_LIBRARY_PATH=/usr/local/lib mvn clean package
