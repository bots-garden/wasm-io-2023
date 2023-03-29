#!/bin/bash
set -o allexport; source .go.config; set +o allexport


hey -n 1000 -c 50 -m POST \
-d 'Jane Doe' \
"http://${APPLICATION_NAME}.${DNS}"

