data "alicloud_regions" "this" {
  current = true
}

resource "alicloud_ram_role" "this" {
  name        = "terraform-fc-module-trigger-909"
  document    = <<EOF
  {
    "Statement": [
      {
        "Action": "sts:AssumeRole",
        "Effect": "Allow",
        "Principal": {
          "Service": [
            "apigateway.aliyuncs.com"
          ]
        }
      }
    ],
    "Version": "1"
  }
  EOF
  description = "this is a test"
  force       = true
}

resource "alicloud_oss_bucket" "default" {
  bucket = "tf_oss_bucket_test_002"
}

# If you upload the function by OSS Bucket, you need to specify path can't upload by content.
resource "alicloud_oss_bucket_object" "default" {
  bucket = alicloud_oss_bucket.default.id
  key    = "./hello.zip"
  source = "./hello.zip"
}

module "events-apigateway-trigger" {
  source                        = "../.."
  service_name                  = "terraform-fc-service-events"
  create_event_function         = true
  create_service                = true
  create_http_function          = false
  service_role                  = alicloud_ram_role.this.arn
  events_function_name          = var.events_function_name
  service_log_config            = var.service_log_config
  service_vpc_config            = var.service_vpc_config
  event_description             = var.event_description
  events_function_filename      = var.events_function_filename
  events_function_oss_bucket    = alicloud_oss_bucket.default.id
  events_function_oss_key       = alicloud_oss_bucket_object.default.key
  function_memory_size          = var.function_memory_size
  events_function_runtime       = var.events_function_runtime
  events_function_handler       = var.events_function_handler
  function_timeout              = var.function_timeout
  description                   = var.description
  service_internet_access       = var.service_internet_access
}

module "http-apigateway-trigger" {
  source                    = "../.."
  service_name              = "terraform-fc-service-http"
  create_event_function     = false
  create_service            = true
  create_http_function      = true
  description               = var.description
  service_internet_access   = var.service_internet_access
  service_log_config        = var.service_log_config
  service_vpc_config        = var.service_vpc_config
  service_role              = alicloud_ram_role.this.arn
  http_function_name        = var.http_function_name
  http_function_filename    = var.events_function_filename
  http_function_oss_bucket  = alicloud_oss_bucket.default.id
  http_function_oss_key     = alicloud_oss_bucket_object.default.key
  function_memory_size      = var.function_memory_size
  function_timeout          = var.function_timeout
  http_function_runtime     = var.events_function_runtime
  http_function_handler     = var.events_function_handler
}
