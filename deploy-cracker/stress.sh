#!/bin/bash
set -o allexport; source deploy.config; set +o allexport

#curl -X POST http://${APPLICATION_NAME}.${DNS} -d 'Jane Doe'; echo ""

hey -n 1000 -c 50 -m POST \
-d 'Jane Doe' \
"http://${APPLICATION_NAME}.${DNS}"