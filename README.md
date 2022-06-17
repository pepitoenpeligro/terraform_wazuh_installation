# Terraform Wazuh Installation

![Technologies](technologies.png)

Automated installation of Wazuh Indexer, Wazuh Server and Wazuh Dashboard with Terraform on AWS with EC2 instances.


### Structure

```yaml
├── 0-providers.tf <- AWS config
├── 1-ami.tf <- AMI Base 
├── 2-key_resources.tf <- .pem and .pem.pub generation
├── 3-security_group.tf <- security groups
├── 4-ec2_instances.tf <- instances specification
├── 5-provision.tf <- instance configuration at SO level
├── 6-outputs.tf <- Ouput variable
```


```yaml
├── configure-indexer.yml <- indexer installation process
├── configure-server.yml <- server installation process
├── configure-dashboard.yml <- dashboard installation commands
```

### Usage



```bash
# Set variables with your AWS Access and Secret Keys
AWS_ACCESS_KEY="some_aws_access_key"
AWS_SECRET_KEY="some_aws_access_key"

# Replace in 0-providers.tf
sed -i -e "s/access_key.*/access_key = \"$AWS_ACCESS_KEY\"/g"   "0-providers.tf"
sed -i -e "s/secret_key.*/secret_key = \"$AWS_SECRET_KEY\"/g"   "0-providers.tf"

```


```bash
terraform init
```

```bash
terraform apply
```



### Demo

https://user-images.githubusercontent.com/14912971/174239699-df813e38-92bd-4d69-880d-e475b27a4f53.mp4

https://user-images.githubusercontent.com/14912971/174239704-b893134d-35de-4dd9-9de9-841031af2cc4.mp4

https://user-images.githubusercontent.com/14912971/174239707-53274a0f-c265-4e27-951f-b9781b87a7fc.mp4