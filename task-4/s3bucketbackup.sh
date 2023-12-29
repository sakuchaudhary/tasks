# AWS CLI is the powerful command-line interface to work with different 
# Amazon services, including Amazon S3. There is a useful sync command that 
# allows you to back up Amazon S3 buckets to a Linux machine by copying files
# from the bucket to a local directory in Linux running on an EC2 instance

sudo apt install unzip
curl “https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip” -o “awscliv2.zip”
unzip awscli-exe-linux-x86_64.zip
sudo ./aws/install

# Add credentials to access AWS with AWS CLI from the Linux instance if credentials have not been set:

aws configure 
# enter the detials like access key, secret access key, region, output format

mkdir -p ~/s3/bucket_name
# make directory in EC2 

aws s3 sync s3://<bucket_name> /home/ubuntu/s3/<bucket_name>
# Synchronize the bucket contents with your local directory on the EC2 

/usr/bin/aws s3 sync s3://{BUCKET_NAME} /home/ubuntu/s3/{BUCKET_NAME}/

sudo chmod +x /home/ubuntu/s3/sync.sh
# Make the script executable:

crontab -e 
# Edit crontab and add the command

0 * * * * /home/ubuntu/s3/sync.sh > /home/ubuntu/s3/sync.log
# Amazon S3 automatic backup is configured. The log file can be used to check execution of synchronization tasks.
