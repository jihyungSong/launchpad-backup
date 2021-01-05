resource "aws_instance" "mongodb_bastion" {
  associate_public_ip_address   =   true
  ami                           =   var.mongodb_ami_id
  subnet_id                     =   var.mongodb_bastion_subnet_id
  instance_type                 =   var.mongodb_bastion_instance_type
  key_name                      =   var.mongodb_bastion_keypair_name
  vpc_security_group_ids        =   var.mongodb_bastion_security_group_ids

  tags = {
    Name          =   "mongodb-bastion-${var.environment}"
    server_type   =   "MongoDB"
    mongodb_type  =   "bastion"
    Managed_by    =   "terraform"
  }
}

resource "aws_instance" "mongodb_config" {
  associate_public_ip_address   =   false
  ami                           =   var.mongodb_ami_id
  subnet_id                     =   lookup(var.mongodb_config_server[count.index], "subnet_id")
  instance_type                 =   var.mongodb_config_instance_type
  key_name                      =   var.mongodb_keypair_name
  vpc_security_group_ids        =   var.mongodb_security_group_ids
  count                         =   length(var.mongodb_config_server)
  monitoring                    =   true
  disable_api_termination       =   true

  root_block_device {
    volume_type = lookup(var.mongodb_config_server[count.index].root_device, "volume_type")
    volume_size = lookup(var.mongodb_config_server[count.index].root_device, "volume_size")
  }

  tags = {
    Name          =   "${lookup(var.mongodb_config_server[count.index], "name")}-${var.environment}"
    server_type   =   "MongoDB"
    mongodb_type  =   "config"
    Managed_by    =   "terraform"
  }
}

resource "aws_instance" "mongodb_rs_member" {
  associate_public_ip_address   =   false
  ami                           =   var.mongodb_ami_id
  subnet_id                     =   lookup(var.mongodb_replica_set_members[count.index], "subnet_id")
  instance_type                 =   lookup(var.mongodb_replica_set_members[count.index], "instance_type")
  key_name                      =   var.mongodb_keypair_name
  vpc_security_group_ids        =   var.mongodb_security_group_ids
  count                         =   length(var.mongodb_replica_set_members)
  monitoring                    =   true
  disable_api_termination       =   true

  root_block_device {
    volume_type = lookup(var.mongodb_replica_set_members[count.index].root_device, "volume_type")
    volume_size = lookup(var.mongodb_replica_set_members[count.index].root_device, "volume_size")
  }

  dynamic "ebs_block_device" {
    for_each        = [for device in lookup(var.mongodb_replica_set_members[count.index], "data_devices"): {
      device_name   = device.device_name
      volume_type   = device.volume_type
      volume_size   = device.volume_size
    }]
    content {
      device_name = ebs_block_device.value.device_name
      volume_type = ebs_block_device.value.volume_type
      volume_size = ebs_block_device.value.volume_size
    }
  }

  tags = {
    Name          =   "${lookup(var.mongodb_replica_set_members[count.index], "name")}-${var.environment}"
    server_type   =   "MongoDB"
    mongodb_type  =   "replica_member"
    Managed_by    =   "terraform"
  }
}
