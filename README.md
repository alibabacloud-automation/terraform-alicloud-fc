Alicloud Function Compute (FC) Terraform Module  
terraform-alicloud-fc
=============================================

Terraform module which creates FC resources on Alibaba Cloud.

These types of resources are supported:

* [service](https://www.terraform.io/docs/providers/alicloud/r/fc_service.html)
* [function](https://www.terraform.io/docs/providers/alicloud/r/fc_function.html)
* [trigger](https://www.terraform.io/docs/providers/alicloud/r/fc_trigger.html)

Root module calls these modules which can also be used separately to create independent resources:

* [service](https://github.com/terraform-alicloud-modules/terraform-alicloud-fc/tree/master/modules/service) - creates Service
* [function](https://github.com/terraform-alicloud-modules/terraform-alicloud-fc/tree/master/modules/function) - creates Function
* [trigger](https://github.com/terraform-alicloud-modules/terraform-alicloud-fc/tree/master/modules/trigger) - creates Trigger

----------------------

Usage
-----
You can use this in your terraform template with the following steps.

1. Adding a module resource to your template, e.g. main.tf


    ```
    module "tf-fc" {
        source   = "terraform-alicloud-modules/alibaba/fc/alicloud"

        service  = "tf-module-service"
        function = "tr-module-function"
        filename = "./hello.zip"
        runtime  = "python2.7"
        handler  = "hello.handler"
        trigger  = "tf-module-trigger"
        type     = "http"
        config   = <<EOF
        {
            "authType" : "anonymous",
            "methods" : ["GET", "POST"]
        }
        EOF

    }
    ```

2. Setting values for the following variables through environment variables:

    - ALICLOUD_ACCESS_KEY
    - ALICLOUD_SECRET_KEY
    - ALICLOUD_REGION

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| service | The FC service name | string | - | yes |
| function | The FC function name | string | - | yes |
| filename | The path to the function's deployment package within the local filesystem. It is conflict with the oss_-prefixed options | string | - | yes |
| memory_size | Amount of memory in MB your Function can use at runtime. Defaults to 128. Limits to [128, 3072] | int | 512 | no |
| runtime | The FC function runtime type | string | - | yes |
| handler | The FC function entry point in your code | string | - | yes |
| timeout | The amount of time your Function has to run in seconds | int | 60 | no |
| trigger | The FC trigger name | string | - | yes |
| type | The Type of the trigger. Valid values: ["oss", "log\", "timer", "http"] | string | - | yes |
| config | The config of FC trigger | string | - | no |


## Outputs

| Name | Description |
|------|-------------|
| this_service_id | The ID of the Service |
| this_service_name | The name of the Service |
| this_function_id | The ID of the Function |
| this_function_name | The name of the Function |
| this_trigger_id | The ID of the Trigger |
| this_trigger_name | The name of the Trigger |


Authors
-------
Created and maintained by Kevin(@muxiangqiu muxiangqiu@gmail.com)

Reference
---------
* [Terraform-Provider-Alicloud Github](https://github.com/terraform-providers/terraform-provider-alicloud)
* [Terraform-Provider-Alicloud Release](https://releases.hashicorp.com/terraform-provider-alicloud/)
* [Terraform-Provider-Alicloud Docs](https://www.terraform.io/docs/providers/alicloud/index.html)
