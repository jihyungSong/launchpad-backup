module "shard_cluster" {
  source                              =   "./modules/shard_cluster"

  region                              =   var.region
  environment                         =   var.environment

  // MongoDB Bastion
  mongodb_ami_id                      =   var.mongodb_ami_id
  mongodb_bastion_subnet_id           =   var.mongodb_bastion_subnet_id
  mongodb_bastion_instance_type       =   var.mongodb_bastion_instance_type
  mongodb_bastion_keypair_name        =   var.mongodb_bastion_keypair_name

  // MongoDB Config Server
  mongodb_keypair_name                =   var.mongodb_keypair_name
  mongodb_config_instance_type        =   var.mongodb_config_instance_type
  mongodb_config_server               =   var.mongodb_config_server

  // MongoDB Replica Set Members
  mongodb_replica_set_members         =   var.mongodb_replica_set_members

  // Security Group
  mongodb_bastion_security_group_ids  =   [module.mongodb_security_group.mongodb_bastion_sg_id]
  mongodb_security_group_ids          =   [module.mongodb_security_group.mongodb_internal_sg_id, module.mongodb_security_group.mongodb_app_sg_id]

  depends_on                          =   [module.mongodb_security_group]
}