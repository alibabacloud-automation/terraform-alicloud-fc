resource "random_integer" "default" {
  max = 99999
  min = 10000
}

module "http-trigger" {
  source                 = "../.."
  service_name           = "tf-example-${random_integer.default.result}"
  create_http_function   = true
  http_function_name     = "tf-example-http-${random_integer.default.result}"
  http_function_handler  = "http.handler"
  http_function_filename = "../http_function.py"
  http_function_runtime  = "python3"
  http_triggers = [
    {
      type   = "http"
      config = local.http_trigger_conf
    }
  ]
}