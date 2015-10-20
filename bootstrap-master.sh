#!/bin/bash

#export https_proxy=https://proxy.company.com:8080
#export http_proxy=http://proxy.company.com:8080

sudo -E apt-get update
sudo -E apt-get install -y unzip python-pip python-virtualenv python-dev
sudo -E pip install ansible

chmod 600 /home/vagrant/.ssh/id_rsa

### heat is an orchestration option to provision in OpenStack ###
# create python virtualenv in ~/venv
virtualenv venv
chown -R vagrant:vagrant venv
# install heat client
apt-get install -y libffi-dev libssl-dev
/home/vagrant/venv/bin/pip install python-heatclient python-openstackclient pyopenssl ndg-httpsclient pyasn1
# setup environment to connect to openstack using heat
#source venv/bin/activate
#source hadoop-Project-openrc.sh
# update heat-hadoop-cluster.yaml
#openstack image list
#openstack network list
#openstack security group list
#openstack keypair list
#openstack flavor list
# update proxy details in group_vars/all
# update remote user in playbook.yml
# update ansible_ssh_(user|private_key_file) in heat-inventory.py
# update the subnet for your private network in heat-hadoop-cluster.yaml
#neutron subnet-list
#heat stack-create hadoop-stack -f heat-hadoop-cluster.yaml
#heat output-show hadoop-stack hadoop_master_public_ip 2>&1 | grep -o '[^"]*'
#cp hosp-watrous.pem ~/.ssh/
#ssh -i ~/.ssh/hosp-watrous.pem ubuntu@[hadoop_master_public_ip]
#python heat-inventory.py

#cd ~/src
#ansible-playbook -i hosts-dev playbook.yml

#sudo su - hadoop
#hdfs namenode -format
#/usr/local/hadoop/sbin/start-dfs.sh
#hdfs dfsadmin -report
#/usr/local/hadoop/sbin/start-yarn.sh
#/usr/local/hadoop/sbin/stop-dfs.sh
#/usr/local/hadoop/sbin/stop-yarn.sh
#$HADOOP_HOME/sbin/slaves.sh jps
#hadoop jar /usr/local/hadoop/share/hadoop/mapreduce/hadoop-mapreduce-examples-2.7.1.jar pi 10 30
