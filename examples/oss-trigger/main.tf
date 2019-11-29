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
            "oss.aliyuncs.com"
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

resource "alicloud_oss_bucket" "this" {
  bucket = "terraform-fc-module"
}
resource "alicloud_oss_bucket_object" "this" {
  bucket  = alicloud_oss_bucket.this.id
  key     = "fc/hello.zip"
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
  events_function_oss_bucket = alicloud_oss_bucket.this.id
  events_function_oss_key    = alicloud_oss_bucket_object.this.key
  events_function_runtime    = "python3"
  trigger_role               = alicloud_ram_role.this.arn
  events_triggers = [
    {
      type       = "oss"
      source_arn = "acs:oss:${data.alicloud_regions.this.regions.0.id}:${data.alicloud_account.this.id}:${alicloud_oss_bucket.this.bucket}"
      config     = local.oss_trigger_conf
    },
  ]
}

