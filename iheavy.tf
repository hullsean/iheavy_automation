

resource "aws_iam_role" "web_iam_role" {
    name = "web_iam_role"
    assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_instance_profile" "web_instance_profile" {
    name = "web_instance_profile"
    roles = ["web_iam_role"]
}

resource "aws_iam_role_policy" "web_iam_role_policy" {
  name = "web_iam_role_policy"
  role = "${aws_iam_role.web_iam_role.id}"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": ["s3:ListBucket"],
      "Resource": ["arn:aws:s3:::iheavy"]
    },
    {
      "Effect": "Allow",
      "Action": [
        "s3:PutObject",
        "s3:GetObject",
        "s3:DeleteObject"
      ],
      "Resource": ["arn:aws:s3:::my-bucket/*"]
    }
  ]
}
EOF
}

resource "aws_s3_bucket" "apps_bucket" {
    bucket = "my-bucket"
    acl = "private"
    versioning {
            enabled = true
    }
    tags {
        Name = "my-bucket"
    }
}



provider "aws" {
  access_key = "AAIII555333YYYXXXAAA"
  secret_key = "m23Olnllocgunl111emmmaT777+599C7pccshhhh5"
  region     = "us-east-1"
}


resource "aws_instance" "iheavy" {
  ami           = "ami-1a111888"
  instance_type = "t1.micro"
  vpc_security_group_ids = ["sg-44fgf211"]
  subnet_id = "subnet-1ff88444"
  key_name = "my-key"
  user_data = "${file("iheavy-user-data.sh")}"
    iam_instance_profile = "${aws_iam_instance_profile.web_instance_profile.id}"}

resource "aws_eip" "bar" {
  vpc = true
  instance                  = "${aws_instance.iheavy.id}"
}

resource "aws_eip_association" "eip_assoc" {
  instance_id = "${aws_instance.iheavy.id}"
  allocation_id = "eipalloc-71912b33"
}


