# FC Trigger
resource "alicloud_fc_trigger" "http" {
  count      = var.create_http_function ? length(var.http_triggers) : 0
  service    = local.service_name
  function   = alicloud_fc_function.http[0].name
  name       = "${local.http_trigger_name}-${count.index}"
  role       = lookup(var.http_triggers[count.index], "role", local.trigger_role)
  source_arn = lookup(var.http_triggers[count.index], "source_arn", local.trigger_source_arn)
  type       = lookup(var.http_triggers[count.index], "type", "")
  config     = lookup(var.http_triggers[count.index], "config", "")
}

resource "alicloud_fc_trigger" "event" {
  count      = var.create_event_function ? length(var.events_triggers) : 0
  service    = local.service_name
  function   = alicloud_fc_function.events[0].name
  name       = "${local.events_trigger_name}-${count.index}"
  role       = lookup(var.events_triggers[count.index], "role", local.trigger_role)
  source_arn = lookup(var.events_triggers[count.index], "source_arn", local.trigger_source_arn)
  type       = lookup(var.events_triggers[count.index], "type", "")
  config     = lookup(var.events_triggers[count.index], "config", null)
  config_mns = lookup(var.events_triggers[count.index], "config_mns", null)
}