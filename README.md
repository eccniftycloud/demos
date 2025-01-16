# demos
This repository contains a collection of AWS scripts, Terraform configurations, and Lambda/Python functions for managing and automating cloud infrastructure. Below is a quick overview of the key files and their functionality:

Files Overview:
vpc-iac-demo.tf:
A Terraform script for deploying a Virtual Private Cloud (VPC) environment, including subnets, route tables, and other network resources, following AWS best practices.

config-ami-check:
An AWS Config script designed to evaluate and enforce compliance by ensuring that only approved AMIs are used within the environment.

StartEC2Instances.py / StopEC2Instances-Tags:
Python scripts to start and stop EC2 instances based on tags, automating cost and resource management.

Lambda Function Scripts:
Python-based Lambda functions included in the repository provide additional automation capabilities, such as managing resources dynamically.

Purpose:
These scripts and configurations are designed to simplify AWS resource provisioning, enhance compliance, and enable efficient infrastructure management through automation.

Feel free to explore the files for more details or contribute improvements!
