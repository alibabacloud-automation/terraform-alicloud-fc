# FC Service
resource "alicloud_fc_service" "this" {
  count           = var.create_service ? 1 : 0
  name            = local.random_name
  description     = var.fc_service_description
  internet_access = var.service_internet_access
  role            = local.service_role
  dynamic "log_config" {
    for_each = var.service_log_config
    content {
      logstore = log_config.value.logstore
      project  = log_config.value.project
    }
  }
  dynamic "vpc_config" {
    for_each = var.service_vpc_config
    content {
      security_group_id = vpc_config.value.security_group_id
      vswitch_ids       = vpc_config.value.vswitch_ids
    }
  }
}

# FC Function
resource "alicloud_fc_function" "http" {
  count       = var.create_http_function ? 1 : 0
  service     = local.service_name
  name        = var.http_function_name
  description = var.fc_function_http_description
  filename    = var.http_function_filename == "" ? null : var.http_function_filename
  oss_bucket  = var.http_function_oss_bucket == "" ? null : var.http_function_oss_bucket
  oss_key     = var.http_function_oss_key == "" ? null : var.http_function_oss_key
  runtime     = var.http_function_runtime
  handler     = var.http_function_handler
  memory_size = var.function_memory_size
  timeout     = var.function_timeout
  depends_on  = [alicloud_fc_service.this]
}

resource "alicloud_fc_function" "events" {
  count       = var.create_event_function ? 1 : 0
  service     = local.service_name
  name        = var.events_function_name
  description = var.fc_function_events_description
  filename    = var.events_function_filename == "" ? null : var.events_function_filename
  oss_bucket  = var.events_function_oss_bucket == "" ? null : var.events_function_oss_bucket
  oss_key     = var.events_function_oss_key == "" ? null : var.events_function_oss_key
  runtime     = var.events_function_runtime
  handler     = var.events_function_handler
  memory_size = var.function_memory_size
  timeout     = var.function_timeout
  depends_on  = [alicloud_fc_service.this]
}