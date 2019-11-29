provider "alicloud" {
  version                 = ">=1.56.0"
  profile                 = var.profile != "" ? var.profile : null
  shared_credentials_file = var.shared_credentials_file != "" ? var.shared_credentials_file : null
  region                  = var.region != "" ? var.region : null
  skip_region_validation  = var.skip_region_validation
  configuration_source    = "terraform-alicloud-modules/fc"
}

#################
# FC Service
#################

resource "alicloud_fc_service" "this" {
  count           = var.create_service ? 1 : 0
  name            = local.random_name
  description     = "This is a fc service created by terraform"
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

#################
# FC Function
#################

resource "alicloud_fc_function" "http" {
  count       = var.create_http_function ? 1 : 0
  service     = local.service_name
  name        = var.http_function_name
  description = "This is a fc http function created by terraform"
  filename    = var.http_function_filename == "" ? null : var.http_function_filename
  oss_bucket  = var.http_function_oss_bucket == "" ? null : var.http_function_oss_bucket
  oss_key     = var.http_function_oss_key == "" ? null : var.http_function_oss_key
  memory_size = var.function_memory_size
  runtime     = var.http_function_runtime
  handler     = var.http_function_handler
  timeout     = var.function_timeout
  depends_on  = [alicloud_fc_service.this]
}

resource "alicloud_fc_function" "events" {
  count       = var.create_event_function ? 1 : 0
  service     = local.service_name
  name        = var.events_function_name
  description = "This is an fc events function created by terraform"
  filename    = var.events_function_filename == "" ? null : var.events_function_filename
  oss_bucket  = var.events_function_oss_bucket == "" ? null : var.events_function_oss_bucket
  oss_key     = var.events_function_oss_key == "" ? null : var.events_function_oss_key
  memory_size = var.function_memory_size
  runtime     = var.events_function_runtime
  handler     = var.events_function_handler
  timeout     = var.function_timeout
  depends_on  = [alicloud_fc_service.this]
}



