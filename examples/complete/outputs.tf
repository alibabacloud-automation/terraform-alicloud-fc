output "this_service_id" {
  value       = module.fc_service.this_service_id
  description = "The id of the service."
}

output "this_service_name" {
  value       = module.fc_service.this_service_name
  description = "The name of the service."
}

output "this_http_function_id" {
  value       = module.fc_service.this_http_function_id
  description = "The id of the http function."
}

output "this_http_function_name" {
  value       = module.fc_service.this_http_function_name
  description = "The name of the http function."
}

output "this_http_trigger_ids" {
  value       = module.fc_service.this_http_trigger_ids
  description = "The ids of the http trigger."
}

output "this_http_trigger_names" {
  value       = module.fc_service.this_http_trigger_names
  description = "The names of the http trigger."
}

output "this_events_function_id" {
  value       = module.fc_service.this_events_function_id
  description = "The id of the events function."
}

output "this_events_function_name" {
  value       = module.fc_service.this_events_function_name
  description = "The name of the events function."
}

output "this_events_trigger_ids" {
  value       = module.fc_service.this_events_trigger_ids
  description = "The ids of the events trigger."
}

output "this_events_trigger_names" {
  value       = module.fc_service.this_events_trigger_names
  description = "The names of the events trigger."
}