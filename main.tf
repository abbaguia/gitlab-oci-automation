# Version 2: Multi-AD Scenario

provider "oci" {}

data "oci_identity_availability_domains" "ads" {
    compartment_id = var.compartment_ocid 
}

data "oci_identity_fault_domains" "fds" {
    availability_domain = var.availability_domain
    compartment_id = var.compartment_ocid
}

locals {
  ads = data.oci_identity_availability_domains.ads.availability_domains
  fds = data.oci_identity_fault_domains.fds.fault_domains
}


resource "oci_core_instance" "this" {

  #count = var.sever_count
  #count = (var.sever_count <= 2) ? var.sever_count : 2
  count = (var.server_count <= var.server_limit) ? var.server_count : var.server_limit  # version 2

  availability_config {
    recovery_action = "RESTORE_INSTANCE"
  }
  
  # Version 2: Availability Domain Name is dymanically generated  
  #availability_domain = var.availability_domain   
  availability_domain = (var.availability_domain_number != 0) ? lookup(local.ads[abs(var.availability_domain_number - 1)], "name") : lookup(local.ads[count.index % floor(min(var.server_count, 3))], "name")
  fault_domain = (var.fault_domain_number != 0) ? lookup(local.fds[abs(var.fault_domain_number - 1)], "name") : lookup(local.fds[count.index % floor(min(var.server_count, 3))], "name")
  
  compartment_id = oci_identity_compartment.this.id
    
  create_vnic_details {
    assign_private_dns_record = "true"
    assign_public_ip          = var.assign_public_ipaddress
    subnet_id                 = oci_core_subnet.My-Public-Subnet.id
  }
    
  display_name = "${var.display_name_prefix}-Server${count.index + 1}"
    
  instance_options {
    are_legacy_imds_endpoints_disabled = "false"
  }
    
  is_pv_encryption_in_transit_enabled = "true"
    
  metadata = {
    ssh_authorized_keys = "${file(var.ssh_public_key)}"
  }
  
  # Hardcoded because this is the only value for the quota limti (Free tier)
  #shape = "VM.Standard.E2.1.Micro"
  shape = var.instance_shape
  shape_config {
    baseline_ocpu_utilization = "BASELINE_1_1"
    memory_in_gbs             = var.instance_memory_in_gbs #"8"
    ocpus                     = var.instance_nb_of_ocpus   #"1"
  }

  source_details {
    source_id   = var.image_ocid
    source_type = "image"
  }
}
