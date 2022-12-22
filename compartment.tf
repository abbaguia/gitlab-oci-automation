resource "oci_identity_compartment" "this" {
    # Required
    compartment_id = var.compartment_ocid
    description = var.compartment_description
    name = var.compartment_name
    enable_delete = var.compartment_delete_on_destroy
}