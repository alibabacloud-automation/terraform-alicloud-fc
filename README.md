Alicloud Function Compute (FC) Terraform Module
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

Usage
-----
You can use this in your terraform template with the following steps.

1. Adding a module resource to your template, e.g. main.tf


         module "tf-fc" {
            source = "terraform-alicloud-modules/alibaba/fc/alicloud"

            service = "tf-module-service"
            function = "tr-module-function"
            filename = "./hello.zip"
            runtime = "python2.7"
            handler = "hello.handler"
            trigger = "tf-module-trigger"
            type = "http"
            config = <<EOF
            {
            "authType" : "anonymous",
            "methods" : ["GET", "POST"]
            }
            EOF

         }

2. Setting values for the following variables through environment variables:

    - ALICLOUD_ACCESS_KEY
    - ALICLOUD_SECRET_KEY
    - ALICLOUD_REGION


Authors
-------
Created and maintained by Kevin(@muxiangqiu muxiangqiu@gmail.com)

Reference
---------
* [Terraform-Provider-Alicloud Github](https://github.com/terraform-providers/terraform-provider-alicloud)
* [Terraform-Provider-Alicloud Release](https://releases.hashicorp.com/terraform-provider-alicloud/)
* [Terraform-Provider-Alicloud Docs](https://www.terraform.io/docs/providers/alicloud/index.html)
