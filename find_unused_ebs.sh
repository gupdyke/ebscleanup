aws ec2 describe-volumes --filters Name=status,Values=available \
--output text --query 'Volumes[*].Attachments[].{VolumeID:VolumeId}'

