vpc_id                        =   "vpc-02ad51542d1b429d6"

mongodb_bastion_ingress_rule_admin_access_security_group_id = "sg-035d035b207dc78a5"    # From Source security group ID for Administrator access
mongodb_bastion_ingress_rule_admin_access_port              = 20222
mongodb_app_ingress_rule_mongodb_access_security_group_id   = "sg-0c8b6accd8cd9e6c8"    # From Source security group ID for Worker Nodes
