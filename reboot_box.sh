#!/bin/sh



#export instance_id=i-05e9dce2e0a1530e2

# look up the instance_id based on tag of "iheavy-iac"
# trim the comma, and quotes off the instance_id
#
export instance_id=`aws ec2 describe-instances --filter Name=tag:Name,Values=iheavy-iac | grep InstanceId | cut -d ':' -f2 | sed 's/,//' | sed 's/\"//g'`

# get instance id
# aws ec2 describe-instances | grep tag name = iheavy-iac
# set instance_id variable

#
# hack for now...
#
if [ $1 eq "reboot" ]; then
    echo "using aws ec2 reboot-instances ..."
    aws ec2 reboot-instances --instance-ids $instance_id
fi 

# need cli switch to do stop/start cycle
# that option needs to loop until the instance is stopped
# so it's a bit trickier

# to stop:
echo "STOPPING instance: $instance_id ..."
aws ec2 stop-instances --instance-ids $instance_id

# check status
# aws ec2 describe-instances | grep "State = stopped"
# we'll just wait 2 minutes.  likely it is stopped by then. :)
sleep 300

#
# to start instance
echo "STARTING instance: $instance_id ..."
aws ec2 start-instances --instance-ids $instance_id


