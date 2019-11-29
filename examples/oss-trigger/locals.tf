locals {
  oss_trigger_conf = <<EOF
  {
		"events": [
		  "oss:ObjectCreated:PostObject",
          "oss:ObjectCreated:PutObject"
		],
		"filter": {
			"key": {
                "prefix": "source/",
                "suffix": ".png"
			}
		}
	}
  EOF
}
