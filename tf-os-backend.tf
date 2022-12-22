terraform {
  backend "http" {
    address = "https://objectstorage.us-ashburn-1.oraclecloud.com/p/tna0qMeVFtILrjavnwEU8_WaXZ3wptJVVO1-4QbHnWOMtnW6RCb3cMQPsvI6lcrs/n/orasenatdpltintegration03/b/oci-tf-states-store/o/terraform.tfstate"
    update_method = "PUT"
  }
}