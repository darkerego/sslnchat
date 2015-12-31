#!/bin/sh
# Generate openssl cert&key for use with sslnchat
#
#
#
FILENAME=server
 openssl genrsa -out $FILENAME.key 1024 
 openssl req -new -key $FILENAME.key -x509 -days 3653 -out $FILENAME.crt 
  cat $FILENAME.key $FILENAME.crt >$FILENAME.pem 
 chmod 600 $FILENAME.key 
 chmod 600 $FILENAME.crt
 FILENAME=client
 openssl genrsa -out $FILENAME.key 1024 
 openssl req -new -key $FILENAME.key -x509 -days 3653 -out $FILENAME.crt 
  cat $FILENAME.key $FILENAME.crt >$FILENAME.pem 
 chmod 600 $FILENAME.key 
 chmod 600 $FILENAME.crt
 
echo "Done. Edit server & client script to include new certificates."
