#################
# FC Service Variables
#################
variable "create_service" {
  description = "Whether to create a new FC service. Default to true."
  default     = true
}

variable "service_internet_access" {
  description = "Whether to allow the FC service to access Internet. Default to true."
  default     = true
}

variable "description" {
  description = "The FC service description."
  default     = "This is a fc service created by terraform"
}

variable "event_description" {
  description = "The Function function description."
  type        = string
  default     = "This is an fc events function created by terraform"
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
# Events FC Function Variables
#################

variable "create_event_function" {
  description = "Whether to create event function."
  default     = true
}

variable "events_function_name" {
  description = "The FC events function name."
  default     = "terraform-fc-events-function"
}

variable "http_function_filename" {
  description = "The FC events function name."
  default     = "terraform-fc-http-function"
}

variable "http_function_name" {
  description = "The FC events function name."
  default     = "terraform-fc-http-function"
}

variable "events_function_filename" {
  description = "The path to the function's deployment package within the local filesystem. It is conflict with the oss_-prefixed options."
  default     = "../events_function.js"
}

variable "events_function_oss_bucket" {
  description = "The bucket of function's deployment package within the oss service. It is conflict with the filename."
  default     = ""
}

variable "http_function_oss_bucket" {
  description = "The bucket of function's deployment package within the oss service. It is conflict with the filename."
  default     = ""
}

variable "events_function_oss_key" {
  description = "The key of function's deployment package within the oss service. It is conflict with the filename."
  default     = ""
}

variable "http_function_oss_key" {
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