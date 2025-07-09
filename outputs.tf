output "mwaa_at_rest_encryption_enabled_check_lambda_function_arn" {
  description = "mwaa-at-rest-encryption-enabled-check Lambda function arn"
  value       = module.mwaa_env_cmk_encryption_enabled_check_lambda_function.lambda_function_arn
}

output "mwaa_webserver_public_access_enabled_check_lambda_function_arn" {
  description = "mwaa-webserver-public-access-enabled-check Lambda function arn"
  value       = module.mwaa_webserver_public_access_enabled_check_lambda_function.lambda_function_arn
}

output "mwaa_dag_processing_logs_enabled_check_lambda_function_arn" {
  description = "mwaa-dag-processing-logs-enabled-check Lambda function arn"
  value       = module.mwaa_dag_processing_logs_enabled_check_lambda_function.lambda_function_arn
}

output "mwaa_scheduler_logs_enabled_check_lambda_function_arn" {
  description = "mwaa-scheduler-logs-enabled-check Lambda function arn"
  value       = module.mwaa_scheduler_logs_enabled_check_lambda_function.lambda_function_arn
}

output "mwaa_task_logs_enabled_check_lambda_function_arn" {
  description = "mwaa-task-logs-enabled-check Lambda function arn"
  value       = module.mwaa_task_logs_enabled_check_lambda_function.lambda_function_arn
}

output "mwaa_webserver_logs_enabled_check_lambda_function_arn" {
  description = "mwaa-webserver-logs-enabled-check Lambda function arn"
  value       = module.mwaa_webserver_logs_enabled_check_lambda_function.lambda_function_arn
}

output "mwaa_worker_logs_enabled_check_lambda_function_arn" {
  description = "mwaa-worker-logs-enabled-check Lambda function arn"
  value       = module.mwaa_worker_logs_enabled_check_lambda_function.lambda_function_arn
}
output "mwaa_customer_managed_endpoint_enabled_check_lambda_function_arn" {
  description = "mwaa-customer-managed-endpoint-enabled-check Lambda function arn"
  value       = module.mwaa_customer_managed_endpoint_enabled_check_lambda_function.lambda_function_arn
}
