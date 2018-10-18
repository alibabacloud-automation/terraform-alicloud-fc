# alicloud_fc_trigger

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| service | The FC service name | string | - | yes |
| function | The FC function name | string | - | yes |
| name | The FC trigger name | string | - | yes |
| role | RAM role arn attached to the FC trigger. Role used by the event source to call the function. The value format is "acs:ram::$account-id:role/$role-name". | string | - | no |
| source_arn | Event source resource address | string | - | no |
| type | The Type of the trigger. Valid values: ["oss", "log", "timer", "http"]. | string | - | yes |
| config | The config of FC trigger | string | - | no |


## Outputs

| Name | Description |
|------|-------------|
| id | The ID of the Trigger |
| name | The name of the Trigger |