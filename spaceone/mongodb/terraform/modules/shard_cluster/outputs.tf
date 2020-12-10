output "mongodb_bastion_server_id" {
  value = aws_instance.mongodb_bastion.id
}

output "mongodb_config_server_ids" {
  value = aws_instance.mongodb_config.*.id
}

output "mongodb_shard_cluster_members_ids" {
  value = aws_instance.mongodb_rs_member.*.id
}