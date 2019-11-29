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
            "log.aliyuncs.com"
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

module "timer-trigger" {
  source                   = "../.."
  service_name             = "timer-trigger"
  create_event_function    = true
  events_function_filename = "../events_function.py"
  events_function_runtime  = "python3"
  trigger_role             = alicloud_ram_role.this.arn
  events_triggers = [
    {
      type   = "timer"
      config = local.timer_trigger_conf
    },
  ]
}

