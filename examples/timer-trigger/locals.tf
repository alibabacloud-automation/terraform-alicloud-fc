locals {
  timer_trigger_conf = <<EOF
  {
		"payload": "aaaaa",
		"cronExpression": "0 1/1000 * * * *",
		"enable": true
	}
  EOF
}
