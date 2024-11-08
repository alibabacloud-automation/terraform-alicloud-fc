output "this_service_id" {
  value       = length(alicloud_fc_service.this) > 0 ? alicloud_fc_service.this[0].id : ""
  description = "The service ID."
}

output "this_service_name" {
  value       = local.service_name
  description = "The service name."
}

output "this_http_function_id" {
  value       = length(alicloud_fc_function.http) > 0 ? alicloud_fc_function.http[0].id : ""
  description = "The id of the http function."
}

output "this_http_function_name" {
  value       = length(alicloud_fc_function.http) > 0 ? alicloud_fc_function.http[0].name : ""
  description = "The name of the http function."
}

output "this_http_trigger_ids" {
  value       = alicloud_fc_trigger.http[*].id
  description = "The ids of the http trigger."
}

output "this_http_trigger_names" {
  value       = alicloud_fc_trigger.http[*].name
  description = "The names of the http trigger."
}

output "this_events_function_id" {
  value       = length(alicloud_fc_function.events) > 0 ? alicloud_fc_function.events[0].id : ""
  description = "The id of the events function."
}

output "this_events_function_name" {
  value       = length(alicloud_fc_function.events) > 0 ? alicloud_fc_function.events[0].name : ""
  description = "The name of the events function."
}

output "this_events_trigger_ids" {
  value       = alicloud_fc_trigger.event[*].id
  description = "The ids of the events trigger."
}

output "this_events_trigger_names" {
  value       = alicloud_fc_trigger.event[*].name
  description = "The names of the events trigger."
}