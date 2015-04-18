#!/bin/sh

sudo mkdir /etc/keys
sudo chmod 700 /etc/keys
sudo aws --region us-east-1 s3 cp s3://teamunpro/unpro-salt/teamunpro_deploy_id_rsa /etc/keys/teamunpro_deploy_id_rsa
sudo aws --region us-east-1 s3 cp s3://teamunpro/unpro-salt/teamunpro_deploy_id_rsa.pub /etc/keys/teamunpro_deploy_id_rsa.pub
sudo chmod 600 /etc/keys/teamunpro_deploy_id_rsa
