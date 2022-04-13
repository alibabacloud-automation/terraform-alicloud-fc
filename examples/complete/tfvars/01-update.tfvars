##############################################################
#variables events-apigateway-trigger
##############################################################
description             = "This is a fc service created by terraform update"
function_timeout        = 120
function_memory_size    = 256
events_function_runtime = "nodejs8"
event_description       = "This is an fc events function created by terraform update"
events_function_name    = "terraform-fc-events-function-update"
service_log_config      = []
service_vpc_config      = []
events_function_filename = "../events_function.js"
service_internet_access = false
events_function_handler = "index.handler"

##############################################################
#variables http-apigateway-trigger
##############################################################
description             = "This is a fc service created by terraform update"
event_description       = "This is an fc events function created by terraform update"
http_function_name      = "terraform-fc-http-function-update"
