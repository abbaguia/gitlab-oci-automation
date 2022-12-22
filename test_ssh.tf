resource "null_resource" "ssh-tester" {
  depends_on = [oci_core_instance.this]
  count      = (var.is_testing_required) ? var.server_count : 0

  connection {
    agent       = false
    timeout     = "30m"
    host        = oci_core_instance.this[count.index].public_ip
    user        = "opc"
    private_key = file(var.ssh_private_key)
  }

  provisioner "remote-exec" {
    inline = [
      "echo ",
      "echo \"######################################################################################\"",
      "echo \" SERVER [${count.index}] SUCCESSFULLY CONNECTED. CHECKING SERVER CONFIGURATION .......\"",
      "echo \"######################################################################################\"",
      "echo ",
      "echo ",
      "echo \"====> Server Configuration\"",
      "uname -a",
      "echo ",
      "echo ",
      "echo \"====> Processor Information\"",
      "lscpu",
      "echo ",
      "echo ",
      "echo \"====> Hostname:\"",
      "hostname",
      "echo ",
      "echo ",
      "echo \"====> IP Address:\"",
      "curl ifconfig.co",
      "echo ",
      "echo ",
      "echo \"###### #################@@@@@@@@@@@@@@######################\"",
      "echo \"SUCCESSFULLY COMPLETED SSH TEST AND CONFIGURATION CHECKS.   \"",
      "echo \"############################################################\"",
    ]
  }
}

