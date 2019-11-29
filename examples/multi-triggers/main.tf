data "alicloud_account" "this" {}

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
            "mns.aliyuncs.com"
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

resource "alicloud_mns_topic" "this" {
  name = "terraform-fc-module"
}

module "multi-triggers" {
  source                     = "../.."
  service_name               = "multi-triggers"
  create_event_function      = true
  events_function_filename = "../events_function.py"
  events_function_runtime    = "python3"
  trigger_role               = alicloud_ram_role.this.arn
  events_triggers = [
    {
      type       = "mns_topic"
      source_arn = "acs:mns:${data.alicloud_regions.this.regions.0.id}:${data.alicloud_account.this.id}:/topics/${alicloud_mns_topic.this.name}"
      config_mns = local.mns_trigger_conf
    },
    {
      type   = "timer"
      config = local.timer_trigger_conf
    },
  ]
  create_http_function   = true
  http_function_filename = "../http_function.py"
  http_function_runtime  = "python3"
  http_triggers = [
    {
      type   = "http"
      config = local.http_trigger_conf
    }
  ]
}

