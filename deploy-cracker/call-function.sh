#!/bin/bash
set -o allexport; source deploy.config; set +o allexport

curl -X POST http://${APPLICATION_NAME}.${DNS} -d 'Jane Doe'; echo ""
curl -X POST http://${APPLICATION_NAME}.${DNS} -d 'John Doe'; echo ""
curl -X POST http://${APPLICATION_NAME}.${DNS} -d 'Bob Morane'; echo ""
