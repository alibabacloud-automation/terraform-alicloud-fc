locals {
  log_trigger_conf = <<EOF
  {
        "sourceConfig": {
            "logstore": "${alicloud_log_store.this.name}"
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
            "project": "${alicloud_log_project.this.name}",
            "logstore": "${alicloud_log_store.this1.name}"
        },
        "enable": true
    }
  EOF
}