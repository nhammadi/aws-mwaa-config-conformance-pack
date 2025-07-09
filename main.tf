resource "aws_config_organization_conformance_pack" "compliance_pack" {
  name          = local.conformance_pack_name
  template_body = local.conformance_pack_yaml

  timeouts {
    create = "2h"
    update = "2h"
    delete = "2h"
  }
}
