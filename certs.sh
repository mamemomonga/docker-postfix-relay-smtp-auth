#!/bin/bash

DOMAIN_NAME=example.com
LETSENCRYPT_DIR=../letsencrypt

set -eu
mkdir -p certs
cp $LETSENCRYPT_DIR/etc/live/$DOMAIN_NAME/fullchain.pem certs/fullchain.pem
cp $LETSENCRYPT_DIR/etc/live/$DOMAIN_NAME/privkey.pem certs/privkey.pem

