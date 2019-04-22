# autodns

Uses terraform & terratest to create a program that will update a configured 
route53 DNS name. Used as an alternative to a DynDNS service. 

## Repo Organization

### Stack

Folder contains teh terraform codebase that creates the route53 DNS record. 
Configured using a S3 backend, the AWS credentials passed to the container need
to have access a configured S3 bucket, and access to the route53 zone. 


### Makefile 

View Makefile for common actions.

```default``` builds the go binary and docker container. 

```build``` builds GO binary targeted at linux amd64 architecture. 
outputs to ./autodns.

```deploy``` applies kubernetes manifests from templates/ 

```dockerrun``` locally tests container against docker, expects AWS 
Access Key + Secret Key to be passed in. 

```setup``` downloads terraform binary and unpacks to cwd. 

### Templates

Folder contains kubernetes manifests, autodns namespace, required AWS secrets 
and the deployment object. 
