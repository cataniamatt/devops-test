# Project Documentation
![](application.mov)

Due to the simplicity of the web application, there could be multiple ways on how it can be deployed. The most straight forward way would be to deploy it in a serverless fashion as a AWS Beanstalk/Azure App Service web application which is scaled out with multiple instances. However, in this scenario, it is deployed inside a Kubernetes cluster to showcase the use of various modern technologies. Since any cloud provider can be used, the Microsoft Azure cloud service was used as I already have a test environment available.

This Kubernetes deployment creates a namespace called "test-namespace" and deploys a web application using a Deployment and a Service within that namespace. The Deployment ensures two replicas of the web application are running, using a container image that is pulled from an Azure Container Registry. The application runs on port 3000 but the service exposes it internally within the cluster on port 80. An Ingress resource is also configured to route external traffic to the web application through an Azure Application Gateway, specifying the backend service as "webapp" on port 80. The default routing strategy of an Azure Application Gateway is round-robin, therefore, each time the AGW IP is visited on port 80, the host name in the application message changes. A custom domain has been created for this application with an A record that points to the public IP of the Application Gateway. The requests towards this application are proxied through Cloudflare for SSL termination and DDoS protection. The application can be visited here: <a href="https://app.matthewcatania.com" target="_blank">https://app.matthewcatania.com</a>

The application is updated using an Azure DevOps pipeline which is triggered upon the push of any branch prefixed with "feature/" to GitHub. It builds and deploys an application using Docker containers to a Kubernetes cluster. This job encompasses the following steps:

1. Check out the repository.
2. Execute application tests.
3. Upon successful tests, construct a Docker image.
4. Upload the Docker image to the container registry, adhering to the naming convention 'Repository:BuildId'.
5. Update the manifest file with the latest image version.
6. Apply the updated manifest file to the cluster.


### Infrastructure created:
* Resource group
* AKS Cluster with 1 node pool
* Azure Container Registry
* IAM Role Assignment

### Tools used:
* Azure Cloud
* Azure DevOps
* Cloudflare
* Terraform
* Kubernetes
* Docker
* Github

### Possible improvements:
* Separate infrastructure and application code into separate repositories
* Save the Terraform state file as a blob inside a storage account instead of saving it locally
* Create an IaC deployment pipeline for a safe and consistent infrastructure deployment process
* Use self-hosted CI/CD agents instead of provider hosted to improve security and have faster image builds due to Docker cache
* Implement Helm for a more organised and robust deployment strategy across environments
* Add rollback mechanism to pipeline
* Implement pod and node autoscaling for the backend AKS cluster, this would help scale the system according the the demand.
* Create a proper network structure, with a robust edge security configuration. Cloudflare can also be augmented to provide CDN funcitonality.
* The IaC code implemented has been modularised a bit, however, further modularisation is required to eventually have the resources declared as a JSON object. This would reduce code repetition and improve code organisaiton.
