locals {
  log_trigger_conf = <<EOF
  {
        "sourceConfig": {
            "logstore": "${alicloud_log_store.default.name}",
            "startTime": null
        },
        "jobConfig": {
            "maxRetryTime": 3,
            "triggerInterval": 60
        },
        "functionParameter": {
            "a": "b",
            "c": "d"
        },
        "logConfig": {
            "project": "${alicloud_log_project.default.name}",
            "logstore": "${alicloud_log_store.default2.name}"
        },
        "enable": true
    }
  EOF
}