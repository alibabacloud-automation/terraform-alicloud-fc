Alicloud Function Compute (FC) Terraform Module  
terraform-alicloud-fc

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

    ```hcl
    module "tf-fc" {
      source = "terraform-alicloud-modules/fc/alicloud"
      
      service_name           = "production-triggers"
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
    ```

2. Setting values for the following variables through environment variables:

    - ALICLOUD_ACCESS_KEY
    - ALICLOUD_SECRET_KEY
    - ALICLOUD_REGION


## Conditional creation

This moudle can create FC Function and Triggers using a existing FC Service.

1. To create http function and triggers, but not create service:
    ```hcl
    create_service                 = false
    filter_service_with_name_regex = "existing-service-name-regex"
    create_http_function           = true
    http_triggers = [
      {
        type   = "http"
        config = "http-trigger-conf"
      }
    ]
    ```

1. To create service, events function and triggers:
    ```hcl
    create_service        = true
    create_event_function = true
    events_triggers = [
      {
        type   = "timer"
        config = "timer-trigger-conf"
      }
    ]
    ```

1. Create both http and event functions and retrieve the existing role by name regex, you can also retrieve role by policy name and policy type:
    ```hcl
    create_event_function    = true
    create_http_function     = true
    service_role_name_regex  = "existing-role-name-regex"
    trigger_role_name_regex  = "existing-role-name-regex"
    trigger_role_policy_name = "existing-policy-name"
    trigger_role_policy_type = "your-policy-type"
    ```

1. Create several event triggers:
    ```hcl
    create_service        = true
    create_event_function = true
    events_triggers = [
      {
        type   = "timer"
        config = "timer-trigger-conf"
      },
      {
        type       = "mns"
        source_arn = "mns-source-arn"
        config     = "mns-trigger-conf"
      }
    ] 
    ```

1. Create several event triggers and use different roles:
    ```hcl
    create_service        = true
    create_event_function = true
    events_triggers = [
      {
        type   = "timer"
        config = "timer-trigger-conf"
      },
      {
        type       = "mns"
        role       = "exist-role-arn"
        source_arn = "mns-source-arn"
        config     = "mns-trigger-conf"
      }
    ] 
    ```
    
1. Create functions but not triggers:
    ```hcl
    create_service        = true
    create_event_function = true
    create_http_function  = true
    ```
    
## Examples of triggers

