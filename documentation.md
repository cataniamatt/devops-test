Due to the simplicity of the web application, there could be multiple ways on how it can be deployed. The most straight forward way would be to deploy it in a serverless fashion as a AWS Beanstalk/Azure App Service web application which is scaled out with multiple instances. However, in this scenario, it will be deployed inside a Kubernetes cluster to showcase the use of various modern technologies. Since any cloud provider can be used, the Microsoft Azure cloud service will be used as I already have a test environment available.

This Kubernetes deployment creates a namespace called "test-namespace" and deploys a web application using a Deployment and a Service within that namespace. The Deployment ensures two replicas of the web application are running, using a container image that is pulled from an Azure Container Registry. The application runs on port 3000 but the service exposes it internally within the cluster on port 80. An Ingress resource is also configured to route external traffic to the web application through an Azure Application Gateway, specifying the backend service as "webapp" on port 80. The default routing strategy of an Azure Application Gateway is round-robin, therefore, each time the AGW IP is visited on port 80, the host name in the application message changes.

### Tools:
* Azure Cloud
* Azure DevOps
* Terraform
* Kubernetes
* Docker
* Github
* Node JS

### To do:
* Create and deploy the infrastructure code using Terraform
* Configure the Kubernetes cluster
* Create the application build pipeline:
    * Build the application as an image
    * Deploy the application on to the K8s cluster
* Document the whole build and release process for application + infra

### Possible improvements:
* Separate infrastructure and application code into separate repositories
* Publish docker image into a container registry
* Save the Terraform state file as a blob inside a storage account
* Create an IaC deployment pipeline for a consistent infrastructure deployment process and to implement with approval stages
* Create a proper cloud network architecture and close down public access on resources
* Use self-hosted CI/CD agents instead of provider hosted to improve security and have faster image builds due to Docker cache

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

### Assumptions:
* There will always be only one container registry for all deployments in the future