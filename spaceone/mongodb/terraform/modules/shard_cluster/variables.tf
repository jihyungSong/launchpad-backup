variable "region" {}
variable "environment" {}

// MongoDB Bastion
variable "mongodb_ami_id" {}
variable "mongodb_bastion_subnet_id" {}
variable "mongodb_bastion_instance_type" {}
variable "mongodb_bastion_keypair_name" {}


// MongoDB Config Server
variable "mongodb_keypair_name" {}
variable "mongodb_config_instance_type" {}
variable "mongodb_config_server" {
    description     =   "for MongoDB Config servers"
    type = list(object({
        name      = string
        subnet_id = string
        root_device         =   object({
            volume_type     =   string
            volume_size     =   number
        })
    }))
}

// MongoDB Replica Set Members
variable "mongodb_replica_set_members" {
    description             =   "for MongoDB Shard Replica Set member instances"
    type = list(object({
        name                =   string
        instance_type       =   string
        subnet_id           =   string
        root_device         =   object({
            volume_type     =   string
            volume_size     =   number
        })
        data_devices        =   list(object({
            device_name     =   string
            volume_type     =   string
            volume_size     =   number
        }))
    }))
}

// Security Group
variable "mongodb_bastion_security_group_ids" {
    type = list(string)
}
variable "mongodb_security_group_ids" {
    type = list(string)
}

