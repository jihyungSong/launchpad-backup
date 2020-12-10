module "mongodb_security_group" {
  source      = "./modules/security_group"

  environment = var.environment
  region      = var.region
  vpc_id      = var.vpc_id
  mongodb_bastion_ingress_rule_admin_access_security_group_id = var.mongodb_bastion_ingress_rule_admin_access_security_group_id
  mongodb_bastion_ingress_rule_admin_access_port              = var.mongodb_bastion_ingress_rule_admin_access_port
  mongodb_app_ingress_rule_mongodb_access_security_group_id   = var.mongodb_app_ingress_rule_mongodb_access_security_group_id
}
