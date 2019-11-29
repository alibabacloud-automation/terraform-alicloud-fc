
output "this_service_id" {
  value = length(alicloud_fc_service.this) > 0 ? alicloud_fc_service.this.0.id : ""
}

output "this_service_name" {
  value = local.service_name
}

output "this_http_function_id" {
  value = length(alicloud_fc_function.http) > 0 ? alicloud_fc_function.http.0.id : ""
}

output "this_http_function_name" {
  value = length(alicloud_fc_function.http) > 0 ? alicloud_fc_function.http.0.name : ""
}

output "this_http_trigger_ids" {
  value = alicloud_fc_trigger.http.*.id
}

output "this_http_trigger_names" {
  value = alicloud_fc_trigger.http.*.name
}

output "this_events_function_id" {
  value = length(alicloud_fc_function.events) > 0 ? alicloud_fc_function.events.0.id : ""
}

output "this_events_function_name" {
  value = length(alicloud_fc_function.events) > 0 ? alicloud_fc_function.events.0.name : ""
}

output "this_events_trigger_ids" {
  value = alicloud_fc_trigger.event.*.id
}

output "this_events_trigger_names" {
  value = alicloud_fc_trigger.event.*.name
}

