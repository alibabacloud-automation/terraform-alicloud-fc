# FC Trigger variables

variable "service" {
  description = "The FC service name."
}

variable "function" {
  description = "The FC function name."
}

variable "name" {
  description = "The FC trigger name."
}

variable "role" {
  description = "RAM role arn attached to the FC trigger. Role used by the event source to call the function. The value format is \"acs:ram::$account-id:role/$role-name\"."
  default     = ""
}

variable "source_arn" {
  description = "Event source resource address."
  default     = ""
}

variable "type" {
  description = "The Type of the trigger. Valid values: [\"oss\", \"log\", \"timer\", \"http\"]."
}

variable "config" {
  description = "The config of FC trigger."
  default     = ""
}

