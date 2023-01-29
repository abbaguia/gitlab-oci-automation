# tensorflow-demo-sanjose

Migration of a semi monolitique application to a microservice re-architecture. But first going from simple to complexe we need to migrate from a Single Availability Domain in the West Region (OCI Free Tier in San Jose) to the internal ISV Tenancy in the East Region (Ashburn). The later is a full Multi-Availabiitt-Domain with 3 Fault Domains and quasi unlimited quota (at least more than 2 VMs). 

The source application is a tensor flow demo including load balancer that alow the creation of a higer availability cluster composed of 3 or more VMs (comapred to max 2 instance servers limit of the Free tier in San Jose region)

This is the second increment in complexity to our multi-tenancies, multi-cloud, and multi-region cloud reference architectures. Here we modifying the the line of code that control the number of instance (count) using only two DevOps tools: GitHub, Hashicorp Terraform, Ansible, Linux bash shell and Cloud Shell embeded Code editor. 

Behind the scene we have used our own custom tool (Click 2 Consume Teraform command alias), loudShell as well as Oracle Managed Resources (Terraform Managed Service).  

Jenkins will be integrated to glue the whole together to using a DevOps CI/CD pipelines. 

Last Update: 01/28/2022 
