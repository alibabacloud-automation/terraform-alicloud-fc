resource "alicloud_fc_service" "this" {
  name            = "${var.name}"
  description     = "${var.description}"
  internet_access = "${var.internet_access}"
  role            = "${var.role}"
  log_config      = "${var.log_config}"
  vpc_config      = "${var.vpc_config}"
}
