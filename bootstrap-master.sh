#!/bin/bash

#export https_proxy=https://proxy.company.com:8080
#export http_proxy=http://proxy.company.com:8080

sudo -E apt-get update
sudo -E apt-get install -y unzip python-pip python-dev
sudo -E pip install ansible

chmod 600 /home/vagrant/.ssh/id_rsa

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
