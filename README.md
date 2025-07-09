# aws-mwaa-config-conformance-pack

This repository provides a **Terraform-based Conformance Pack** for enforcing security, logging, and compliance best practices on **Amazon Managed Workflows for Apache Airflow (MWAA)** environments using **AWS Config custom rules**.

---

## 📌 Features

This Conformance Pack defines a set of custom AWS Config rules targeting MWAA environments to ensure organizational compliance with key security and operational requirements:

### ✅ Included Custom Rules

| Rule Name | Description |
|----------|-------------|
| `mwaa-at-rest-encryption-enabled-check` | Checks if Amazon MWAA environments have encryption at rest enabled using AWS KMS CMK. |
| `mwaa-webserver-public-access-enabled-check` | Checks if the MWAA webserver is publicly accessible. |
| `mwaa-dag-processing-logs-enabled-check` | Ensures that DAG Processing logs are enabled. |
| `mwaa-scheduler-logs-enabled-check` | Ensures that Scheduler logs are enabled. |
| `mwaa-task-logs-enabled-check` | Ensures that Task logs are enabled. |
| `mwaa-webserver-logs-enabled-check` | Ensures that Webserver logs are enabled. |
| `mwaa-worker-logs-enabled-check` | Ensures that Worker logs are enabled. |
| `mwaa-customer-managed-endpoint-enabled-check` | Ensures that MWAA environments use customer-managed endpoints (VPC endpoint protection). |

---

## 🛠️ Usage

### 🧰 Prerequisites

Ensure the following tools are installed in your local development environment:

- **Terraform** >= 1.12.2
- **AWS CLI** with appropriate credentials and permissions
- **Python** 3.13.5
- **pre-commit** (used to manage Git hook scripts for linting, formatting, etc.)
- **tflint** (for Terraform linting)

### Deploy with Terraform

1. Clone the repository:

   ```bash
   git clone git@github.com:nhammadi/aws-mwaa-config-conformance-pack.git
   cd aws-mwaa-config-conformance-pack
   ```

2. Customize terraform variables depending on your requirements
> ⚠️ **Important:**
Ensure you customize the following Terraform variable before deployment:

```hcl
variable "config_rules_cross_account_role_name" {
  type        = string
  default     = ""
  description = "IAM role name deployed in each account to allow AWS Config to check resource compliance and put evaluation results."
}
```

This variable must match the **IAM role name** that exists in **each target AWS account** and is trusted by the AWS Config service.
It enables the Conformance Pack's Lambda functions to assume the necessary role for evaluating compliance across accounts.


3. Deploy:

   ```bash
   terraform init
   terraform plan
   terraform apply
   ```

---

## 🧩 Architecture

Each rule is implemented using an AWS Lambda function deployed via Terraform. Rules are evaluated by AWS Config against all MWAA environments in the account or across accounts via delegated admin setup.

---

## 🔐 Security & Compliance Goals

This Conformance Pack helps you:

- Enforce **KMS CMK encryption** for MWAA environments.
- Prevent **public access** to MWAA webservers.
- Ensure **logging** is enabled for all critical MWAA components.
- Promote **private networking** via customer-managed endpoints.

---

## 📄 License

MIT License – see [LICENSE](./LICENSE)

---

## 🤝 Contributing

Contributions, feature requests, and bug reports are welcome! Please open an issue or submit a pull request.
