# FC Function variables

variable "service" {
  description = "The FC service name."
}

variable "name" {
  description = "The FC function name."
}

variable "description" {
  description = "The FC function description."
  default     = ""
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
  default     = "index.handler"
}

variable "timeout" {
  description = "The amount of time your Function has to run in seconds."
  default     = 60
}

