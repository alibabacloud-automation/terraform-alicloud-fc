locals {
  mns_trigger_conf = <<EOF
  {"filterTag":"testTag","notifyContentFormat":"STREAM","notifyStrategy":"BACKOFF_RETRY"}
  EOF
}
