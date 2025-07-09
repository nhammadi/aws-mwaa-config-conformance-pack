locals {
  conformance_pack_name               = "org-conformance-pack"
  custom_config_rules_iam_role_name   = "custom-config-rule-lambda-role"
  custom_config_rules_iam_policy_name = "custom-config-rule-lambda-policy"
  config_rules = {
    mwaa_at_rest_encryption_enabled_check_rule = {
      name        = "mwaa-at-rest-encryption-enabled-check"
      description = "Checks if Amazon MWAA environment have encryption at rest enabled using AWS KMS."
    }
    mwaa_webserver_public_access_enabled_check_rule = {
      name        = "mwaa-webserver-public-access-enabled-check"
      description = "Checks if Amazon MWAA environment webserver is publicly accessible."
    }
    mwaa_dag_processing_logs_enabled_check_rule = {
      name        = "mwaa-dag-processing-logs-enabled-check"
      description = "Checks if Amazon MWAA environment has DAG Processing logs enabled."
    }
    mwaa_scheduler_logs_enabled_check_rule = {
      name        = "mwaa-scheduler-logs-enabled-check"
      description = "Checks if Amazon MWAA environment has Scheduler logs enabled."
    }
    mwaa_task_logs_enabled_check_rule = {
      name        = "mwaa-task-logs-enabled-check"
      description = "Checks if Amazon MWAA environment has task logs enabled."
    }
    mwaa_webserver_logs_enabled_check_rule = {
      name        = "mwaa-webserver-logs-enabled-check"
      description = "Checks if Amazon MWAA environment has webserver logs enabled."
    }
    mwaa_worker_logs_enabled_check_rule = {
      name        = "mwaa-worker-logs-enabled-check"
      description = "Checks if Amazon MWAA environment has worker logs enabled."
    }
    mwaa_customer_managed_endpoint_enabled_check_rule = {
      name        = "mwaa-customer-managed-endpoint-enabled-check"
      description = "Checks if Amazon MWAA environment has customer managed endpoint enabled."
    }
  }
  conformance_pack_yaml = templatefile("${path.module}/conformance-pack.yaml.tmpl", {
    mwaa_at_rest_encryption_enabled_check_rule_name           = local.config_rules.mwaa_at_rest_encryption_enabled_check_rule.name
    mwaa_at_rest_encryption_enabled_check_rule_description    = local.config_rules.mwaa_at_rest_encryption_enabled_check_rule.description
    mwaa_at_rest_encryption_enabled_check_lambda_function_arn = module.mwaa_env_cmk_encryption_enabled_check_lambda_function.lambda_function_arn

    mwaa_webserver_public_access_enabled_check_rule_name           = local.config_rules.mwaa_webserver_public_access_enabled_check_rule.name
    mwaa_webserver_public_access_enabled_check_rule_description    = local.config_rules.mwaa_webserver_public_access_enabled_check_rule.description
    mwaa_webserver_public_access_enabled_check_lambda_function_arn = module.mwaa_webserver_public_access_enabled_check_lambda_function.lambda_function_arn

    mwaa_dag_processing_logs_enabled_check_rule_name           = local.config_rules.mwaa_dag_processing_logs_enabled_check_rule.name
    mwaa_dag_processing_logs_enabled_check_rule_description    = local.config_rules.mwaa_dag_processing_logs_enabled_check_rule.description
    mwaa_dag_processing_logs_enabled_check_lambda_function_arn = module.mwaa_dag_processing_logs_enabled_check_lambda_function.lambda_function_arn

    mwaa_scheduler_logs_enabled_check_rule_name           = local.config_rules.mwaa_scheduler_logs_enabled_check_rule.name
    mwaa_scheduler_logs_enabled_check_rule_description    = local.config_rules.mwaa_scheduler_logs_enabled_check_rule.description
    mwaa_scheduler_logs_enabled_check_lambda_function_arn = module.mwaa_scheduler_logs_enabled_check_lambda_function.lambda_function_arn

    mwaa_task_logs_enabled_check_rule_name           = local.config_rules.mwaa_task_logs_enabled_check_rule.name
    mwaa_task_logs_enabled_check_rule_description    = local.config_rules.mwaa_task_logs_enabled_check_rule.description
    mwaa_task_logs_enabled_check_lambda_function_arn = module.mwaa_task_logs_enabled_check_lambda_function.lambda_function_arn

    mwaa_webserver_logs_enabled_check_rule_name           = local.config_rules.mwaa_webserver_logs_enabled_check_rule.name
    mwaa_webserver_logs_enabled_check_rule_description    = local.config_rules.mwaa_webserver_logs_enabled_check_rule.description
    mwaa_webserver_logs_enabled_check_lambda_function_arn = module.mwaa_webserver_logs_enabled_check_lambda_function.lambda_function_arn

    mwaa_worker_logs_enabled_check_rule_name           = local.config_rules.mwaa_worker_logs_enabled_check_rule.name
    mwaa_worker_logs_enabled_check_rule_description    = local.config_rules.mwaa_worker_logs_enabled_check_rule.description
    mwaa_worker_logs_enabled_check_lambda_function_arn = module.mwaa_worker_logs_enabled_check_lambda_function.lambda_function_arn

    mwaa_customer_managed_endpoint_enabled_check_rule_name           = local.config_rules.mwaa_customer_managed_endpoint_enabled_check_rule.name
    mwaa_customer_managed_endpoint_enabled_check_rule_description    = local.config_rules.mwaa_customer_managed_endpoint_enabled_check_rule.description
    mwaa_customer_managed_endpoint_enabled_check_lambda_function_arn = module.mwaa_customer_managed_endpoint_enabled_check_lambda_function.lambda_function_arn
  })
}
