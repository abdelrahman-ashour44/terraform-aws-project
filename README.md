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
## Project Structure
```text
terraform-project/
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
├── images/             # Screenshots for documentation
│   ├── Apache Return.png
│   ├── Configuration of the proxy (Apache).png
│   ├── load Balancer DNS.png
│   ├── public server(proxy).png
│   ├── Screenshot 2025-11-08 224830.png
│   ├── S3 bucket containing the state file.png
│   └── workspace dev.png
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

##project screenshots
```
<img width="799" height="441" alt="the_project" src="https://github.com/user-attachments/assets/8857819b-1ff5-4fd5-90c3-516719281459" />
<img width="717" height="134" alt="workspace dev" src="https://github.com/user-attachments/assets/8b3baf1e-a2a0-42d5-905c-61839160953e" />

<img width="715" height="474" alt="public server(proxy)" src="https://github.com/user-attachments/assets/4f5495e3-353a-4e5a-b1a4-aed8c4ccbab8" />
<img width="804" height="388" alt="Configuration of the proxy (Apache)" src="https://github.com/user-attachments/assets/f8fb5ad0-05a9-48a5-905d-a281efac7955" />


<img width="693" height="554" alt="load Balancer DNS" src="https://github.com/user-attachments/assets/8dbe7236-f9fb-47de-8716-faec88e88d38" />
<img width="948" height="492" alt="Apache Return" src="https://github.com/user-attachments/assets/51d06c13-e015-4ca7-86fa-46de13de0220" />

<img width="965" height="429" alt="S3 bucket containing the state file" src="https://github.com/user-attachments/assets/ad99816d-b43b-44f3-ae5f-c2037652cbca" />



