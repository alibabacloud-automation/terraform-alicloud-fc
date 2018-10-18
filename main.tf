######
# FC Service
######
module "fc_service" {
  source = "./modules/service"

  name = "${var.service}"
}

#################
# FC Function
#################
module "fc_function" {
  source = "./modules/function"

  service     = "${module.fc_service.name}"
  name        = "${var.function}"
  filename    = "${var.filename}"
  memory_size = "${var.memory_size}"
  runtime     = "${var.runtime}"
  handler     = "${var.handler}"
  timeout     = "${var.timeout}"
}

#################
# FC Trigger
#################
module "fc_trigger" {
  source = "./modules/trigger"

  service  = "${module.fc_service.name}"
  function = "${module.fc_function.name}"
  name     = "${var.trigger}"
  type     = "${var.type}"
  config   = "${var.config}"
}
