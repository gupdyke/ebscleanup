# ebscleanup
Write a script that will detect and cleanup/delete AWS available (not in-use) EBS volumes.

1) Going to use AWS CLI to find volumes. First, configure with Key, Secret and Region info:
aws configure

2) Use describe-volumes to find all volumes, output in JSON:
aws ec2 describe-volumes

3) Narrow down the results to only show volumes *not* in use (with a "status" of "available"), output in JSON:
aws ec2 describe-volumes --filters Name=status,Values=available

4) Query the results to filter out only the VolumeId, output in JSON:
aws ec2 describe-volumes --filters Name=status,Values=available --query 'Volumes[*].Attachments[].{VolumeID:VolumeId}'

5) Same as above, but formatting as Text for easy use in a Delete script:
aws ec2 describe-volumes --filters Name=status,Values=available --output text --query 'Volumes[*].Attachments[].{VolumeID:VolumeId}'

6) To see the Instances associated with the unused Volumes, run the below:
aws ec2 describe-volumes --filters Name=status,Values=available --output text --query 'Volumes[*].Attachments[].{VolumeID:VolumeId,InstanceID:InstanceId}'

7) Script to delete unused volumes, utilizing the output of the script in Step 5):
for unused_volume in $(aws ec2 describe-volumes --filters Name=status,Values=available \
--output text --query 'Volumes[*].Attachments[].{VolumeID:VolumeId}') ; 
do aws ec2 delete-volume --volume-id $unused_volume ; done
 
