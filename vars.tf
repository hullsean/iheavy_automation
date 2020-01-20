
variable "iheavy_size" {
    description = "aws instance size to spinup"
    default = "t2.medium"
}

variable "iheavy_subnet" {
    description = "vpc subnet to put server in"
    default = "subnet-1f866434"
}

variable "iheavy_sg" {
    description = "security group for iheavy"
    type = "list"
    default = ["sg-46f0f223"]
}

variable "mysql_user" {
    description = "rds db user"
}

variable "mysql_host" {
    description = "rds host"
}

variable "mysql_pass" {
    description = "rds db password"
}