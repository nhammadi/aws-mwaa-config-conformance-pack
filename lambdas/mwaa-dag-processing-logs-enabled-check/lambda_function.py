# -*- coding: utf-8 -*-
import json
import logging

import boto3
from common import build_evaluation
from common import clean_up_old_evaluations
from common import CONFIG_RULES_CROSS_ACCOUNT_ROLE_NAME
from common import DEFAULT_RESOURCE_TYPE
from common import get_all_mwaa_resources
from common import get_boto_client_by_arn
from common import get_region_from_rule_arn

logger = logging.getLogger()
logger.setLevel(logging.INFO)


def evaluate_compliance(mwaa_client: boto3.client, timestamp: str) -> list:
    """Form the evaluation(s) to be returned to Config Rules."""
    evaluations = []
    env_list = get_all_mwaa_resources(mwaa_client=mwaa_client)

    for env_name in env_list:
        env_info = mwaa_client.get_environment(Name=env_name)
        name = env_info.get("Environment", {}).get("Name")
        env_arn = env_info.get("Environment", {}).get("Arn")
        dag_logs = (
            env_info.get("Environment", {})
            .get("LoggingConfiguration", {})
            .get("DagProcessingLogs", {})
            .get("Enabled")
        )
        if dag_logs:
            compliance_type = "COMPLIANT"
            annotation = (
                f"DAG Processing  logs for MWAA environment '{name}' are enabled."
            )
        else:
            compliance_type = "NON_COMPLIANT"
            annotation = (
                f"DAG Processing  logs for MWAA environment '{name}' are not enabled."
            )
        evaluations.append(
            build_evaluation(
                DEFAULT_RESOURCE_TYPE,
                env_arn,
                compliance_type,
                annotation,
                timestamp,
            )
        )

    return evaluations


def lambda_handler(event: dict, context: dict) -> None:
    """Main Entrypoint."""
    logger.info(f"Received event: {json.dumps(event)}")

    try:
        account_id = event["accountId"]
        execution_role_arn = (
            f"arn:aws:iam::{account_id}:role/{CONFIG_RULES_CROSS_ACCOUNT_ROLE_NAME}"
        )
        region = get_region_from_rule_arn(rule_arn=event.get("configRuleArn"))
        timestamp = str(json.loads(event["invokingEvent"])["notificationCreationTime"])

        mwaa_client = get_boto_client_by_arn(
            service="mwaa", region=region, role_arn=execution_role_arn
        )
        config_client = get_boto_client_by_arn(
            service="config", region=region, role_arn=execution_role_arn
        )

        latest_evaluations = evaluate_compliance(mwaa_client, timestamp)
        final_evaluations = clean_up_old_evaluations(
            config_client=config_client,
            latest_evaluations=latest_evaluations,
            event=event,
            resource_type=DEFAULT_RESOURCE_TYPE,
        )

        logger.info(f"Evaluations results are: {final_evaluations}")

        config_client.put_evaluations(
            Evaluations=final_evaluations, ResultToken=event["resultToken"]
        )
    except Exception as e:
        logger.error(f"Error processing event: {e}")
