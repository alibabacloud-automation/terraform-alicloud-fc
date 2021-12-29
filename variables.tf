# FC variables

variable "region" {
  description = "(Deprecated from version 1.3.0) The region used to launch this module resources."
  default     = ""
}

variable "profile" {
  description = "(Deprecated from version 1.3.0) The profile name as set in the shared credentials file. If not set, it will be sourced from the ALICLOUD_PROFILE environment variable."
  default     = ""
}

variable "shared_credentials_file" {
  description = "(Deprecated from version 1.3.0) This is the path to the shared credentials file. If this is not set and a profile is specified, $HOME/.aliyun/config.json will be used."
  default     = ""
}

variable "skip_region_validation" {
  description = "(Deprecated from version 1.3.0) Skip static validation of region ID. Used by users of alternative AlibabaCloud-like APIs or users w/ access to regions that are not public (yet)."
  default     = false
}

#################
# FC Service Variables
#################

variable "create_service" {
  description = "Whether to create a new FC service. Default to true."
  default     = true
}

variable "filter_service_with_name_regex" {
  description = "A regex string to filter results by FC service name."
  default     = ""
}

variable "service_name" {
  description = "The FC service name."
  default     = ""
}

variable "service_internet_access" {
  description = "Whether to allow the FC service to access Internet. Default to true."
  default     = true
}

variable "service_role" {
  description = "RAM role arn attached to the FC service. This governs both who / what can invoke your Function, as well as what resources our Function has access to."
  default     = ""
}

variable "service_role_name_regex" {
  description = "A regex string to filter roles by name regex."
  default     = ""
}

variable "service_role_policy_name" {
  description = "A string to filter roles by policy name."
  default     = ""
}

variable "service_role_policy_type" {
  description = "A string to filter roles by policy type."
  default     = ""
}

variable "service_log_config" {
  description = "Provide this to store your FC service logs."
  type        = "list"
  default     = []
}

variable "service_vpc_config" {
  description = "Provide this to allow your FC service to access your VPC."
  type        = "list"
  default     = []
}

#################
# FC Function Variables
#################


variable "function_memory_size" {
  description = "Amount of memory in MB your Function can use at runtime. Defaults to 128. Limits to [128, 3072]."
  default     = 128
}

variable "function_timeout" {
  description = "The amount of time your Function has to run in seconds."
  default     = 60
}

#################
# HTTP FC Function Variables
#################

variable "create_http_function" {
  description = "Whether to create http function."
  default     = false
}

variable "http_function_name" {
  description = "The FC http function name."
  default     = "terraform-fc-http-function"
}

variable "http_function_filename" {
  description = "The path to the function's deployment package within the local filesystem. It is conflict with the oss_-prefixed options."
  default     = ""
}

variable "http_function_oss_bucket" {
  description = "The bucket of function's deployment package within the oss service. It is conflict with the filename."
  default     = ""
}

variable "http_function_oss_key" {
  description = "The key of function's deployment package within the oss service. It is conflict with the filename."
  default     = ""
}

variable "http_function_runtime" {
  description = "The FC function runtime type."
  default     = "nodejs6"
}

variable "http_function_handler" {
  description = "The FC function entry point in your code."
  default     = "index.handler"
}

#################
# Events FC Function Variables
#################

variable "create_event_function" {
  description = "Whether to create event function."
  default     = false
}

variable "description" {
  description = "The Function Compute function description."
  type        = string
  default     = ""
}

variable "event_description" {
  description = "The Function function description."
  type        = string
  default     = ""
}

variable "events_function_name" {
  description = "The FC events function name."
  default     = ""
}

variable "events_function_filename" {
  description = "The path to the function's deployment package within the local filesystem. It is conflict with the oss_-prefixed options."
  default     = ""
}

variable "events_function_oss_bucket" {
  description = "The bucket of function's deployment package within the oss service. It is conflict with the filename."
  default     = ""
}

variable "events_function_oss_key" {
  description = "The key of function's deployment package within the oss service. It is conflict with the filename."
  default     = ""
}

variable "events_function_runtime" {
  description = "The FC function runtime type."
  default     = "nodejs6"
}

variable "events_function_handler" {
  description = "The FC function entry point in your code."
  default     = "index.handler"
}

#################
# FC Trigger Variables
#################

variable "trigger_role" {
  description = "Default RAM role arn attached to the FC trigger. Role used by the event source to call the function. The value format is \"acs:ram::$account-id:role/$role-name\"."
  default     = ""
}

variable "trigger_source_arn" {
  description = "Event source resource address."
  default     = ""
}

variable "trigger_role_name_regex" {
  description = "A regex string to filter roles by name regex."
  default     = ""
}

variable "trigger_role_policy_name" {
  description = "A string to filter roles by policy name."
  default     = ""
}

variable "trigger_role_policy_type" {
  description = "A string to filter roles by policy type."
  default     = ""
}

variable "source_role_name_regex" {
  description = "A regex string to filter source roles by name regex."
  default     = ""
}

variable "source_role_policy_name" {
  description = "A string to filter source roles by policy name."
  default     = ""
}

variable "source_role_policy_type" {
  description = "A string to filter source roles by policy type."
  default     = ""
}

#################
# HTTP FC Trigger Variables
#################

variable "http_trigger_name" {
  description = "The FC http trigger default name."
  default     = "terraform-http-trigger"
}

variable "http_triggers" {
  description = "List trigger fields to create http triggers"
  type        = list(map(string))
  default     = []
}

#################
# Events FC Trigger Variables
#################

variable "events_trigger_name" {
  description = "The FC events trigger default name."
  default     = "terraform-events-trigger"
}

variable "events_triggers" {
  description = "List trigger fields to create events triggers"
  type        = list(map(string))
  default     = []
}