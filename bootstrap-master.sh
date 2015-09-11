#!/bin/bash

export https_proxy=https://proxy.houston.hp.com:8080
export http_proxy=http://proxy.houston.hp.com:8080

apt-get update
sudo apt-get install -y unzip python-pip python-dev
sudo pip install ansible

chmod 600 /home/vagrant/.ssh/id_rsa

#cd ~/src
#ssh-keyscan -H 192.168.52.4 >> ~/.ssh/known_hosts
#ssh-keyscan -H 192.168.52.6 >> ~/.ssh/known_hosts
#ansible-playbook -i hosts-dev playbook.yml

#sudo su - hadoop
#ssh-keyscan -H 192.168.51.4 >> ~/.ssh/known_hosts
#ssh-keyscan -H 192.168.52.4 >> ~/.ssh/known_hosts
#ssh-keyscan -H 192.168.52.6 >> ~/.ssh/known_hosts
#hdfs namenode -format
#/usr/local/hadoop/sbin/start-all.sh
#jps
#hadoop jar /usr/local/hadoop/share/hadoop/mapreduce/hadoop-mapreduce-examples-2.7.1.jar pi 10 30
