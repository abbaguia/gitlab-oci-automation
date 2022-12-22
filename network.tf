## This Network configuration was infered from a ORM generated code by terraform-provider-oci

# Core VCN
resource oci_core_vcn this { 
  compartment_id = oci_identity_compartment.this.id
  cidr_block = var.vcn_cidr_block
  display_name = "${var.display_name_prefix} Core VCN"
  dns_label    = "${var.host_name_prefix}core"
}

# Internet Gateway
resource oci_core_internet_gateway this {  
  compartment_id = oci_identity_compartment.this.id
  display_name = "${var.display_name_prefix} IGW"
  enabled      = "true"
  vcn_id = "${oci_core_vcn.this.id}"
}

# Default Routing Table
resource oci_core_default_route_table this { 
  compartment_id = oci_identity_compartment.this.id
  display_name = "${var.display_name_prefix} Routing Table"
  manage_default_resource_id = oci_core_vcn.this.default_route_table_id
  route_rules {
    description = "Route Table for ${var.display_name_prefix}" 
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_internet_gateway.this.id
  }
}

# Network Security Group
resource oci_core_network_security_group this {
  compartment_id = oci_identity_compartment.this.id
  display_name = "${var.display_name_prefix} Network Security Group"
  vcn_id = oci_core_vcn.this.id
}

# Network Security Group Rule
resource oci_core_network_security_group_security_rule this {
  description = "Open Network Security Group Rule"
  destination_type          = ""
  direction                 = "INGRESS"
  network_security_group_id = oci_core_network_security_group.this.id
  protocol                  = "6"
  source                    = "0.0.0.0/0"
  source_type               = "CIDR_BLOCK"
  stateless                 = "false"
  tcp_options {
    destination_port_range {
      max = "80"
      min = "80"
    }
    source_port_range {
      max = "80"
      min = "80"
    }
  }
}

# Default DHCP Options 
resource oci_core_default_dhcp_options Default-DHCP-Options {
  compartment_id = oci_identity_compartment.this.id
  display_name     = "Default DHCP Options for ${var.display_name_prefix}"
  domain_name_type = "CUSTOM_DOMAIN"
  manage_default_resource_id = oci_core_vcn.this.default_dhcp_options_id
  options {
    custom_dns_servers = []
    server_type = "VcnLocalPlusInternet"
    type        = "DomainNameServer"
  }
  options {
    search_domain_names = [
      "${var.host_name_prefix}core.oraclevcn.com"
    ]
    type = "SearchDomain"
  }
}

# Private Subnet Route Table
resource oci_core_route_table Route-Table-for-My-Private-Subnet {
  compartment_id = oci_identity_compartment.this.id
  display_name = "Route Table for Private Subnet for ${var.display_name_prefix}"
  vcn_id = oci_core_vcn.this.id
}

# Regional Private Subnet
resource oci_core_subnet My-Private-Subnet {
  #availability_domain = <<Optional value not found in discovery>>
  cidr_block     = var.subnet_cidr_block
  compartment_id = oci_identity_compartment.this.id
  dhcp_options_id = oci_core_vcn.this.default_dhcp_options_id
  display_name    = "Private Subnet for ${var.display_name_prefix}"
  dns_label       = "${var.host_name_prefix}prvnet"
  ipv6cidr_blocks = []
  prohibit_internet_ingress  = "true"
  prohibit_public_ip_on_vnic = "true"
  route_table_id             = oci_core_route_table.Route-Table-for-My-Private-Subnet.id
  security_list_ids = [
    oci_core_security_list.Security-List-for-My-Private-Subnet.id,
  ]
  vcn_id = oci_core_vcn.this.id
}


