
resource "oci_load_balancer" "this" {
  depends_on = [oci_core_instance.this]

  compartment_id = var.compartment_ocid #oci_identity_compartment.this.id
  count          = (var.is_loadbalancer_installed) ? 1 : 0

  display_name               = "${var.display_name_prefix} ELB"
  network_security_group_ids = [oci_core_network_security_group.this.id ] #[var.network_security_group_id]

  subnet_ids = [ oci_core_subnet.My-Public-Subnet.id ] ##var.subnet_ocid

  shape = "flexible"
  shape_details {
    minimum_bandwidth_in_mbps = var.lb_min_bandwith_in_mgps
    maximum_bandwidth_in_mbps = var.lb_max_bandwith_in_mgps
  }
}

resource "oci_load_balancer_backendset" "backendset" {
  count = (var.is_loadbalancer_installed) ? 1 : 0
  name             = "${var.host_name_prefix}_backendset"
  load_balancer_id = oci_load_balancer.this.*.id[0]
  policy           = "ROUND_ROBIN"

  health_checker {
    port                = "80"
    protocol            = "HTTP"
    response_body_regex = ".*"
    url_path            = "/"
  }
}


resource "oci_load_balancer_listener" "listener" {
  count = (var.is_loadbalancer_installed) ? 1 : 0

  load_balancer_id         = oci_load_balancer.this.*.id[0]
  name                     = "${var.host_name_prefix}-Listener"
  default_backend_set_name = oci_load_balancer_backendset.backendset.*.name[0]
  port                     = 80
  protocol                 = "HTTP"
}


resource "oci_load_balancer_backend" "backend1" {
  count = (var.is_loadbalancer_installed) ? 1 : 0

  load_balancer_id = oci_load_balancer.this.*.id[0]
  backendset_name  = oci_load_balancer_backendset.backendset.*.name[0]
  ip_address       = oci_core_instance.this.*.private_ip[0]
  port             = 80
  backup           = false
  drain            = false
  offline          = false
  weight           = 1
}

resource "oci_load_balancer_backend" "backend2" {
  count = (var.is_loadbalancer_installed) ? 1 : 0

  load_balancer_id = oci_load_balancer.this.*.id[0]
  backendset_name  = oci_load_balancer_backendset.backendset.*.name[0]
  ip_address       = oci_core_instance.this.*.private_ip[1]
  port             = 80
  backup           = false
  drain            = false
  offline          = false
  weight           = 1
}


resource "oci_load_balancer_backend" "backend3" {
  count = (var.is_loadbalancer_installed) ? 1 : 0

  load_balancer_id = oci_load_balancer.this.*.id[0]
  backendset_name  = oci_load_balancer_backendset.backendset.*.name[0]
  ip_address       = oci_core_instance.this.*.private_ip[2]
  port             = 80
  backup           = false
  drain            = false
  offline          = false
  weight           = 1
}

