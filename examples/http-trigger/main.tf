module "http-trigger" {
  source                 = "../.."
  service_name           = "http-trigger"
  create_http_function   = true
  http_function_filename = "../http_function.py"
  http_function_runtime  = "python3"
  http_triggers = [
    {
      type   = "http"
      config = local.http_trigger_conf
    }
  ]
}