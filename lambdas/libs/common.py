# -*- coding: utf-8 -*-
import json
import logging
import os

import boto3

logger = logging.getLogger(__file__)
logging.basicConfig()
logger.setLevel(logging.INFO)

DEFAULT_RESOURCE_TYPE = "AWS::MWAA::Environment"

CONFIG_RULES_CROSS_ACCOUNT_ROLE_NAME = os.getenv("CONFIG_RULES_CROSS_ACCOUNT_ROLE_NAME")


def get_region_from_rule_arn(rule_arn: str) -> str:
    """Return the AWS region name from the AWS config rule ARN."""
    return rule_arn.split(":")[3]


def get_boto_client_by_arn(
    service: str, region: str, role_arn: str, assume_role: bool = True
) -> boto3.client:
    """Return boto3 client based on the passed arguments."""
    if not assume_role:
        return boto3.client(service)

    sts_client = boto3.client("sts")
    response = sts_client.assume_role(RoleArn=role_arn, RoleSessionName="ClientSession")

    return boto3.client(
        service,
        region_name=region,
        aws_access_key_id=response["Credentials"]["AccessKeyId"],
        aws_secret_access_key=response["Credentials"]["SecretAccessKey"],
        aws_session_token=response["Credentials"]["SessionToken"],
    )


def build_evaluation(
    resource_type: str,
    resource_id: str,
    compliance_type: str,
    annotation: str,
    timestamp: str,
) -> dict:
    """Build AWS config evaluation object based on the input arguments."""
    return {
        "ComplianceResourceType": resource_type,
        "ComplianceResourceId": resource_id,
        "ComplianceType": compliance_type,
        "Annotation": annotation,
        "OrderingTimestamp": timestamp,
    }


def get_all_mwaa_resources(mwaa_client: boto3.client) -> list:
    """Retrieve a list of all MWAA resources."""
    all_envs = []
    try:
        env_names = mwaa_client.list_environments()
        all_envs += env_names.get("Environments", [])

        while "NextToken" in env_names:
            env_names = mwaa_client.list_environments(NextToken=env_names["NextToken"])
            all_envs += env_names.get("Environments", [])

        return all_envs
    except Exception as e:
        logger.error(f"Error retrieving MWAA environments: {e}")
        return all_envs


def clean_up_old_evaluations(
    config_client: boto3.Session,
    latest_evaluations: list,
    event: dict,
    resource_type: str,
) -> None:
    """Remove old evaluations by comparing them to the new evaluation results."""
    cleaned_evaluations = []
    config_rule_name = event.get("configRuleName")
    timestamp = str(json.loads(event["invokingEvent"])["notificationCreationTime"])
    old_eval = config_client.get_compliance_details_by_config_rule(
        ConfigRuleName=config_rule_name,
        ComplianceTypes=["COMPLIANT", "NON_COMPLIANT"],
        Limit=100,
    )

    old_eval_list = []

    while True:
        for old_result in old_eval["EvaluationResults"]:
            old_eval_list.append(old_result)
        if "NextToken" in old_eval:
            next_token = old_eval["NextToken"]
            old_eval = config_client.get_compliance_details_by_config_rule(
                ConfigRuleName=config_rule_name,
                ComplianceTypes=["COMPLIANT", "NON_COMPLIANT"],
                Limit=100,
                NextToken=next_token,
            )
        else:
            break
    for old_eval in old_eval_list:
        old_resource_id = old_eval["EvaluationResultIdentifier"][
            "EvaluationResultQualifier"
        ]["ResourceId"]
        newer_founded = False
        for latest_eval in latest_evaluations:
            if old_resource_id == latest_eval["ComplianceResourceId"]:
                newer_founded = True
        if not newer_founded:
            cleaned_evaluations.append(
                build_evaluation(
                    resource_type=resource_type,
                    resource_id=old_resource_id,
                    compliance_type="NOT_APPLICABLE",
                    annotation="Resource was deleted and therefore cannot be validated",
                    timestamp=timestamp,
                )
            )

    return cleaned_evaluations + latest_evaluations
