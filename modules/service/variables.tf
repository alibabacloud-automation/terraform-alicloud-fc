# FC Service variables

variable "name" {
  description = "The FC service name."
}

variable "description" {
  description = "The FC service description."
  default     = ""
}

variable "internet_access" {
  description = "Whether to allow the FC service to access Internet. Default to true."
  default     = true
}

variable "role" {
  description = "RAM role arn attached to the FC service. This governs both who / what can invoke your Function, as well as what resources our Function has access to."
  default     = ""
}

variable "log_config" {
  description = "Provide this to store your FC service logs."
  type        = "list"
  default     = []
}

variable "vpc_config" {
  description = "Provide this to allow your FC service to access your VPC."
  type        = "list"
  default     = []
}
