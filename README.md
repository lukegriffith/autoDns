# autodns

Uses Terraform & terratest to create a program that will update a configured 
route53 DNS name. Used as an alternative to a DynDNS service. 

## Structure

### Stack

Folder contains the Terraform code-base that creates the route53 DNS record. 
Configured using a S3 back-end, the AWS credentials passed to the container need
to have access a configured S3 bucket, and access to the route53 zone. 

### Templates

Folder contains Kubernetes manifests, autodns name-space, required AWS secrets 
and the deployment object.

## Makefile 

View Makefile for common actions.

```default``` builds the go binary and docker container. 

```build``` builds GO binary targeted at Linux amd64 architecture. 
outputs to ./autodns.

```deploy``` applies Kubernetes manifests from templates/ 

```dockerrun``` locally tests container against docker, expects AWS 
Access Key + Secret Key to be passed in. 

```setup``` downloads Terraform binary and unpacks to cwd. 


