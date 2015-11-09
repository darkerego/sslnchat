#!/bin/bash
# Connect with:
# ncat --ssl-verify --ssl-trustfile server.pem 127.0.0.1 5555
#############################################################


host=$1
port=$2
cuser=$(echo $(whoami))
xuser=$cuser
dir=/home/$cuser/.cryptchat
crt="/home/$xuser/.cryptchat/a.pem"
key="/home/$xuser/.cryptchat/a.key"

function genKeys(){

if [[ ! -d $dir ]];then
	mkdir $dir
	echo created
fi



# generate a new cert and key with this command : \
# FILENAME=chat
# openssl genrsa -out $FILENAME.key 1024 \
# openssl req -new -key $FILENAME.key -x509 -days 3653 -out $FILENAME.crt

# (THIS IS AN EXAMPLE CERTIFICATE&KEY! GENERATE YOUR OWN!)
cat << _EOF_ > $crt
-----BEGIN CERTIFICATE-----
MIICmjCCAgOgAwIBAgIJALpDG7IGGQf4MA0GCSqGSIb3DQEBCwUAMGYxCzAJBgNV
BAYTAlVTMQswCQYDVQQIDAJDQTEVMBMGA1UEBwwMV2hlcmV2ZXIgbWFuMRIwEAYD
VQQKDAlTdHVmZiBJbmMxCzAJBgNVBAsMAklUMRIwEAYDVQQDDAkxMjcuMC4wLjEw
HhcNMTUxMTA4MDM0MTQ4WhcNMjUxMTA4MDM0MTQ4WjBmMQswCQYDVQQGEwJVUzEL
MAkGA1UECAwCQ0ExFTATBgNVBAcMDFdoZXJldmVyIG1hbjESMBAGA1UECgwJU3R1
ZmYgSW5jMQswCQYDVQQLDAJJVDESMBAGA1UEAwwJMTI3LjAuMC4xMIGfMA0GCSqG
SIb3DQEBAQUAA4GNADCBiQKBgQDJ7va5iyeTyCb6V6BebB+4aWXwgPni8BDrDI7A
HqWCocBY2GHgpXkT1Ncs5qMsd4UfZV13KJuFkLE8jSodKpUbOwSCmxUZ47a3gIzP
l+cq6rfsIWK/ZVEk2/vnbInWfMcZAllwoK9bvk5U9OFfVpuBAs/wrieFkKuKeljj
xkI+zwIDAQABo1AwTjAdBgNVHQ4EFgQUxKYRj0aoXWYD1T3NwwNSmieN6pUwHwYD
VR0jBBgwFoAUxKYRj0aoXWYD1T3NwwNSmieN6pUwDAYDVR0TBAUwAwEB/zANBgkq
hkiG9w0BAQsFAAOBgQChufO4S1sJJJbpG6RaZk4WDoUe6Tht9O7TqWEorsjAIaDU
gMEqUoUDE/kYPesfEGuDV/3wViYrY8cVWFw7dzNTr0ZLo27EINJY1/BcZGoQq8hr
zzT4FqalEF9ba38hCQ4cVwKkqOwmSj9k4YiUp7lLWQxrtJyHkErTRmrBNaw1Vg==
-----END CERTIFICATE-----
_EOF_

cat << _EOF_ > $key
-----BEGIN RSA PRIVATE KEY-----
MIICWwIBAAKBgQDJ7va5iyeTyCb6V6BebB+4aWXwgPni8BDrDI7AHqWCocBY2GHg
pXkT1Ncs5qMsd4UfZV13KJuFkLE8jSodKpUbOwSCmxUZ47a3gIzPl+cq6rfsIWK/
ZVEk2/vnbInWfMcZAllwoK9bvk5U9OFfVpuBAs/wrieFkKuKeljjxkI+zwIDAQAB
AoGAFzkdNM91GMDPAsFrFxDWQQ4WBCfBFUFIoM+L5zpfDHvvtAgGkaBWIVq7+FT5
9RY1wBuXOSn5YM34JB+T9VC9XvUEvWy/XbcyPZkzjleVOH+DyGncDRHjZcC+tlh5
RyUQXVIJQJP8MiFi0aVIc/enbondpjwSWHQOk0A/i87uDqECQQDpo1fIZ8V9ee+h
VGHqRY5KWBCw72Iq9SCDfnOiZIyhLEoFXcbte92D4KHpYNiefEMPG6Jwow8UURgg
nIWrM+5/AkEA3ULJbTHHy8M5Z43EFRsayMi+9EGJ7dGVrit9ZUe1cySG1NDpwFqE
DPM3vufo17sJVDHW9kWBpZY3SkEamXsnsQJAOsTInvNjXOWgHj+ghZJLcW3nfOoq
Ek4oiIr1QULzkNMYJ3NoR3JhzPtjHtYqhusQ3yr/WD/b2itv2zwj72WXtwJAMA/9
6TZTDDQQGCp3WY5Vtx/EOxKxf3NzbC4OQx3ckHJyx2/KFvqSjK2YgmOl9JawZBWf
eEeI7gs/X2Xc/VH/QQJALfpJY0yD3L0BjYbn9Rz89qh6fPmes5kBjx/p7dxl//lz
gsiG1wLBezuJF/D9dgg3U1yWxomK0iTMjflNFNgWBg==
-----END RSA PRIVATE KEY-----
_EOF_
chmod 600 $crt
chmod 600 $key
}

function start(){
#service tor start
#sleep 5
ncat --broker --listen --ssl --ssl-cert $crt --ssl-key $key $host $port
sleep 30
}


echo Getting ready...
genKeys
echo Starting server...
start

