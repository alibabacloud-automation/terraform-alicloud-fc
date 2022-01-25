data "alicloud_account" "this" {
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
            "cdn.aliyuncs.com"
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

resource "alicloud_cdn_domain_new" "this" {
  domain_name = "terraform-fc-module.xiaozhu.com"
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
  service_name             = "cdn-trigger"
  create_event_function    = true
  events_function_filename = "../events_function.py"
  events_function_runtime  = "python3"
  trigger_role             = alicloud_ram_role.this.arn
  events_triggers = [
    {
      type       = "cdn_events"
      source_arn = "acs:cdn:*:${data.alicloud_account.this.id}"
      config     = local.cdn_trigger_conf
    },
  ]
}