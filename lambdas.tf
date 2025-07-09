module "mwaa_env_cmk_encryption_enabled_check_lambda_function" {
  source                            = "terraform-aws-modules/lambda/aws"
  version                           = "8.0.1"
  function_name                     = local.config_rules.mwaa_at_rest_encryption_enabled_check_rule.name
  description                       = local.config_rules.mwaa_at_rest_encryption_enabled_check_rule.description
  handler                           = "lambda_function.lambda_handler"
  runtime                           = var.default_lambda_runtime
  timeout                           = var.default_lambda_timeout
  create_role                       = false
  lambda_role                       = aws_iam_role.custom_config_lambda_role.arn
  cloudwatch_logs_retention_in_days = var.cloudwatch_logs_retention_in_days
  source_path = [
    "${path.module}/lambdas/mwaa-at-rest-encryption-enabled-check/",
    "${path.module}/lambdas/libs/common.py"
  ]
  create_current_version_allowed_triggers = false
  environment_variables = {
    CONFIG_RULES_CROSS_ACCOUNT_ROLE_NAME = var.config_rules_cross_account_role_name
  }
  allowed_triggers = {
    Config = {
      principal = "config.amazonaws.com"
    }
  }
}

module "mwaa_webserver_public_access_enabled_check_lambda_function" {
  source                            = "terraform-aws-modules/lambda/aws"
  version                           = "8.0.1"
  function_name                     = local.config_rules.mwaa_webserver_public_access_enabled_check_rule.name
  description                       = local.config_rules.mwaa_webserver_public_access_enabled_check_rule.description
  handler                           = "lambda_function.lambda_handler"
  runtime                           = var.default_lambda_runtime
  timeout                           = var.default_lambda_timeout
  create_role                       = false
  lambda_role                       = aws_iam_role.custom_config_lambda_role.arn
  cloudwatch_logs_retention_in_days = var.cloudwatch_logs_retention_in_days
  source_path = [
    "${path.module}/lambdas/mwaa-webserver-public-access-enabled-check/",
    "${path.module}/lambdas/libs/common.py"
  ]
  create_current_version_allowed_triggers = false
  environment_variables = {
    CONFIG_RULES_CROSS_ACCOUNT_ROLE_NAME = var.config_rules_cross_account_role_name
  }
  allowed_triggers = {
    Config = {
      principal = "config.amazonaws.com"
    }
  }
}

module "mwaa_dag_processing_logs_enabled_check_lambda_function" {
  source                            = "terraform-aws-modules/lambda/aws"
  version                           = "8.0.1"
  function_name                     = local.config_rules.mwaa_dag_processing_logs_enabled_check_rule.name
  description                       = local.config_rules.mwaa_dag_processing_logs_enabled_check_rule.description
  handler                           = "lambda_function.lambda_handler"
  runtime                           = var.default_lambda_runtime
  timeout                           = var.default_lambda_timeout
  create_role                       = false
  lambda_role                       = aws_iam_role.custom_config_lambda_role.arn
  cloudwatch_logs_retention_in_days = var.cloudwatch_logs_retention_in_days
  source_path = [
    "${path.module}/lambdas/mwaa-dag-processing-logs-enabled-check/",
    "${path.module}/lambdas/libs/common.py"
  ]
  create_current_version_allowed_triggers = false
  environment_variables = {
    CONFIG_RULES_CROSS_ACCOUNT_ROLE_NAME = var.config_rules_cross_account_role_name
  }
  allowed_triggers = {
    Config = {
      principal = "config.amazonaws.com"
    }
  }
}

module "mwaa_scheduler_logs_enabled_check_lambda_function" {
  source                            = "terraform-aws-modules/lambda/aws"
  version                           = "8.0.1"
  function_name                     = local.config_rules.mwaa_scheduler_logs_enabled_check_rule.name
  description                       = local.config_rules.mwaa_scheduler_logs_enabled_check_rule.description
  handler                           = "lambda_function.lambda_handler"
  runtime                           = var.default_lambda_runtime
  timeout                           = var.default_lambda_timeout
  create_role                       = false
  lambda_role                       = aws_iam_role.custom_config_lambda_role.arn
  cloudwatch_logs_retention_in_days = var.cloudwatch_logs_retention_in_days
  source_path = [
    "${path.module}/lambdas/mwaa-scheduler-logs-enabled-check/",
    "${path.module}/lambdas/libs/common.py"
  ]
  create_current_version_allowed_triggers = false
  environment_variables = {
    CONFIG_RULES_CROSS_ACCOUNT_ROLE_NAME = var.config_rules_cross_account_role_name
  }
  allowed_triggers = {
    Config = {
      principal = "config.amazonaws.com"
    }
  }
}


