#!/bin/bash
##########
# NCAT Chat Client
hm=$(hostname)
host=$1
port=$2
cuser=$(echo $(whoami))
dir=/home/$cuser/.cryptchat
crt="/home/$cuser/.cryptchat/ca.pem"

control_c() {
    ncat -e "/bin/echo $name has disconnected" --ssl-verify --ssl-trustfile $crt $host $port
    echo "Thank you for using ssl chat. Goodbye."
    exit
}

trap control_c SIGINT


function start(){

if [[ ! -d  $dir ]];then
  mkdir $dir
  chmod 700 $dir
fi

# generate a new cert and key with this command : \
# FILENAME=chat
# openssl genrsa -out $FILENAME.key 1024 \
# openssl req -new -key $FILENAME.key -x509 -days 3653 -out $FILENAME.crt


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

chmod 600 $crt

#ncat --ssl-verify --ssl-trustfile $crt $host $port


 trap control_c SIGINT
echo -n "Enter an alias: " ; read name
        echo "Your idenitifier will be: $name"
        echo "Connecting to $host on port $port... Press CTRL+C to kill program and exit chat..."
	ncat -e "/bin/echo Incoming connection from host $hm" --ssl-verify --ssl-trustfile $crt $host $port
        while true; do
                read -p ">> " message
                echo -e "[$name@$hm:] $message "
        done | ncat --ssl-verify --ssl-trustfile $crt $host $port

}




start

exit

