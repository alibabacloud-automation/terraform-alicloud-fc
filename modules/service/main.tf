resource "alicloud_fc_service" "default" {
  name            = var.name
  description     = var.description
  internet_access = var.internet_access
  role            = var.role
  dynamic "log_config" {
    for_each = var.log_config
    content {
      logstore = log_config.value.logstore
      project  = log_config.value.project
    }
  }
  dynamic "vpc_config" {
    for_each = var.vpc_config
    content {
      security_group_id = vpc_config.value.security_group_id
      vswitch_ids       = vpc_config.value.vswitch_ids
    }
  }
}

