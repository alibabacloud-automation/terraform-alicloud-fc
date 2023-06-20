resource "random_integer" "default" {
  max = 99999
  min = 10000
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
            "log.aliyuncs.com"
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

module "timer-trigger" {
  source                   = "../.."
  service_name             = "timer-trigger"
  create_event_function    = true
  events_function_name     = "tf-example-event-${random_integer.default.result}"
  service_role             = alicloud_ram_role.default.arn
  events_function_handler  = "index.handler"
  events_function_filename = "../events_function.py"
  events_function_runtime  = "python3"
  trigger_role             = alicloud_ram_role.default.arn
  events_triggers = [
    {
      type   = "timer"
      config = local.timer_trigger_conf
    },
  ]
}