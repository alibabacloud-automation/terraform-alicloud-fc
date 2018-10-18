resource "alicloud_fc_trigger" "this" {
  service    = "${var.service}"
  function   = "${var.function}"
  name       = "${var.name}"
  role       = "${var.role}"
  source_arn = "${var.source_arn}"
  type       = "${var.type}"
  config     = "${var.config}"
}
