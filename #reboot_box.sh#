#!/bin/sh


export instance_id=i-05e9dce2e0a1530e2

# get instance id
# aws ec2 describe-instances | grep tag name = iheavy-iac
# set instance_id variable

#
# hack for now...
#
aws ec2 reboot-instances --instance-ids $instance_id


# this script should:
# find the instance-id by tag name=iheavy-iac
# then run above command by variable

# need cli switch to do stop/start cycle
# that option needs to loop until the instance is stopped
# so it's a bit trickier

# to stop:
# aws ec2 stop-instances --instance-ids $instance_id

# check status
# aws ec2 describe-instances | grep "State = stopped"

#
# to start instance
# aws ec2 start-instances --instance-ids $instance_id


