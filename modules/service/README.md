# alicloud_fc_service

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| name | The FC service name | string | - | yes |
| description | The FC service description  | string | - | no |
| internet_access | Whether to allow the service to access Internet | boolean | true | no |
| role | RAM role arn attached to the FC service. This governs both who / what can invoke your Function, as well as what resources our Function has access to | string | - | no |
| log_config | Provide this to store your FC service logs. See [log_config](#log_config)  for more details. | map | - | no |
| vpc_config | Provide this to allow your FC service to access your VPC. See [vpc_config](#vpc_config) for more details. | map | - | no |

## Outputs

| Name | Description |
|------|-------------|
| id | The ID of the Service |
| name | The name of the Service |

## log_config

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| project | The project name of Logs service | string | - | yes |
| description | The log store name of Logs service | string | - | yes |

NOTE: If both project and logstore are empty, log_config is considered to be empty or unset.

## vpc_config

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| vswitch_ids | T A list of vswitch IDs associated with the FC service | list | - | yes |
| security_group_id | A security group ID associated with the FC service | string | - | yes |

NOTE: If both vswitch_ids and security_group_id are empty, vpc_config is considered to be empty or unset.

