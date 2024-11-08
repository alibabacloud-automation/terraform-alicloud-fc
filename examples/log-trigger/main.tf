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

resource "alicloud_log_project" "default" {
  name        = "tf-example-${random_integer.default.result}"
  description = "tf-example"
}
resource "alicloud_log_store" "default" {
  project          = alicloud_log_project.default.name
  name             = "tf-example-${random_integer.default.result}"
  retention_period = "3000"
  shard_count      = 1
}
resource "alicloud_log_store" "default2" {
  project          = alicloud_log_project.default.name
  name             = "tf-example-2-${random_integer.default.result}"
  retention_period = "3000"
  shard_count      = 1
}

module "log-trigger" {
  source                   = "../.."
  service_name             = "log-trigger"
  create_event_function    = true
  events_function_name     = "tf-example-event-${random_integer.default.result}"
  service_role             = alicloud_ram_role.default.arn
  events_function_handler  = "index.handler"
  events_function_filename = "../events_function.php"
  events_function_runtime  = "php7.2"
  trigger_role             = alicloud_ram_role.default.arn
  events_triggers = [
    {
      type       = "log"
      source_arn = "acs:log:${data.alicloud_regions.default.regions[0].id}:${data.alicloud_account.default.id}:project/${alicloud_log_project.default.name}"
      config     = local.log_trigger_conf
    },
  ]
}