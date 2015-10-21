#!/bin/bash

#export https_proxy=https://proxy.company.com:8080
#export http_proxy=http://proxy.company.com:8080

sudo -E apt-get update
sudo -E apt-get install -y unzip python-pip python-virtualenv python-dev
sudo -E pip install ansible

chmod 600 /home/vagrant/.ssh/id_rsa

### Use heat (an orchestration tool to provision in OpenStack) to prepare servers for Hadoop ###
# create python virtualenv in ~/venv
virtualenv venv
chown -R vagrant:vagrant venv
# install heat client
apt-get install -y libffi-dev libssl-dev
/home/vagrant/venv/bin/pip install python-heatclient python-openstackclient pyopenssl ndg-httpsclient pyasn1
# setup environment to connect to openstack using heat
#source ~/venv/bin/activate
#cd ~/src
#source hadoop-Project-openrc.sh
# update heat-hadoop-cluster.yaml
#openstack keypair list
#openstack image list
#openstack flavor list
#openstack network list
#openstack security group list
# update proxy details in group_vars/all
# update remote user in playbook.yml
# update ansible_ssh_(user|private_key_file) in heat-inventory.py
#heat stack-create hadoop-stack -f heat-hadoop-cluster.yaml
#heat output-show hadoop-stack hadoop_master_public_ip 2>&1 | grep -o '[^"]*'
#cp hadoop.pem ~/.ssh/
#chmod 600 ~/.ssh/hadoop.pem
#python heat-inventory.py
#source scan-node-keys.sh
### End heat ###

#ansible-playbook -i hosts-dev playbook.yml
## --OR-- ##
#ansible-playbook -i hosts-pro playbook.yml

# for openstack, first login to the master before running the remaining commands
#ssh -i ~/.ssh/hadoop.pem ubuntu@[hadoop_master_public_ip]

#sudo su - hadoop
#hdfs namenode -format
#/usr/local/hadoop/sbin/start-dfs.sh
#hdfs dfsadmin -report
#/usr/local/hadoop/sbin/start-yarn.sh
#/usr/local/hadoop/sbin/stop-dfs.sh
#/usr/local/hadoop/sbin/stop-yarn.sh
#$HADOOP_HOME/sbin/slaves.sh jps
#hadoop jar /usr/local/hadoop/share/hadoop/mapreduce/hadoop-mapreduce-examples-2.7.1.jar pi 10 30
