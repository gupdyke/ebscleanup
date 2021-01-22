for unused_volume in $(aws ec2 describe-volumes --filters Name=status,Values=available \
--output text --query 'Volumes[*].Attachments[].{VolumeID:VolumeId}') ; 
do echo aws ec2 delete-volume --volume-id $unused_volume ; done
