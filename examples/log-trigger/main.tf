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

resource "alicloud_log_project" "this" {
  name        = "terraform-fc-module"
  description = "tf unit test"
}
resource "alicloud_log_store" "this" {
  project          = alicloud_log_project.this.name
  name             = "terraform-fc-module-source"
  retention_period = "3000"
  shard_count      = 1
}
resource "alicloud_log_store" "this1" {
  project          = alicloud_log_project.this.name
  name             = "terraform-fc-module"
  retention_period = "3000"
  shard_count      = 1
}

module "log-trigger" {
  source                   = "../.."
  service_name             = "log-trigger"
  create_event_function    = true
  events_function_filename = "../events_function.php"
  events_function_runtime  = "php7.2"
  trigger_role             = alicloud_ram_role.this.arn
  events_triggers = [
    {
      type       = "log"
      source_arn = "acs:log:${data.alicloud_regions.this.regions.0.id}:${data.alicloud_account.this.id}:project/${alicloud_log_project.this.name}"
      config     = local.log_trigger_conf
    },
  ]
}

