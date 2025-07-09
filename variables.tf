variable "region" {
  type        = string
  description = "Default AWS region."
  default     = "eu-west-1"
}

variable "default_lambda_timeout" {
  type        = string
  default     = 300
  description = "Default timeout for the Lambda function"
}

variable "default_lambda_runtime" {
  type        = string
  default     = "python3.13"
  description = "Default Lambda function runtime"
}

variable "cloudwatch_logs_retention_in_days" {
  type        = number
  description = "Default retention period for lambda Cloudwatch groups"
  default     = 30
}

variable "config_rules_cross_account_role_name" {
  type        = string
  description = "IAM role name deployed in each account to allow AWS config to check resources compliances and put evaluations results."
}
