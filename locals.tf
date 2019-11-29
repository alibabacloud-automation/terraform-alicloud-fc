locals {
  random_name         = "${var.service_name}-${random_uuid.this.result}"
  service_name        = var.create_service ? local.random_name : var.filter_service_with_name_regex == "" ? "" : data.alicloud_fc_services.this.names[0]
  http_trigger_name   = var.http_trigger_name == "" ? "terraform-http-trigger-${random_uuid.this.result}" : var.http_trigger_name
  events_trigger_name = var.events_trigger_name == "" ? "terraform-events-trigger-${random_uuid.this.result}" : var.events_trigger_name
  service_role        = var.service_role == "" ? var.service_role_name_regex == "" && var.service_role_policy_name == "" && var.service_role_policy_type == "" ? "" : data.alicloud_ram_roles.service.roles[0].arn : var.service_role
  trigger_role        = var.trigger_role == "" ? var.trigger_role_name_regex == "" && var.trigger_role_policy_name == "" && var.trigger_role_policy_type == "" ? "" : data.alicloud_ram_roles.trigger.roles[0].arn : var.trigger_role
  trigger_source_arn  = var.trigger_source_arn == "" ? var.source_role_name_regex == "" && var.source_role_policy_name == "" && var.source_role_policy_type == "" ? "" : data.alicloud_ram_roles.source.roles[0].arn : var.trigger_source_arn
}

resource "random_uuid" "this" {}

data "alicloud_fc_services" "this" {
  name_regex = var.filter_service_with_name_regex
}

data "alicloud_ram_roles" "service" {
  name_regex  = var.service_role_name_regex
  policy_name = var.service_role_policy_name == "" ? null : var.service_role_policy_name
  policy_type = var.service_role_policy_type == "" ? null : var.service_role_policy_type
}

data "alicloud_ram_roles" "trigger" {
  name_regex  = var.trigger_role_name_regex
  policy_name = var.trigger_role_policy_name == "" ? null : var.trigger_role_policy_name
  policy_type = var.trigger_role_policy_type == "" ? null : var.trigger_role_policy_type
}

data "alicloud_ram_roles" "source" {
  name_regex  = var.source_role_name_regex
  policy_name = var.source_role_policy_name == "" ? null : var.source_role_policy_name
  policy_type = var.source_role_policy_type == "" ? null : var.source_role_policy_type
}