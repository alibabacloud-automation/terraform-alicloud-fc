data "alicloud_fc_zones" "default" {
}

data "alicloud_account" "this" {
}

data "alicloud_regions" "this" {
  current = true
}

resource "alicloud_ram_role" "default" {
  name     = "tf-testacc-ram-role"
  document = var.document
  force    = var.force
}

resource "alicloud_ram_role_policy_attachment" "default" {
  role_name   = alicloud_ram_role.default.name
  policy_name = "AdministratorAccess"
  policy_type = "System"
}

resource "alicloud_mns_topic" "default" {
  name = "tf-testacc-mns-topic"
}

module "vpc" {
  source             = "alibaba/vpc/alicloud"
  create             = true
  vpc_cidr           = "172.16.0.0/12"
  vswitch_cidrs      = ["172.16.0.0/21"]
  availability_zones = [data.alicloud_fc_zones.default.zones.0.id]
}

module "security_group" {
  source = "alibaba/security-group/alicloud"
  vpc_id = module.vpc.this_vpc_id
}

module "sls" {
  source       = "terraform-alicloud-modules/sls/alicloud"
  project_name = "tf-testacc-project"
  store_name   = "tf-testacc-store"
}

module "fc_service" {
  source = "../.."

  #alicloud_fc_service
  create_service = true

  service_name            = "tf-testacc-fc-service"
  fc_service_description  = var.fc_service_description
  service_internet_access = var.service_internet_access
  service_role            = alicloud_ram_role.default.arn
  service_role_name_regex = "tf"
  service_log_config = [
    {
      logstore = module.sls.this_log_store_name
      project  = module.sls.this_log_project_name
    }
  ]
  service_vpc_config = [
    {
      security_group_id = module.security_group.this_security_group_id
      vswitch_ids       = module.vpc.this_vswitch_ids
    }
  ]

  #alicloud_fc_function
  create_http_function = true

  http_function_name           = "tf-testacc-fc-http"
  fc_function_http_description = var.fc_function_http_description
  http_function_filename       = "../http_function.py"
  http_function_runtime        = var.http_function_runtime
  http_function_handler        = var.http_function_handler
  function_memory_size         = var.function_memory_size
  function_timeout             = var.function_timeout

  create_event_function = true

  events_function_name           = "tf-testacc-fc-events"
  fc_function_events_description = var.fc_function_events_description
  events_function_filename       = "../events_function.py"
  events_function_runtime        = var.events_function_runtime
  events_function_handler        = var.events_function_handler

  #alicloud_fc_trigger
  http_trigger_name = "tf-testacc-fc-http-trigger"
  http_triggers = [
    {
      type   = "http"
      config = var.http_config
    }
  ]
  events_trigger_name = "tf-testacc-fc-events-trigger"
  trigger_role        = alicloud_ram_role.default.arn
  events_triggers = [
    {
      source_arn = "acs:mns:${data.alicloud_regions.this.regions.0.id}:${data.alicloud_account.this.id}:/topics/${alicloud_mns_topic.default.name}"
      type       = "mns_topic"
      config_mns = var.event_config
    }
  ]

}