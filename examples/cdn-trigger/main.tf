resource "random_integer" "default" {
  max = 99999
  min = 10000
}

data "alicloud_account" "default" {
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
            "cdn.aliyuncs.com"
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

resource "alicloud_cdn_domain_new" "default" {
  domain_name = "tf-example${random_integer.default.result}.com"
  cdn_type    = "web"
  scope       = "overseas"
  sources {
    content  = "1.1.1.1"
    type     = "ipaddr"
    priority = 20
    port     = 80
    weight   = 10
  }
}

module "cdn-trigger" {
  source                   = "../.."
  service_name             = "tf-example-${random_integer.default.result}"
  service_role             = alicloud_ram_role.default.arn
  create_event_function    = true
  events_function_filename = "../events_function.py"
  events_function_runtime  = "python3"
  trigger_role             = alicloud_ram_role.default.arn
  events_function_name     = "tf-example-event-${random_integer.default.result}"
  events_function_handler  = "index.handler"
  events_triggers = [
    {
      type       = "cdn_events"
      source_arn = "acs:cdn:*:${data.alicloud_account.default.id}"
      config     = local.cdn_trigger_conf
    },
  ]
}