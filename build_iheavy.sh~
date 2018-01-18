#!/bin/sh

aws ec2 run-instances --image-id ami-c58c1dd3 \
  --security-group-ids sg-46f0f223 --count 1 \
  --instance-type t2.small --key-name iheavy \
  --subnet-id subnet-1f866434 \
  --user-data file:///Users/sean/iheavy_automation/iheavy-user-data.sh \
  --iam-instance-profile Name=My-New-EC2-S3-Role \
  --query 'Instances[0].InstanceId'
