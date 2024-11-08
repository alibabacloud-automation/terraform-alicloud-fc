locals {
  http_trigger_conf = <<EOF
  {
    "authType": "anonymous",
    "disableURLInternet":false,
    "methods": ["GET", "POST"]
  }
  EOF

}