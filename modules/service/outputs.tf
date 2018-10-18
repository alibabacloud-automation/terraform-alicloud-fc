//// Output the ID and Name
output "id" {
  value = "${alicloud_fc_service.this.id}"
}

output "name" {
  value = "${alicloud_fc_service.this.name}"
}
