resource "alicloud_fc_function" "this" {
  service     = "${var.service}"
  name        = "${var.name}"
  description = "${var.description}"
  filename    = "${var.filename}"
  memory_size = "${var.memory_size}"
  runtime     = "${var.runtime}"
  handler     = "${var.handler}"
  timeout     = "${var.timeout}"
}
