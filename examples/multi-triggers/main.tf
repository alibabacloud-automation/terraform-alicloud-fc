resource "random_integer" "default" {
  max = 99999
  min = 10000
}
data "alicloud_account" "default" {
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
            "mns.aliyuncs.com"
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

resource "alicloud_mns_topic" "default" {
  name = "tf-example-${random_integer.default.result}"
}

module "multi-triggers" {
  source                   = "../.."
  service_name             = "tf-example-${random_integer.default.result}"
  create_event_function    = true
  events_function_name     = "tf-example-event-${random_integer.default.result}"
  service_role             = alicloud_ram_role.default.arn
  events_function_handler  = "index.handler"
  events_function_filename = "../events_function.py"
  events_function_runtime  = "python3"
  trigger_role             = alicloud_ram_role.default.arn
  events_triggers = [
    {
      type       = "mns_topic"
      source_arn = "acs:mns:${data.alicloud_regions.default.regions[0].id}:${data.alicloud_account.default.id}:/topics/${alicloud_mns_topic.default.name}"
      config_mns = local.mns_trigger_conf
    },
    {
      type   = "timer"
      config = local.timer_trigger_conf
    },
  ]
  create_http_function   = true
  http_function_name     = "tf-example-http-${random_integer.default.result}"
  http_function_filename = "../http_function.py"
  http_function_runtime  = "python3"
  http_function_handler  = "http.handler"
  http_triggers = [
    {
      type   = "http"
      config = local.http_trigger_conf
    }
  ]
}