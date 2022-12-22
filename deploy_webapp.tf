resource "null_resource" "create-inventory" {
  depends_on = [oci_core_instance.this]
  count      = (var.is_website_installed) ? 1 : 0

  # Create inventory
  provisioner "local-exec" {
    command = "sh ~/tensorflow-demo-sanjose/create_inventory_file.sh ; echo ${oci_core_instance.this.*.public_ip[0]} >> ~/tensorflow-demo-sanjose/tf_inventory.yaml; echo ${oci_core_instance.this.*.public_ip[1]} >> ~/tensorflow-demo-sanjose/tf_inventory.yaml; echo ${oci_core_instance.this.*.public_ip[2]} >> ~/tensorflow-demo-sanjose/tf_inventory.yaml"
  }
}

resource "null_resource" "run-ansible-playbook" {
  depends_on = [null_resource.create-inventory]
  count      = (var.is_website_installed) ? 1 : 0

  # Create inventory
  provisioner "local-exec" {
    command = "sh ~/tensorflow-demo-sanjose/my_playbook.sh"
  }
}
