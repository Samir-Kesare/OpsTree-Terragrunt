include "root" {
  path = find_in_parent_folders("common.hcl")
}

terraform {
  source = "git@github.com:CodeOps-Hub/Terraform-modules.git//Modules/VM-Module?ref=main"  

}

inputs = {
    vpc_id          = "vpc-00e048db5cbda61fa"
key_name            = "redisKey.pem"
server_type         = "t2.medium"
subnet_id           = "subnet-00f1c9e56d7e36121"
server_name         = "Dev_Redis-Server"
inbound_ports = [ {
  port = 22 , protocol = "tcp" , security_group_ids = "sg-0099d9d92813605be"
},
{
 port = 6379 , protocol = "tcp" , security_group_ids = "sg-0099d9d92813605be"
},
{
 port = 22 , protocol = "tcp" , cidr_blocks = "20.0.0.0/28"
} ]
}
