
provider "aws" {
    region = "us-east-1"
    
}

# 
# provision main aws instance with fixed AMI
# need to replace with packer build AMI
#
resource "aws_instance" "example" {
    ami = "ami-c58c1dd3"
    subnet_id = "${var.iheavy_subnet}"
    security_groups = "${var.iheavy_sg}"
    instance_type = "${var.iheavy_size}"
    key_name = "iheavy"
    user_data = "${data.template_file.user_data.rendered}"
    iam_instance_profile = "My-New-EC2-S3-Role"
    tags {
        Name = "iheavy-iac"
    }
    lifecycle {
        create_before_destroy = true
    }
}

#
# associate elastic IP automatically
#
resource "aws_eip_association" "eip_assoc" {
    instance_id   = "${aws_instance.example.id}"
    allocation_id = "${aws_eip.example.id}"
}

resource "aws_eip" "example" {
  vpc = true
}


#
# user data script for iheavy-iac
# including variable replacements
#
data "template_file" "user_data" {
    template = "${file("iheavy-user-data.sh")}"
    vars {
        mysql_user = "${var.mysql_user}"
        mysql_pass = "${var.mysql_pass}"
        mysql_host = "${var.mysql_host}"
    }
}

output "public_ip" {
    value = "${aws_instance.example.public_ip}"
}

