locals {
  mns_trigger_conf = <<EOF
  {"filterTag":"testTag","notifyContentFormat":"STREAM","notifyStrategy":"BACKOFF_RETRY"}
  EOF

  timer_trigger_conf = <<EOF
  {
		"payload": "aaaaa",
		"cronExpression": "0 1/1000 * * * *",
		"enable": true
	}
  EOF

  http_trigger_conf = <<EOF
  {
    "authType": "anonymous",
    "disableURLInternet":false,
    "methods": ["GET", "POST"]
  }
  EOF

}