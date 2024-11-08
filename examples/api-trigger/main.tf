resource "random_integer" "default" {
  max = 99999
  min = 10000
}
data "alicloud_regions" "default" {
  current = true
}

resource "alicloud_ram_role" "default" {
  name        = "tf-example-${random_integer.default.result}"
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
  description = "this is a example"
  force       = true
}

module "apigateway-trigger" {
  source                   = "../.."
  service_name             = "tf-example-${random_integer.default.result}"
  create_event_function    = true
  events_function_name     = "tf-example-event-${random_integer.default.result}"
  service_role             = alicloud_ram_role.default.arn
  events_function_handler  = "index.handler"
  events_function_filename = "../events_function.js"
  events_function_runtime  = "nodejs8"
}

resource "alicloud_api_gateway_group" "default" {
  name        = "tf-example-${random_integer.default.result}"
  description = "created by terraform-fc-module"
}

resource "alicloud_api_gateway_api" "default" {
  name        = "tf-example-${random_integer.default.result}"
  group_id    = alicloud_api_gateway_group.default.id
  description = "create by terraform-fc-module"
  auth_type   = "APP"

  request_config {
    protocol    = "HTTP"
    method      = "POST"
    path        = "/example/path2"
    mode        = "MAPPING"
    body_format = "STREAM"
  }

  service_type = "FunctionCompute"

  fc_service_config {
    function_type = "FCEvent"
    region        = data.alicloud_regions.default.id
    function_name = module.apigateway-trigger.this_events_function_name
    service_name  = module.apigateway-trigger.this_service_name
    arn_role      = alicloud_ram_role.default.arn
    timeout       = 10
  }

  request_parameters {
    name         = "aa"
    type         = "STRING"
    required     = "REQUIRED"
    in           = "QUERY"
    in_service   = "QUERY"
    name_service = "testparams"
  }

  stage_names = [
    "RELEASE",
    "PRE",
    "TEST",
  ]
}
