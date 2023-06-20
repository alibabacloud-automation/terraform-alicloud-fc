locals {
  cdn_trigger_conf = <<EOF
  {
		"eventName": "LogFileCreated",
		"eventVersion": "1.0.0",
		"notes": "cdn events trigger",
		"filter": {
			"domain": ["${alicloud_cdn_domain_new.default.domain_name}"]
		}
	}
  EOF
}