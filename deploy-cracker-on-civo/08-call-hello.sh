#!/bin/bash
set -o allexport; source .go.config; set +o allexport

echo "http://${APPLICATION_NAME}.${DNS}"

curl -X POST http://${APPLICATION_NAME}.${DNS} -d 'Jane Doe'; echo ""
curl -X POST http://${APPLICATION_NAME}.${DNS} -d 'John Doe'; echo ""
curl -X POST http://${APPLICATION_NAME}.${DNS} -d 'Bob Morane'; echo ""

