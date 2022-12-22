# Compartment
output "new_compartment_ocid" { value = oci_identity_compartment.this.id} 

# Network Output
output "core_vcn_ocid" { value = oci_core_vcn.this.*.id }
output "core_nsg_ocid" { value = oci_core_network_security_group.this.id }
output "core_public_net_ocid" { value = oci_core_subnet.My-Public-Subnet.id }

# Instances Output
output "display_name" { value = oci_core_instance.this.*.display_name }
output "public_ip_address" { value = oci_core_instance.this.*.public_ip }
output "private_ip_address" { value = oci_core_instance.this.*.private_ip }
output "testing_required" { value = var.is_testing_required }
output "weapp_installed" { value = var.is_website_installed }
output "Load-Balancer-IPs" { value = oci_load_balancer.this.*.ip_addresses }
output "LB-Max_Bandwith_in_mgps" { value = var.lb_max_bandwith_in_mgps }
output "LB-Min_Bandwith_in_mgps" { value = var.lb_min_bandwith_in_mgps }