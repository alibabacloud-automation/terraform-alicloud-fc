# RAM role
document = <<EOF
  {
    "Statement": [
      {
        "Action": "sts:AssumeRole",
        "Effect": "Allow",
        "Principal": {
          "Service": [
              "fc.aliyuncs.com",
              "oss.aliyuncs.com",
              "mns.aliyuncs.com",
              "ecs.aliyuncs.com"
          ]
        }
      }
    ],
    "Version": "1"
  }
  EOF
force    = true

# FC Service Variables
fc_service_description  = "update-tf-testacc-fc-description"
service_internet_access = false

# HTTP FC Function Variables
fc_function_http_description = "update-tf-testacc-fc-http-description"
http_function_runtime        = "python3"
http_function_handler        = "update_http.handler"

# Events FC Function Variables
fc_function_events_description = "update-tf-testacc-fc-events-description"
events_function_runtime        = "python3"
events_function_handler        = "update_events.handler"

# HTTP FC Trigger Variables
http_config = <<EOF
  {
    "authType": "anonymous",
    "disableURLInternet":false,
    "methods": ["GET", "POST"]
  }
  EOF

# Events FC Trigger Variables
event_config = <<EOF
  {
    "filterTag":"testTag",
    "notifyContentFormat":"STREAM",
    "notifyStrategy":"BACKOFF_RETRY"
  }
  EOF

# FC Function Variables
function_memory_size = 256
function_timeout     = 120