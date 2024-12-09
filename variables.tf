
# FC Service Variables
variable "create_service" {
  description = "Whether to create a new FC service. Default to true."
  type        = bool
  default     = true
}

variable "service_name" {
  description = "The FC service name."
  type        = string
  default     = ""
}

variable "fc_service_description" {
  description = "The Function Compute Service description."
  type        = string
  default     = ""
}

variable "service_internet_access" {
  description = "Whether to allow the FC service to access Internet. Default to true."
  type        = bool
  default     = true
}


variable "service_role" {
  description = "RAM role arn attached to the FC service. This governs both who / what can invoke your Function, as well as what resources our Function has access to."
  type        = string
  default     = ""
}

variable "query_service_role" {
  description = "Whther to query service role. If you don't set 'service_role', you can use data source to query service role. Default to false."
  type        = bool
  default     = false
}

variable "service_role_name_regex" {
  description = "A regex string to filter roles by name regex."
  type        = string
  default     = ""
}

variable "service_role_policy_name" {
  description = "A string to filter roles by policy name."
  type        = string
  default     = ""
}

variable "service_role_policy_type" {
  description = "A string to filter roles by policy type."
  type        = string
  default     = ""
}

variable "service_log_config" {
  description = "Provide this to store your FC service logs."
  type = list(object({
    logstore = string
    project  = string
  }))
  default = []
}

variable "service_vpc_config" {
  description = "Provide this to allow your FC service to access your VPC."
  type = list(object({
    security_group_id = string
    vswitch_ids       = list(string)
  }))
  default = []
}

# HTTP FC Function Variables
variable "create_http_function" {
  description = "Whether to create http function."
  type        = bool
  default     = false
}

variable "http_function_name" {
  description = "The FC http function name."
  type        = string
  default     = ""
}

variable "fc_function_http_description" {
  description = "The Function Compute function description."
  type        = string
  default     = ""
}

variable "http_function_filename" {
  description = "The path to the function's deployment package within the local filesystem. It is conflict with the oss_-prefixed options."
  type        = string
  default     = ""
}

variable "http_function_oss_bucket" {
  description = "The bucket of function's deployment package within the oss service. It is conflict with the filename."
  type        = string
  default     = ""
}

variable "http_function_oss_key" {
  description = "The key of function's deployment package within the oss service. It is conflict with the filename."
  type        = string
  default     = ""
}

variable "http_function_runtime" {
  description = "The FC function runtime type."
  type        = string
  default     = "nodejs6"
}

variable "http_function_handler" {
  description = "The FC function entry point in your code."
  type        = string
  default     = ""
}

# Events FC Function Variables
variable "create_event_function" {
  description = "Whether to create event function."
  type        = bool
  default     = false
}

variable "events_function_name" {
  description = "The FC events function name."
  type        = string
  default     = ""
}

variable "fc_function_events_description" {
  description = "The Function Compute function description."
  type        = string
  default     = ""
}

variable "events_function_filename" {
  description = "The path to the function's deployment package within the local filesystem. It is conflict with the oss_-prefixed options."
  type        = string
  default     = ""
}

variable "events_function_oss_bucket" {
  description = "The bucket of function's deployment package within the oss service. It is conflict with the filename."
  type        = string
  default     = ""
}

variable "events_function_oss_key" {
  description = "The key of function's deployment package within the oss service. It is conflict with the filename."
  type        = string
  default     = ""
}

variable "events_function_runtime" {
  description = "The FC function runtime type."
  type        = string
  default     = "nodejs6"
}

variable "events_function_handler" {
  description = "The FC function entry point in your code."
  type        = string
  default     = ""
}

# FC Function Variables
variable "filter_service_with_name_regex" {
  description = "A regex string to filter results by FC service name."
  type        = string
  default     = ""
}

variable "function_memory_size" {
  description = "Amount of memory in MB your Function can use at runtime. Defaults to 128. Limits to [128, 3072]."
  type        = number
  default     = 128
}

variable "function_timeout" {
  description = "The amount of time your Function has to run in seconds."
  type        = number
  default     = 60
}

# HTTP FC Trigger Variables
variable "http_trigger_name" {
  description = "The FC http trigger default name."
  type        = string
  default     = ""
}

variable "http_triggers" {
  description = "List trigger fields to create http triggers"
  type        = list(map(string))
  default     = []
}

# Events FC Trigger Variables
variable "events_trigger_name" {
  description = "The FC events trigger default name."
  type        = string
  default     = ""
}

variable "events_triggers" {
  description = "List trigger fields to create events triggers"
  type        = list(map(string))
  default     = []
}

# FC Trigger Variables
variable "query_trigger_role" {
  description = "Whther to query trigger role. If you don't set 'trigger_role', you can use data source to query trigger role. Default to false."
  type        = bool
  default     = false
}

variable "trigger_role" {
  description = "Default RAM role arn attached to the FC trigger. Role used by the event source to call the function. The value format is \"acs:ram::$account-id:role/$role-name\"."
  type        = string
  default     = ""
}

variable "trigger_role_name_regex" {
  description = "A regex string to filter roles by name regex."
  type        = string
  default     = ""
}

variable "trigger_role_policy_name" {
  description = "A string to filter roles by policy name."
  type        = string
  default     = ""
}

variable "trigger_role_policy_type" {
  description = "A string to filter roles by policy type."
  type        = string
  default     = ""
}

variable "trigger_source_arn" {
  description = "Event source resource address."
  type        = string
  default     = ""
}

variable "query_trigger_source_arn" {
  description = "Whther to query trigger source arn. If you don't set 'trigger_source_arn', you can use data source to query trigger source arn. Default to false."
  type        = bool
  default     = false
}

variable "source_role_name_regex" {
  description = "A regex string to filter source roles by name regex."
  type        = string
  default     = ""
}

variable "source_role_policy_name" {
  description = "A string to filter source roles by policy name."
  type        = string
  default     = ""
}

variable "source_role_policy_type" {
  description = "A string to filter source roles by policy type."
  type        = string
  default     = ""
}
