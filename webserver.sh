#!/bin/bash

YELLOW='\033[43m'
GREEN='\033[42m'
NC='\033[0m'

echo -e "🚀 ${YELLOW}   Deploying webservers   ${NC}"

ansible-playbook webserver.yml -i hosts.yml

echo -e "✅ ${GREEN}   Webserver deployed   ${NC}"