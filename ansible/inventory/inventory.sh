#!/bin/bash
set -e

if [[ "$1" == "--list" ]]; then
   IPLIST=$(terraform -chdir="../terraform/02_compute" output -json ec2_public_ip)
   jq -n --argjson ips "$IPLIST" '{
      servers: {
         hosts: $ips
      }
   }'
else
   echo "{}"
fi