1. [HTTP trigger](https://github.com/terraform-alicloud-modules/terraform-alicloud-fc/tree/master/examples/http-trigger):
    ```hcl
    create_http_function = true
    http_triggers = [
      {
        type   = "http"
        config = local.http_trigger_conf
      }
    ]
    ```
    
1. [ApiGatway trigger](https://github.com/terraform-alicloud-modules/terraform-alicloud-fc/tree/master/examples/api-trigger):
    ```hcl
    module "apigateway-trigger" {
      # omitted for brevity
      create_event_function    = true
    }

    resource "alicloud_api_gateway_api" "apiGatewayApi" {
      # omitted for brevity
      service_type = "FunctionCompute"
      fc_service_config {
        region        = data.alicloud_regions.this.id
        function_name = module.apigateway-trigger.this_events_function_name
        service_name  = module.apigateway-trigger.this_service_name
        arn_role      = alicloud_ram_role.this.arn
        timeout       = 10
      }
    }
 
    ```
    
1. [CDN trigger](https://github.com/terraform-alicloud-modules/terraform-alicloud-fc/tree/master/examples/cdn-trigger):
    ```hcl
    create_event_function = true
    events_triggers = [
      {
        type       = "cdn_events"
        source_arn = "acs:cdn:*:[account_id]"
        config     = local.cdn_trigger_conf
      },
    ]
    ```
    
1. [Log trigger](https://github.com/terraform-alicloud-modules/terraform-alicloud-fc/tree/master/examples/log-trigger):
    ```hcl
    create_event_function = true
    events_triggers = [
      {
        type       = "log"
        source_arn = "acs:log:[region_id]:[account_id]:project/[log_project_name]"
        config     = local.log_trigger_conf
      },
    ]
    ```
    
1. [Mns trigger](https://github.com/terraform-alicloud-modules/terraform-alicloud-fc/tree/master/examples/mns-trigger):
    ```hcl
    create_event_function = true
    events_triggers = [
      {
        type       = "mns_topic"
        source_arn = "acs:mns:[region_id]:[account_id]:/topics/[mns_topic_name]"
        config     = local.mns_trigger_conf
      },
    ]
    ```
    
1. [Oss trigger](https://github.com/terraform-alicloud-modules/terraform-alicloud-fc/tree/master/examples/oss-trigger):
    ```hcl
    create_event_function = true
    events_triggers = [
      {
        type       = "oss"
        source_arn = "acs:oss:[region_id]:[account_id]:[oss_bucket_name]"
        config     = local.oss_trigger_conf
      },
    ]
    ```
    
1. [Timer trigger](https://github.com/terraform-alicloud-modules/terraform-alicloud-fc/tree/master/examples/timer-trigger):
    ```hcl
    create_event_function = true
    events_triggers = [
      {
        type       = "timer"
        config     = local.timer_trigger_conf
      },
    ]
    ```



## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| create_service | Whether to create a new FC service. Default to true. | bool | true | no |
| filter_service_with_name_regex | A regex string to filter results by FC service name. | string | "" | no |
| service_name | The FC service name | string | "terraform-fc-service" | no |
| service_internet_access | Whether to allow the FC service to access Internet. Default to true. | bool | true | no |
| service_role | RAM role arn attached to the FC service. This governs both who / what can invoke your Function, as well as what resources our Function has access to. | string | "" | no |
| service_role_name_regex | A regex string to filter roles by name regex. | string | "" | no |
| service_role_policy_name | A string to filter roles by policy name. | string | "" | no |
| service_role_policy_type | A string to filter roles by policy type. | string | "" | no |
| service_log_config | Provide this to store your FC service logs. | list | [] | no |
| service_vpc_config | Provide this to allow your FC service to access your VPC. | list | [] | no |
| function_memory_size | Amount of memory in MB your Function can use at runtime. Defaults to 128. Limits to [128, 3072]. | int | 128 | no |
| function_timeout | The amount of time your Function has to run in seconds. | int | 60 | no |
| create_http_function | Whether to create http function. | bool | false | no |
| http_function_name | The FC http function name. | string | "terraform-fc-http-function" | no |
| http_function_filename | The path to the function's deployment package within the local filesystem. It is conflict with the oss_-prefixed options. | string | "" | no |
| http_function_oss_bucket | The bucket of function's deployment package within the oss service. It is conflict with the filename. | string | "" | no |
| http_function_oss_key | The key of function's deployment package within the oss service. It is conflict with the filename. | string | "" | no |
| http_function_runtime | The FC function runtime type. Valid values: ["nodejs6", "nodejs8", "python2.7", "python3", "php7.2", "java8"] | string | "nodejs6" | no |
| http_function_handler | The FC function entry point in your code. | string | "index.handler" | no |
| create_event_function | Whether to create event function. | bool | false | no |
| events_function_name | The FC events function name. | string | "terraform-fc-events-function" | no |
| events_function_filename | The path to the function's deployment package within the local filesystem. It is conflict with the oss_-prefixed options. | string | "" | no |
| events_function_oss_bucket | The bucket of function's deployment package within the oss service. It is conflict with the filename. | string | "" | no |
| events_function_oss_key | The key of function's deployment package within the oss service. It is conflict with the filename. | string | "" | no |
| events_function_runtime | The FC function runtime type. Valid values: ["nodejs6", "nodejs8", "python2.7", "python3", "php7.2", "java8"] | string | "nodejs6" | no |
| events_function_handler | The FC function entry point in your code. | string | "index.handler" | no |
| trigger_role | Default RAM role arn attached to the FC trigger. Role used by the event source to call the function. The value format is \"acs:ram::$account-id:role/$role-name\". | string | "" | no |
| trigger_source_arn | Event source resource address. | string | "" | no |
| trigger_role_name_regex | A regex string to filter roles by name regex. | string | "" | no |
| trigger_role_policy_name | A string to filter roles by policy name. | string | "" | no |
| trigger_role_policy_type | A string to filter roles by policy type. | string | "" | no |
| source_role_name_regex | A regex string to filter source roles by name regex. | string | "" | no |
| source_role_policy_name | A string to filter source roles by policy name. | string | "" | no |
| source_role_policy_type | A string to filter source roles by policy type. | string | "" | no |
| http_trigger_name | The FC http trigger default name. | string | "terraform-http-trigger" | no |
| http_triggers | List trigger fields to create http triggers | list(map(string)) | [] | no |
| events_trigger_name | The FC events trigger default name. | string | "terraform-events-trigger" | no |
| events_triggers | List trigger fields to create events triggers | list(map(string)) | [] | no |


## Outputs

| Name | Description |
|------|-------------|
| this_service_id | The ID of the Service |
| this_service_name | The name of the Service |
| this_http_function_id | The ID of the http Function |
| this_http_function_name | The name of the http Function |
| this_http_trigger_ids | The IDs of the http Triggers |
| this_http_trigger_names | The names of the http Triggers |
| this_events_function_id | The ID of the events Function |
| this_events_function_name | The name of the events Function |
| this_events_trigger_ids | The IDs of the events Triggers |
| this_events_trigger_names | The names of the events Triggers |

## Notes
From the version v1.3.0, the module has removed the following `provider` setting:

```hcl
provider "alicloud" {
   version                 = ">=1.56.0"
   profile                 = var.profile != "" ? var.profile : null
   shared_credentials_file = var.shared_credentials_file != "" ? var.shared_credentials_file : null
   region                  = var.region != "" ? var.region : null
   skip_region_validation  = var.skip_region_validation
   configuration_source    = "terraform-alicloud-modules/fc"
}
```

If you still want to use the `provider` setting to apply this module, you can specify a supported version, like 1.2.0:

```hcl
module "tf-fc" {
   source               = "terraform-alicloud-modules/fc/alicloud"
   version              = "1.2.0"
   region               = "cn-beijing"
   profile              = "Your-Profile-Name"
   service_name         = "production-triggers"
   create_http_function = true
   // ...
}
```

If you want to upgrade the module to 1.3.0 or higher in-place, you can define a provider which same region with
previous region:

```hcl
provider "alicloud" {
  region  = "cn-beijing"
  profile = "Your-Profile-Name"
}
module "tf-fc" {
   source               = "terraform-alicloud-modules/fc/alicloud"
   service_name         = "production-triggers"
   create_http_function = true
  // ...
}
```
or specify an alias provider with a defined region to the module using `providers`:

```hcl
provider "alicloud" {
  region  = "cn-beijing"
  profile = "Your-Profile-Name"
  alias   = "bj"
}
module "tf-fc" {
   source               = "terraform-alicloud-modules/fc/alicloud"
   providers            = {
      alicloud = alicloud.bj
   }
   service_name         = "production-triggers"
   create_http_function = true
   // ...
}
```

and then run `terraform init` and `terraform apply` to make the defined provider effect to the existing module state.

More details see [How to use provider in the module](https://www.terraform.io/docs/language/modules/develop/providers.html#passing-providers-explicitly)

## Terraform versions

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12.0 |
| <a name="requirement_alicloud"></a> [alicloud](#requirement\_alicloud) | >= 1.56.0 |

Authors
-------
Created and maintained by Alibaba Cloud Terraform Team(terraform@alibabacloud.com)

Reference
---------
* [Terraform-Provider-Alicloud Github](https://github.com/terraform-providers/terraform-provider-alicloud)
* [Terraform-Provider-Alicloud Release](https://releases.hashicorp.com/terraform-provider-alicloud/)
* [Terraform-Provider-Alicloud Docs](https://www.terraform.io/docs/providers/alicloud/index.html)
