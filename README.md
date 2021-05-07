# Keyless web server

This repo contains the infrastructure code and the configuration scripts necessary
to create a web ser instance with encrypted volume and
monitored by CPU, RAM and disk utilization.

All the configuration is made without the usage of any ssh key-pair or other
static credentials. That means that there is no sensitive data that could be leaked.
All the access is traceable an auditable with the usage of the AWS Systems Manager service
and AWS temporary credential tokens

## Project structure

Following is a description of the directory structure

- `tf/`: where all infrastructure code resides (terraform files). It has directories for each
environment provisioned and a `modules` directory for shared resources that multiple environments
could have

  - `tf/dev`: a development environment associated with an existing account, VPC and subnet

  - `tf/modules`: contains the `server` module, which encompass all the resources necessary to
  provision and manage the web server

- `scripts/`: bash scripts that make use of AWS Systems Manager service in order to configure
the instance in our behalf.

## How to use it

Firstly, you need to configure your AWS credentials. It's recommended to use temporary credentials
with environment variables (`AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY` and `AWS_SESSION_TOKEN`).

Than, go to `tf/dev` and run `tf apply`. This will create the necessary infrastructure resources.
This will output the public ip of the instance, which you will use to access the
nginx server

Finally, go to `scripts/` and run `./all.sh`. It will install the necessary dependencies on the
instance (docker, AWS CloudWatch Agent) without direct access to the instance.

Now, go to `<instance-public-ip>:443`. You should the welcome page of nginx. You also can
see alarms of related metrics on AWS CloudWatch.

> Currently, it's using HTTP protocol (without SSL)
