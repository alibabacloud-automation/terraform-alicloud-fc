locals {
  http_trigger_conf = <<EOF
  {
    "authType": "anonymous",
    "methods": ["GET", "POST"]
  }
  EOF

}
