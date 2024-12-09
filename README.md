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
      
      service_name           = "tf-example"
      create_http_function   = true
      http_function_name     = "tf-example"
      http_function_handler  = "http.handler"
      http_function_filename = "../http_function.py"
      http_function_runtime  = "python3"
      http_triggers = [
        {
          type   = "http"
          config = <<EOF
            {
              "authType": "anonymous",
              "methods": ["GET", "POST"]
            }
            EOF
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

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_alicloud"></a> [alicloud](#provider\_alicloud) | n/a |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [alicloud_fc_function.events](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/fc_function) | resource |
| [alicloud_fc_function.http](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/fc_function) | resource |
| [alicloud_fc_service.this](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/fc_service) | resource |
| [alicloud_fc_trigger.event](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/fc_trigger) | resource |
| [alicloud_fc_trigger.http](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/resources/fc_trigger) | resource |
| [random_uuid.this](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/uuid) | resource |
| [alicloud_fc_services.this](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/data-sources/fc_services) | data source |
| [alicloud_ram_roles.service](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/data-sources/ram_roles) | data source |
| [alicloud_ram_roles.source](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/data-sources/ram_roles) | data source |
| [alicloud_ram_roles.trigger](https://registry.terraform.io/providers/hashicorp/alicloud/latest/docs/data-sources/ram_roles) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create_event_function"></a> [create\_event\_function](#input\_create\_event\_function) | Whether to create event function. | `bool` | `false` | no |
| <a name="input_create_http_function"></a> [create\_http\_function](#input\_create\_http\_function) | Whether to create http function. | `bool` | `false` | no |
| <a name="input_create_service"></a> [create\_service](#input\_create\_service) | Whether to create a new FC service. Default to true. | `bool` | `true` | no |
| <a name="input_events_function_filename"></a> [events\_function\_filename](#input\_events\_function\_filename) | The path to the function's deployment package within the local filesystem. It is conflict with the oss\_-prefixed options. | `string` | `""` | no |
| <a name="input_events_function_handler"></a> [events\_function\_handler](#input\_events\_function\_handler) | The FC function entry point in your code. | `string` | `""` | no |
| <a name="input_events_function_name"></a> [events\_function\_name](#input\_events\_function\_name) | The FC events function name. | `string` | `""` | no |
| <a name="input_events_function_oss_bucket"></a> [events\_function\_oss\_bucket](#input\_events\_function\_oss\_bucket) | The bucket of function's deployment package within the oss service. It is conflict with the filename. | `string` | `""` | no |
| <a name="input_events_function_oss_key"></a> [events\_function\_oss\_key](#input\_events\_function\_oss\_key) | The key of function's deployment package within the oss service. It is conflict with the filename. | `string` | `""` | no |
| <a name="input_events_function_runtime"></a> [events\_function\_runtime](#input\_events\_function\_runtime) | The FC function runtime type. | `string` | `"nodejs6"` | no |
| <a name="input_events_trigger_name"></a> [events\_trigger\_name](#input\_events\_trigger\_name) | The FC events trigger default name. | `string` | `""` | no |
| <a name="input_events_triggers"></a> [events\_triggers](#input\_events\_triggers) | List trigger fields to create events triggers | `list(map(string))` | `[]` | no |
| <a name="input_fc_function_events_description"></a> [fc\_function\_events\_description](#input\_fc\_function\_events\_description) | The Function Compute function description. | `string` | `""` | no |
| <a name="input_fc_function_http_description"></a> [fc\_function\_http\_description](#input\_fc\_function\_http\_description) | The Function Compute function description. | `string` | `""` | no |
| <a name="input_fc_service_description"></a> [fc\_service\_description](#input\_fc\_service\_description) | The Function Compute Service description. | `string` | `""` | no |
| <a name="input_filter_service_with_name_regex"></a> [filter\_service\_with\_name\_regex](#input\_filter\_service\_with\_name\_regex) | A regex string to filter results by FC service name. | `string` | `""` | no |
| <a name="input_function_memory_size"></a> [function\_memory\_size](#input\_function\_memory\_size) | Amount of memory in MB your Function can use at runtime. Defaults to 128. Limits to [128, 3072]. | `number` | `128` | no |
| <a name="input_function_timeout"></a> [function\_timeout](#input\_function\_timeout) | The amount of time your Function has to run in seconds. | `number` | `60` | no |
| <a name="input_http_function_filename"></a> [http\_function\_filename](#input\_http\_function\_filename) | The path to the function's deployment package within the local filesystem. It is conflict with the oss\_-prefixed options. | `string` | `""` | no |
| <a name="input_http_function_handler"></a> [http\_function\_handler](#input\_http\_function\_handler) | The FC function entry point in your code. | `string` | `""` | no |
| <a name="input_http_function_name"></a> [http\_function\_name](#input\_http\_function\_name) | The FC http function name. | `string` | `""` | no |
| <a name="input_http_function_oss_bucket"></a> [http\_function\_oss\_bucket](#input\_http\_function\_oss\_bucket) | The bucket of function's deployment package within the oss service. It is conflict with the filename. | `string` | `""` | no |
| <a name="input_http_function_oss_key"></a> [http\_function\_oss\_key](#input\_http\_function\_oss\_key) | The key of function's deployment package within the oss service. It is conflict with the filename. | `string` | `""` | no |
| <a name="input_http_function_runtime"></a> [http\_function\_runtime](#input\_http\_function\_runtime) | The FC function runtime type. | `string` | `"nodejs6"` | no |
| <a name="input_http_trigger_name"></a> [http\_trigger\_name](#input\_http\_trigger\_name) | The FC http trigger default name. | `string` | `""` | no |
| <a name="input_http_triggers"></a> [http\_triggers](#input\_http\_triggers) | List trigger fields to create http triggers | `list(map(string))` | `[]` | no |
| <a name="input_query_service_role"></a> [query\_service\_role](#input\_query\_service\_role) | Whther to query service role. If you don't set 'service\_role', you can use data source to query service role. Default to false. | `bool` | `false` | no |
| <a name="input_query_trigger_role"></a> [query\_trigger\_role](#input\_query\_trigger\_role) | Whther to query trigger role. If you don't set 'trigger\_role', you can use data source to query trigger role. Default to false. | `bool` | `false` | no |
| <a name="input_query_trigger_source_arn"></a> [query\_trigger\_source\_arn](#input\_query\_trigger\_source\_arn) | Whther to query trigger source arn. If you don't set 'trigger\_source\_arn', you can use data source to query trigger source arn. Default to false. | `bool` | `false` | no |
| <a name="input_service_internet_access"></a> [service\_internet\_access](#input\_service\_internet\_access) | Whether to allow the FC service to access Internet. Default to true. | `bool` | `true` | no |
| <a name="input_service_log_config"></a> [service\_log\_config](#input\_service\_log\_config) | Provide this to store your FC service logs. | <pre>list(object({<br>    logstore = string<br>    project  = string<br>  }))</pre> | `[]` | no |
| <a name="input_service_name"></a> [service\_name](#input\_service\_name) | The FC service name. | `string` | `""` | no |
| <a name="input_service_role"></a> [service\_role](#input\_service\_role) | RAM role arn attached to the FC service. This governs both who / what can invoke your Function, as well as what resources our Function has access to. | `string` | `""` | no |
| <a name="input_service_role_name_regex"></a> [service\_role\_name\_regex](#input\_service\_role\_name\_regex) | A regex string to filter roles by name regex. | `string` | `""` | no |
| <a name="input_service_role_policy_name"></a> [service\_role\_policy\_name](#input\_service\_role\_policy\_name) | A string to filter roles by policy name. | `string` | `""` | no |
| <a name="input_service_role_policy_type"></a> [service\_role\_policy\_type](#input\_service\_role\_policy\_type) | A string to filter roles by policy type. | `string` | `""` | no |
| <a name="input_service_vpc_config"></a> [service\_vpc\_config](#input\_service\_vpc\_config) | Provide this to allow your FC service to access your VPC. | <pre>list(object({<br>    security_group_id = string<br>    vswitch_ids       = list(string)<br>  }))</pre> | `[]` | no |
| <a name="input_source_role_name_regex"></a> [source\_role\_name\_regex](#input\_source\_role\_name\_regex) | A regex string to filter source roles by name regex. | `string` | `""` | no |
| <a name="input_source_role_policy_name"></a> [source\_role\_policy\_name](#input\_source\_role\_policy\_name) | A string to filter source roles by policy name. | `string` | `""` | no |
| <a name="input_source_role_policy_type"></a> [source\_role\_policy\_type](#input\_source\_role\_policy\_type) | A string to filter source roles by policy type. | `string` | `""` | no |
| <a name="input_trigger_role"></a> [trigger\_role](#input\_trigger\_role) | Default RAM role arn attached to the FC trigger. Role used by the event source to call the function. The value format is "acs:ram::$account-id:role/$role-name". | `string` | `""` | no |
| <a name="input_trigger_role_name_regex"></a> [trigger\_role\_name\_regex](#input\_trigger\_role\_name\_regex) | A regex string to filter roles by name regex. | `string` | `""` | no |
| <a name="input_trigger_role_policy_name"></a> [trigger\_role\_policy\_name](#input\_trigger\_role\_policy\_name) | A string to filter roles by policy name. | `string` | `""` | no |
| <a name="input_trigger_role_policy_type"></a> [trigger\_role\_policy\_type](#input\_trigger\_role\_policy\_type) | A string to filter roles by policy type. | `string` | `""` | no |
| <a name="input_trigger_source_arn"></a> [trigger\_source\_arn](#input\_trigger\_source\_arn) | Event source resource address. | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_this_events_function_id"></a> [this\_events\_function\_id](#output\_this\_events\_function\_id) | The id of the events function. |
| <a name="output_this_events_function_name"></a> [this\_events\_function\_name](#output\_this\_events\_function\_name) | The name of the events function. |
| <a name="output_this_events_trigger_ids"></a> [this\_events\_trigger\_ids](#output\_this\_events\_trigger\_ids) | The ids of the events trigger. |
| <a name="output_this_events_trigger_names"></a> [this\_events\_trigger\_names](#output\_this\_events\_trigger\_names) | The names of the events trigger. |
| <a name="output_this_http_function_id"></a> [this\_http\_function\_id](#output\_this\_http\_function\_id) | The id of the http function. |
| <a name="output_this_http_function_name"></a> [this\_http\_function\_name](#output\_this\_http\_function\_name) | The name of the http function. |
| <a name="output_this_http_trigger_ids"></a> [this\_http\_trigger\_ids](#output\_this\_http\_trigger\_ids) | The ids of the http trigger. |
| <a name="output_this_http_trigger_names"></a> [this\_http\_trigger\_names](#output\_this\_http\_trigger\_names) | The names of the http trigger. |
| <a name="output_this_service_id"></a> [this\_service\_id](#output\_this\_service\_id) | The service ID. |
| <a name="output_this_service_name"></a> [this\_service\_name](#output\_this\_service\_name) | The service name. |
<!-- END_TF_DOCS -->

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
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13.0 |
| <a name="requirement_alicloud"></a> [alicloud](#requirement\_alicloud) | >= 1.56.0 |

Authors
-------
Created and maintained by Alibaba Cloud Terraform Team(terraform@alibabacloud.com)

Reference
---------
* [Terraform-Provider-Alicloud Github](https://github.com/terraform-providers/terraform-provider-alicloud)
* [Terraform-Provider-Alicloud Release](https://releases.hashicorp.com/terraform-provider-alicloud/)
* [Terraform-Provider-Alicloud Docs](https://www.terraform.io/docs/providers/alicloud/index.html)