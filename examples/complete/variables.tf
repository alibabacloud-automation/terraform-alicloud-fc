# RAM role
variable "document" {
  description = "Authorization strategy of the RAM role."
  type        = string
  default     = <<EOF
  {
    "Statement": [
      {
        "Action": "sts:AssumeRole",
        "Effect": "Allow",
        "Principal": {
          "Service": [
              "fc.aliyuncs.com",
              "oss.aliyuncs.com",
              "mns.aliyuncs.com"
          ]
        }
      }
    ],
    "Version": "1"
  }
  EOF
}

variable "force" {
  description = "This parameter is used for resource destroy."
  type        = bool
  default     = false
}

# FC Service Variables
variable "fc_service_description" {
  description = "The Function Compute Service description."
  type        = string
  default     = "tf-testacc-fc-description"
}

variable "service_internet_access" {
  description = "Whether to allow the FC service to access Internet. Default to true."
  type        = bool
  default     = true
}

# HTTP FC Function Variables
variable "fc_function_http_description" {
  description = "The Function Compute function description."
  type        = string
  default     = "tf-testacc-fc-http-description"
}

variable "http_function_runtime" {
  description = "The FC function runtime type."
  type        = string
  default     = "python3.9"
}

variable "http_function_handler" {
  description = "The FC function entry point in your code."
  type        = string
  default     = "http.handler"
}

# Events FC Function Variables
variable "fc_function_events_description" {
  description = "The Function Compute function description."
  type        = string
  default     = "tf-testacc-fc-events-description"
}

variable "events_function_runtime" {
  description = "The FC function runtime type."
  type        = string
  default     = "python3.9"
}

variable "events_function_handler" {
  description = "The FC function entry point in your code."
  type        = string
  default     = "events.handler"
}

# FC Function Variables
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
variable "http_config" {
  description = "The config of Function Compute trigger."
  type        = string
  default     = <<EOF
  {
    "authType": "anonymous",
    "disableURLInternet":false,
    "methods": ["GET"]
  }
  EOF
}

# Events FC Trigger Variables
variable "event_config" {
  description = "The config of Function Compute trigger."
  type        = string
  default     = <<EOF
  {
    "filterTag":"testTag",
    "notifyContentFormat":"STREAM",
    "notifyStrategy":"BACKOFF_RETRY"
  }
  EOF
}