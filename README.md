# Hadoop multi-node cluster with Ansible
Multi-server deployment of Hadoop using Ansible

This repository contains a set of Vagrant and Ansible scripts that make it fast and easy to build a fully functional Hadoop cluster, including HDFS, on a single computer using VirtualBox. In order to run the scripts as they are, you will probably need about 16GB RAM and at least 4 CPUs.

## Quick Start (Local)

 - Clone this repository
 - (optional) Download a binary release of hadoop (e.g. http://www.apache.org/dyn/closer.cgi/hadoop/common/hadoop-2.7.1/hadoop-2.7.1.tar.gz) and saved it to `roles/common/templates/hadoop-2.7.1.tar.gz` then update `roles/common/tasks/main.yml` to use the alternative approach
 - Open a command prompt to the directory where you cloned the code
 - Run `vagrant up`
 - Use the commented lines in `bootstrap-master.sh` to do the following
   - Run the ansible playbook: `ansible-playbook -i hosts-dev playbook.yml`
   - Format the HDFS namenode
   - Start DFS and YARN
   - Run an example job: `hadoop jar /usr/local/hadoop/share/hadoop/mapreduce/hadoop-mapreduce-examples-2.7.1.jar pi 10 30`   

### Additional Details and Explanation

I wrote up a detailed article about how to understand and run these scripts. This includes the expected output and instructions to modify the process to accommodate proxy environments and low RAM environments. You can find that here:

http://software.danielwatrous.com/install-and-configure-a-multi-node-hadoop-cluster-using-ansible/

## Quick Start (OpenStack)
 - Clone this repository
 - Open a command prompt to the directory where you cloned the code
 - Edit the Vagrantfile and remove the unused datanodes. You may also reduce the memory for the master, which will become your Ansible host.
 - Run `vagrant up` (this sets up the virtualenv for openstack connectivity)
 - Use the commented lines in `bootstrap-master.sh` to do the following
   - Enter the virtualenv with `source ~/venv/bin/activate`
   - Download openrc from OpenStack file and source to establish your environment
   - Use openstack CLI to gather details and update `heat-hadoop-cluster.yaml`
     - Update other files for proxy, usernames, etc. if necessary
     - Run `heat stack-create hadoop-stack -f heat-hadoop-cluster.yaml` and other connectivity commands
   - Run the ansible playbook: `ansible-playbook -i hosts-pro playbook.yml`
   - Format the HDFS namenode
   - Start DFS and YARN
   - Run an example job: `hadoop jar /usr/local/hadoop/share/hadoop/mapreduce/hadoop-mapreduce-examples-2.7.1.jar pi 10 30`   

