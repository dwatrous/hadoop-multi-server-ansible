#-------------------------------------------------------------------------------
# Name:        heat_inventory
# Purpose:
#
# Author:      Daniel Watrous
#
# Created:     10/07/2015
# Copyright:   (c) HP 2015
#-------------------------------------------------------------------------------
#!/usr/bin/python

import json
from string import Template
from textwrap import dedent
import subprocess

class heat_inventory:

    # output keys
    hadoop_master_public_key = "hadoop_master_public_ip"
    hadoop_master_private_key = "hadoop_master_private_ip"
    hadoop_datanode_public_key = "nodes_public_ips"
    hadoop_datanode_private_key = "nodes_private_ips"

    # template values
    ansible_ssh_user = "debian"
    ansible_ssh_private_key_file = "~/.ssh/hadoop.pem"

    # templates
    host_entry = Template('$ipaddress             ansible_connection=ssh  ansible_ssh_user=$ssh_user   ansible_ssh_private_key_file=$private_key_file')
    hosts_output = Template("""[hadoop-master]
$master_host

[hadoop-data]
$data_hosts

[hadoop-master:vars]
nodesfile=nodes-pro

[hadoop-data:vars]
nodesfile=nodes-pro""")

    node_entry = Template("""  - hostname: $hostname
    ip: $ipaddress""")
    nodes_section = Template("""---
nodes:
$nodes
    """)
    nodes_sshkeyscan = Template('ssh-keyscan -t rsa $ipaddress >> ~/.ssh/known_hosts')

    def __init__(self):
        self.load_heat_output()

    def load_heat_output(self):
        self.heat_output = json.loads(subprocess.Popen("heat output-show hadoop-stack --all", shell=True, stdout=subprocess.PIPE).stdout.read())

    def get_master_public_ip(self):
        for output_item in self.heat_output:
            if self.hadoop_master_public_key == output_item['output_key']:
                return output_item['output_value']

    def get_master_private_ip(self):
        for output_item in self.heat_output:
            if self.hadoop_master_private_key == output_item['output_key']:
                return output_item['output_value']

    def get_datanode_public_ips(self):
        for output_item in self.heat_output:
            if self.hadoop_datanode_public_key == output_item['output_key']:
                return output_item['output_value']

    def get_datanode_private_ips(self):
        for output_item in self.heat_output:
            if self.hadoop_datanode_private_key == output_item['output_key']:
                return output_item['output_value']

    # Ansible hosts file
    def get_host_entry(self, ipaddress):
        return self.host_entry.substitute(ipaddress=ipaddress, ssh_user=self.ansible_ssh_user, private_key_file=self.ansible_ssh_private_key_file)

    def get_datanode_host_entries(self):
        datanode_hosts = []
        for datanode_host in self.get_datanode_public_ips():
            datanode_hosts.append(self.get_host_entry(datanode_host[0]))
        return "\n".join(datanode_hosts)

    def get_hosts_output(self):
        master_host = self.get_host_entry(self.get_master_public_ip())
        datanode_hosts = self.get_datanode_host_entries()
        return dedent(self.hosts_output.substitute(master_host=master_host, data_hosts=datanode_hosts))

    # Ansible group_vars nodes
    def get_node_entry(self, hostname, ipaddress):
        return self.node_entry.substitute(hostname=hostname, ipaddress=ipaddress)

    def get_nodes_entries(self):
        nodes = []
        nodes.append(self.get_node_entry('hadoop-master', self.get_master_private_ip()))
        for node in self.get_datanode_private_ips():
            nodes.append(self.get_node_entry(node[1], node[0]))
        return "\n".join(nodes)

    def get_nodes_output(self):
        return self.nodes_section.substitute(nodes=self.get_nodes_entries())

    def get_node_keyscan_script(self):
        nodes = []
        nodes.append(self.nodes_sshkeyscan.substitute(ipaddress=self.get_master_public_ip()))
        for node in self.get_datanode_public_ips():
            nodes.append(self.nodes_sshkeyscan.substitute(ipaddress=node[0]))
        return "\n".join(nodes)

def main():
    heat_inv = heat_inventory()
##    print "hadoop master public IP: " + heat_inv.get_master_public_ip()
##    print "hadoop master private IP: " + heat_inv.get_master_private_ip()
##    print "hadoop datanode private IP: " + ', '.join(heat_inv.get_datanode_private_ips())
##    print "hadoop datanode public IP: " + ', '.join(heat_inv.get_datanode_public_ips())
    inventory_file = open('hosts-pro', 'w')
    nodes_file = open('nodes-pro', 'w')
    inventory_file.write(heat_inv.get_hosts_output())
    nodes_file.write(heat_inv.get_nodes_output())
    inventory_file.close()
    nodes_file.close()
    keyscan_script_file = open('scan-node-keys.sh', 'w')
    keyscan_script_file.write(heat_inv.get_node_keyscan_script())
    keyscan_script_file.close()

if __name__ == '__main__':
    main()

