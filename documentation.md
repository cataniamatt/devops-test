Due to the simplicity of the web application, there could be multiple ways on how it can be deployed. The most straight forward way would be to deploy it in a serverless fashion as a AWS Beanstalk/Azure App Service web application which is scaled out with multiple instances. However, in this scenario, it will be deployed inside a Kubernetes cluster to showcase the use of various modern technologies. Since any cloud provider can be used, the Microsoft Azure cloud service will be used as I already have a test environment available.

### Tools:
* Azure Cloud
* Azure DevOps
* Terraform
* Kubernetes
* Docker
* Github
* Node JS

### To do:
* Create the infrastructure code using Terraform
* Create an IaC deployment pipeline for the Terraform code
* Configure the Kubernetes cluster
* Create the application build pipeline:
    * Build the application as an image
    * Deploy the application on to the K8s cluster
* Document the whole build and release process for application + infra

### Possible improvements:
* Separate infrastructure and application code into separate repositories
* Publish docker image into a container registry
* Save the Terraform state file as a blob inside a storage account
* Close down public access on resources

### Application build process:
* Execute npm install command
* Execute npm start command

### Docker image build process:
* docker build -t spin-city . (inside app directory)

### Docker image local test:
* docker run -dp 3000:3000 spin-city

### Infrastructure deployment process:
* terraform init
* terraform plan -var-file=test.tfvars
* terraform apply -var-file=test.tfvars -auto-approve