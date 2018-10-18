# alicloud_fc_function

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| service | The FC service name | string | - | yes |
| name | The FC function name | string | - | yes |
| description | The FC function description | string | - | no |
| filename | The path to the function's deployment package within the local filesystem. It is conflict with the oss_-prefixed options | string | - | yes |
| memory_size | Amount of memory in MB your Function can use at runtime. Defaults to 128. Limits to [128, 3072] | int | 512 | no |
| runtime | The FC function runtime type | string | - | yes |
| handler | The FC function entry point in your code | string | index.handler | no |
| timeout | The amount of time your Function has to run in seconds | int | 60 | no |


## Outputs

| Name | Description |
|------|-------------|
| id | The ID of the Function |
| name | The name of the Function |
