from diagrams import Cluster, Diagram
from diagrams.aws.compute import EC2
from diagrams.aws.database import RDS
from diagrams.aws.network import ELB, VPCPeering
import json
import os
from pprint import pprint

## Opening the .tfstate file

with open('aws_terraform/terraform.tfstate') as json_file:
    tf_data = json.load(json_file)

#pprint(data)

r_names = []

## looping over the names

for x in tf_data['resources']:
    r_names.append(x['name'])

print("\nResources Name List: \n")

pprint(r_names)

app_vpc_name = r_names[r_names.index('dac_app_vpc')]
db_vpc_name = r_names[r_names.index('dac_db_vpc')]

app_vpc_cidr = '10.128.0.0/16'
db_vpc_cidr = '10.240.0.0/16'

app_subnet_name = r_names[r_names.index('dac_app_subnet')]
db_subnet1_name = r_names[r_names.index('dac_db_subnet_1')]
db_subnet2_name = r_names[r_names.index('dac_db_subnet_2')]

app_subnet_cidr = '10.128.0.0/24'
db_subnet1_cidr = '10.240.0.0/24'
db_subnet2_cidr = '10.240.1.0/24'

peering_name = r_names[r_names.index('dac_app_db_peering')]

app_name = r_names[r_names.index('dac_app')]
db_name = r_names[r_names.index('dac_db')]

tgp_name = r_names[r_names.index('dac_app_tgp')]
lb_name = r_names[r_names.index('dac_app_lb')]

print("\nGenerating Diagram...")

with Diagram("Web Service", show=False):

    load_balancer = ELB(lb_name)

    with Cluster("VPC: "+app_vpc_name+"\nCIDR: "+app_vpc_cidr):
        with Cluster("Subnet: "+app_subnet_name+"\nCIDR: "+app_subnet_cidr):
            with Cluster("Instance Group: "+tgp_name):
                workers = [EC2(app_name+"_0"),
                            EC2(app_name+"_1"),
                            EC2(app_name+"_2")]
    
    vpc_peering = VPCPeering(peering_name)

    with Cluster("VPC: "+db_vpc_name+"\nCIDR: "+db_vpc_cidr):
            with Cluster("Subnet 1: "+db_subnet1_name+"\nCIDR: "+db_subnet1_cidr+"\nSubnet 2: "+db_subnet2_name+"\nCIDR: "+db_subnet2_cidr):
                database1 = RDS(db_name)

    load_balancer >> workers >> vpc_peering >> database1

print("Congratulations! The diagram has been succesfully generated in this path: "+os.getcwd()+"\n")