# Private Subnet Security List
resource oci_core_security_list Security-List-for-My-Private-Subnet {
  compartment_id = oci_identity_compartment.this.id
  display_name = "Security List for Private Subnet ${var.display_name_prefix}"
  egress_security_rules {
    #description = <<Optional value not found in discovery>>
    destination      = "0.0.0.0/0"
    destination_type = "CIDR_BLOCK"
    #icmp_options = <<Optional value not found in discovery>>
    protocol  = "all"
    stateless = "false"
    #tcp_options = <<Optional value not found in discovery>>
    #udp_options = <<Optional value not found in discovery>>
  }
  ingress_security_rules {
    #description = <<Optional value not found in discovery>>
    icmp_options {
      code = "4"
      type = "3"
    }
    protocol    = "1"
    source      = "0.0.0.0/0"
    source_type = "CIDR_BLOCK"
    stateless   = "false"
    #tcp_options = <<Optional value not found in discovery>>
    #udp_options = <<Optional value not found in discovery>>
  }
  ingress_security_rules {
    #description = <<Optional value not found in discovery>>
    #icmp_options = <<Optional value not found in discovery>>
    protocol    = "6"
    source      = "10.0.0.0/16"
    source_type = "CIDR_BLOCK"
    stateless   = "false"
    tcp_options {
      max = "22"
      min = "22"
      #source_port_range = <<Optional value not found in discovery>>
    }
    #udp_options = <<Optional value not found in discovery>>
  }
  ingress_security_rules {
    #description = <<Optional value not found in discovery>>
    icmp_options {
      code = "-1"
      type = "3"
    }
    protocol    = "1"
    source      = "10.0.0.0/16"
    source_type = "CIDR_BLOCK"
    stateless   = "false"
    #tcp_options = <<Optional value not found in discovery>>
    #udp_options = <<Optional value not found in discovery>>
  }
  vcn_id = oci_core_vcn.this.id
}

# Default Security List 
resource oci_core_default_security_list My-Default-Security-List {
  compartment_id = var.compartment_ocid
  display_name = "Default Security List for ${var.display_name_prefix}"

  egress_security_rules {
    description = "Egress Open to all protocols"
    destination      = "0.0.0.0/0"
    destination_type = "CIDR_BLOCK"
    #icmp_options = <<Optional value not found in discovery>>
    protocol  = "all"
    stateless = "false"
    #tcp_options = <<Optional value not found in discovery>>
    #udp_options = <<Optional value not found in discovery>>
  }
  ingress_security_rules {
    #description = <<Optional value not found in discovery>>
    icmp_options {
      code = "4"
      type = "3"
    }
    protocol    = "1"
    source      = "0.0.0.0/0"
    source_type = "CIDR_BLOCK"
    stateless   = "false"
    #tcp_options = <<Optional value not found in discovery>>
    #udp_options = <<Optional value not found in discovery>>
  }
  ingress_security_rules {
    #description = <<Optional value not found in discovery>>
    icmp_options {
      code = "-1"
      type = "3"
    }
    protocol    = "1"
    source      = "10.0.0.0/16"
    source_type = "CIDR_BLOCK"
    stateless   = "false"
    #tcp_options = <<Optional value not found in discovery>>
    #udp_options = <<Optional value not found in discovery>>
  }
  ingress_security_rules {
    description = "Openning Default Web Aplication Port 80"
    #icmp_options = <<Optional value not found in discovery>>
    protocol    = "6"
    source      = "0.0.0.0/0"
    source_type = "CIDR_BLOCK"
    stateless   = "false"
    tcp_options {
      max = "80"
      min = "80"
      #source_port_range = <<Optional value not found in discovery>>
    }
    #udp_options = <<Optional value not found in discovery>>
  }
  ingress_security_rules {
    #description = <<Optional value not found in discovery>>
    #icmp_options = <<Optional value not found in discovery>>
    protocol    = "6"
    source      = "0.0.0.0/0"
    source_type = "CIDR_BLOCK"
    stateless   = "false"
    tcp_options {
      max = "22"
      min = "22"
    }
    #udp_options = <<Optional value not found in discovery>>
  }
  manage_default_resource_id = oci_core_vcn.this.default_security_list_id
}


# Regional Public Subnet
resource oci_core_subnet My-Public-Subnet {
  #availability_domain = <<Optional value not found in discovery>>
  cidr_block     = "10.0.0.0/24"
  compartment_id = oci_identity_compartment.this.id
  dhcp_options_id = oci_core_vcn.this.default_dhcp_options_id
  display_name    = "Public Subnet for ${var.display_name_prefix}"
  dns_label       = "${var.host_name_prefix}pubnet"
  ipv6cidr_blocks = []
  prohibit_internet_ingress  = "false"
  prohibit_public_ip_on_vnic = "false"
  route_table_id             = oci_core_vcn.this.default_route_table_id
  security_list_ids = [
    oci_core_vcn.this.default_security_list_id,
  ]
  vcn_id = oci_core_vcn.this.id
}
