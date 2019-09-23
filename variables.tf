# FC variables

variable "region" {
  description = "The region used to launch this module resources."
  default     = ""
}

variable "service" {
  description = "The FC service name."
}

variable "function" {
  description = "The FC function name."
}

variable "filename" {
  description = "The path to the function's deployment package within the local filesystem. It is conflict with the oss_-prefixed options."
}

variable "memory_size" {
  description = "Amount of memory in MB your Function can use at runtime. Defaults to 128. Limits to [128, 3072]."
  default     = 512
}

variable "runtime" {
  description = "The FC function runtime type."
}

variable "handler" {
  description = "The FC function entry point in your code."
}

variable "timeout" {
  description = "The amount of time your Function has to run in seconds."
  default     = 60
}

variable "trigger" {
  description = "The FC trigger name."
}

variable "type" {
  description = "The Type of the trigger. Valid values: [\"oss\", \"log\", \"timer\", \"http\"]."
}

variable "config" {
  description = "The config of FC trigger."
  default     = ""
}

