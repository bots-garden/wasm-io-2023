#!/bin/bash
COL='[0;31m'
NC='[0m'
echo -e "${COL}java -jar target/java-host-0.0.0-SNAPSHOT.jar${NC}"
java -jar target/java-host-0.0.0-SNAPSHOT.jar
