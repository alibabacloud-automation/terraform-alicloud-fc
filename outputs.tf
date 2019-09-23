output "this_service_id" {
  description = "The ID of the Service"
  value       = module.fc_service.id
}

output "this_service_name" {
  description = "The name of the Service"
  value       = module.fc_service.name
}

output "this_function_id" {
  description = "The ID of the Function"
  value       = module.fc_function.id
}

output "this_function_name" {
  description = "The name of the Function"
  value       = module.fc_function.name
}

output "this_trigger_id" {
  description = "The ID of the Trigger"
  value       = module.fc_trigger.id
}

output "this_trigger_name" {
  description = "The name of the Trigger"
  value       = module.fc_trigger.name
}

