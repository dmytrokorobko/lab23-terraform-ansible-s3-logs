# 🚀 Lab 23 — Centralized Ansible Logs in S3 using Terraform Outputs

This lab demonstrates a full **infrastructure-to-operations workflow** on AWS, combining **Terraform, Ansible, IAM roles, and Amazon S3**.
The focus is on clean separation of responsibilities, layered infrastructure design, and secure interaction between EC2 instances and AWS services without static credentials.

---

## 🧠 Architecture Overview

The solution is built as a layered system:

* **Terraform** provisions AWS infrastructure and exposes required data via outputs
* **Ansible** consumes Terraform outputs through a dynamic inventory
* **EC2 instances** use IAM roles to securely upload logs to S3
* **Amazon S3** acts as a centralized log storage

No access keys are stored on hosts or in Ansible configuration.

---

## ⚙️ Terraform Design

Terraform is organized into independent layers with isolated remote state:

**01_network**

* VPC, subnets, routing, and internet gateway
* Deterministic subnet placement across availability zones
* Outputs exported for downstream layers

**02_compute**

* EC2 instances running Amazon Linux
* IAM role and instance profile for S3 access
* Security groups and SSH access
* Outputs exposing instance public IPs and S3 bucket name

Cross-layer communication is implemented using ***terraform_remote_state***, enforcing explicit dependencies and avoiding implicit coupling.

---

## ⚙️ Ansible Design

Ansible is used strictly for configuration and operational tasks:

**Dynamic inventory**

* Generated from Terraform outputs at runtime
* No static host definitions

**Playbooks**

* 01_create_log.yml — creates a test log file on each EC2 instance
* 02_upload_log.yml — uploads logs to S3 using AWS CLI and IAM role

The S3 bucket name is injected via environment variable on the control node, while authentication is handled entirely by the EC2 instance role.

---

## 🧰 IAM and Security Model

* EC2 instances assume an IAM role via instance profile
* IAM policy allows:
  * s3:PutObject
  * s3:ListBucket
* No AWS credentials are stored in:
  * Terraform
  * Ansible
  * EC2 filesystem

This setup reflects a real-world, production-style AWS security model.

---

## 🧪 Key Takeaways

* Practical use of layered Terraform architecture with remote state
* Clean separation between provisioning and configuration management
* Secure AWS access using IAM roles instead of static credentials
* Dynamic Ansible inventory driven by infrastructure outputs
* Amazon Linux chosen to simplify AWS-native tooling integration

---

## 💡 Result

Each EC2 instance generates a log file and successfully uploads it to a shared S3 bucket, validating a complete and secure **Terraform → Ansible → AWS** workflow.

---

## 🤝 Contributing
Pull requests welcome.
For major changes, please open an issue first to discuss what you’d like to change.

---

## 📄 License
This project is licensed under the [MIT License](https://choosealicense.com/licenses/mit/).

---

⭐ **Made with passion and coffee by [Dmytro Korobko](https://github.com/dmytrokorobko)**
