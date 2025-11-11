# Terraform AWS Project

## Prerequisites
- Terraform installed (v1.5+ recommended)
- AWS CLI configured with proper credentials
- Key pair file `key.pem` in the project root
- Python 3 installed locally if you want to run scripts before deployment

## Description
This project deploys a VPC with:
- 2 Public Subnets → EC2 instances as Nginx Reverse Proxy
- 2 Private Subnets → EC2 instances as Web Application Backends
- NAT Gateway + Internet Gateway
- 2 Load Balancers:
  - Public ALB → directs traffic to proxies
  - Internal ALB → directs traffic from proxies to backend servers

## Steps to Run

1. Initialize Terraform
```bash
terraform init
```

2. Create and select workspace
```bash
terraform workspace new dev
terraform workspace select dev
```

3. Plan and apply
```bash
terraform plan -out=tfplan
terraform apply tfplan
```

## SSH Access
- Public EC2:
```bash
ssh -i key.pem ec2-user@<public-ip>
```

- Private EC2s: Access via bastion host (first public EC2)

## Project Structure
terraform-project/
│
├── main.tf             # Root Terraform configuration
├── variables.tf        # Root variables
├── outputs.tf          # Root outputs
├── modules/
│   ├── vpc/
│   │   └── main.tf
│   ├── ec2/
│   │   └── main.tf
│   └── alb/
│       └── main.tf
├── app/
│   └── app.py          # Web application for private EC2s
└── key.pem             # SSH key pair for EC2 access

## Notes
- Application files for private EC2s are located in `app/`
- Outputs with all IPs will be printed in `all-ips.txt`
- Make sure security groups allow SSH and HTTP access
> **AWS Academy Restrictions:**  
> AWS Academy Learner Labs may restrict the number of EC2 instances you can launch.  
> This project requires **4 EC2 instances** (2 public + 2 private) and **2 ALBs**,  
> so it may **not fully work** in AWS Academy environment.  
> For full functionality, use a standard AWS account with enough EC2 and ALB quotas.


## Project Screenshots
### the_project
![Workspace](images/"the_project.png")

### Workspace dev
![Workspace](images/"workspace dev.png")

### Public Server (Proxy)
![Public Server](images/"public server(proxy).png")

### Apache Configuration / Proxy
![Proxy Configuration](images/"Configuration of the proxy (Apache).png")

### Apache Return Test
![Apache Return](images/"Apache Return.png")

### Load Balancer DNS
![ALB DNS](images/"load Balancer DNS.png")

### S3 State File
![S3 Bucket](images/"S3 bucket containing the state file.png")

