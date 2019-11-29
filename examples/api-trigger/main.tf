data "alicloud_regions" "this" {
  current = true
}

resource "alicloud_ram_role" "this" {
  name        = "terraform-fc-module-trigger"
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

module "apigateway-trigger" {
  source                   = "../.."
  service_name             = "apigateway-trigger"
  create_event_function    = true
  events_function_filename = "../events_function.js"
  events_function_runtime  = "nodejs8"
}


resource "alicloud_api_gateway_group" "this" {
  name        = "terraform_fc_module"
  description = "created by terraform-fc-module"
}

resource "alicloud_api_gateway_api" "apiGatewayApi" {
  name        = "terraform_fc_module"
  group_id    = alicloud_api_gateway_group.this.id
  description = "create by terraform-fc-module"
  auth_type   = "APP"

  request_config {
    protocol    = "HTTP"
    method      = "POST"
    path        = "/test/path2"
    mode        = "MAPPING"
    body_format = "STREAM"
  }

  service_type = "FunctionCompute"

  fc_service_config {
    region        = data.alicloud_regions.this.id
    function_name = module.apigateway-trigger.this_events_function_name
    service_name  = module.apigateway-trigger.this_service_name
    arn_role      = alicloud_ram_role.this.arn
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

