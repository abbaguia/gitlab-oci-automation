####################################
#.   VARIBLES DEFINITION.         #
####################################

# Root and Chikd Compartment 
variable "compartment_ocid" {}
variable "compartment_description" {}
variable "compartment_name" {}
variable "compartment_delete_on_destroy" {}

# Network  & Load Balancer Variables
variable "vcn_cidr_block" {}
variable "subnet_cidr_block" {}
variable "host_name_prefix" {}
variable "is_loadbalancer_installed" {}
variable "lb_min_bandwith_in_mgps" {}
variable "lb_max_bandwith_in_mgps" {}

# Compute Instance Variables
variable "availability_domain" {}
variable "availability_domain_number" {}
variable "fault_domain" {}
variable "fault_domain_number" {}
variable "server_count" {}
variable "sever_limit" {}
variable "image_ocid" {}
variable "display_name_prefix" {}
variable "assign_public_ipaddress" {}
variable "ssh_private_key" {}
variable "ssh_public_key" {}
variable "instance_shape" {}
variable "instance_memory_in_gbs" {}
variable "instance_nb_of_ocpus" {}

# Web Application Variables
variable "is_testing_required" {}
variable "is_website_installed" {}
