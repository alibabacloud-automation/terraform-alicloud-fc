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
            "oss.aliyuncs.com"
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

resource "alicloud_oss_bucket" "default" {
  bucket = "tf-example-${random_integer.default.result}"
}
resource "alicloud_oss_bucket_object" "default" {
  bucket  = alicloud_oss_bucket.default.id
  key     = "source/hello.py"
  content = <<EOF
		# -*- coding: utf-8 -*-
		def handler(event, context):
			print "hello world"
			return 'hello world'
	EOF
}

module "oss-trigger" {
  source                     = "../.."
  service_name               = "oss-trigger"
  create_event_function      = true
  events_function_name       = "tf-example-event-${random_integer.default.result}"
  service_role               = alicloud_ram_role.default.arn
  events_function_handler    = "index.handler"
  events_function_oss_bucket = alicloud_oss_bucket.default.id
  events_function_oss_key    = alicloud_oss_bucket_object.default.key
  events_function_runtime    = "python3"
  trigger_role               = alicloud_ram_role.default.arn
  events_triggers = [
    {
      type       = "oss"
      source_arn = "acs:oss:${data.alicloud_regions.default.regions[0].id}:${data.alicloud_account.default.id}:${alicloud_oss_bucket.default.bucket}"
      config     = local.oss_trigger_conf
    },
  ]
}