module "mwaa_task_logs_enabled_check_lambda_function" {
  source                            = "terraform-aws-modules/lambda/aws"
  version                           = "8.0.1"
  function_name                     = local.config_rules.mwaa_task_logs_enabled_check_rule.name
  description                       = local.config_rules.mwaa_task_logs_enabled_check_rule.description
  handler                           = "lambda_function.lambda_handler"
  runtime                           = var.default_lambda_runtime
  timeout                           = var.default_lambda_timeout
  create_role                       = false
  lambda_role                       = aws_iam_role.custom_config_lambda_role.arn
  cloudwatch_logs_retention_in_days = var.cloudwatch_logs_retention_in_days
  source_path = [
    "${path.module}/lambdas/mwaa-task-logs-enabled-check/",
    "${path.module}/lambdas/libs/common.py"
  ]
  create_current_version_allowed_triggers = false
  environment_variables = {
    CONFIG_RULES_CROSS_ACCOUNT_ROLE_NAME = var.config_rules_cross_account_role_name
  }
  allowed_triggers = {
    Config = {
      principal = "config.amazonaws.com"
    }
  }
}

module "mwaa_webserver_logs_enabled_check_lambda_function" {
  source                            = "terraform-aws-modules/lambda/aws"
  version                           = "8.0.1"
  function_name                     = local.config_rules.mwaa_webserver_logs_enabled_check_rule.name
  description                       = local.config_rules.mwaa_webserver_logs_enabled_check_rule.description
  handler                           = "lambda_function.lambda_handler"
  runtime                           = var.default_lambda_runtime
  timeout                           = var.default_lambda_timeout
  create_role                       = false
  lambda_role                       = aws_iam_role.custom_config_lambda_role.arn
  cloudwatch_logs_retention_in_days = var.cloudwatch_logs_retention_in_days
  source_path = [
    "${path.module}/lambdas/mwaa-webserver-logs-enabled-check/",
    "${path.module}/lambdas/libs/common.py"
  ]
  create_current_version_allowed_triggers = false
  environment_variables = {
    CONFIG_RULES_CROSS_ACCOUNT_ROLE_NAME = var.config_rules_cross_account_role_name
  }
  allowed_triggers = {
    Config = {
      principal = "config.amazonaws.com"
    }
  }
}
module "mwaa_worker_logs_enabled_check_lambda_function" {
  source                            = "terraform-aws-modules/lambda/aws"
  version                           = "8.0.1"
  function_name                     = local.config_rules.mwaa_worker_logs_enabled_check_rule.name
  description                       = local.config_rules.mwaa_worker_logs_enabled_check_rule.description
  handler                           = "lambda_function.lambda_handler"
  runtime                           = var.default_lambda_runtime
  timeout                           = var.default_lambda_timeout
  create_role                       = false
  lambda_role                       = aws_iam_role.custom_config_lambda_role.arn
  cloudwatch_logs_retention_in_days = var.cloudwatch_logs_retention_in_days
  source_path = [
    "${path.module}/lambdas/mwaa-worker-logs-enabled-check/",
    "${path.module}/lambdas/libs/common.py"
  ]
  create_current_version_allowed_triggers = false
  environment_variables = {
    CONFIG_RULES_CROSS_ACCOUNT_ROLE_NAME = var.config_rules_cross_account_role_name
  }
  allowed_triggers = {
    Config = {
      principal = "config.amazonaws.com"
    }
  }
}

module "mwaa_customer_managed_endpoint_enabled_check_lambda_function" {
  source                            = "terraform-aws-modules/lambda/aws"
  version                           = "8.0.1"
  function_name                     = local.config_rules.mwaa_customer_managed_endpoint_enabled_check_rule.name
  description                       = local.config_rules.mwaa_customer_managed_endpoint_enabled_check_rule.description
  handler                           = "lambda_function.lambda_handler"
  runtime                           = var.default_lambda_runtime
  timeout                           = var.default_lambda_timeout
  create_role                       = false
  lambda_role                       = aws_iam_role.custom_config_lambda_role.arn
  cloudwatch_logs_retention_in_days = var.cloudwatch_logs_retention_in_days
  source_path = [
    "${path.module}/lambdas/mwaa-customer-managed-endpoint-enabled-check/",
    "${path.module}/lambdas/libs/common.py"
  ]
  create_current_version_allowed_triggers = false
  environment_variables = {
    CONFIG_RULES_CROSS_ACCOUNT_ROLE_NAME = var.config_rules_cross_account_role_name
  }
  allowed_triggers = {
    Config = {
      principal = "config.amazonaws.com"
    }
  }
}
