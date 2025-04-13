#  Provisioning DigitalOcean VM with Terraform

This project provisions a single Ubuntu-based Droplet (Virtual Machine) on DigitalOcean using Terraform. It's designed as a foundational infrastructure layer

---

## 🧱 Tech Stack

- Terraform
- DigitalOcean

---

## 📁 Project Structure

```
terraform-digitalocean-deploy/
├── main.tf
├── variables.tf
├── terraform.tfvars
└── README.md
```

---

## 🛠️ Prerequisites

- Terraform CLI installed
- DigitalOcean Personal Access Token (API key)

---

## 🔧 What This Project Does

- Provisions an Ubuntu 22.04 Droplet in your chosen DigitalOcean region
- Optionally configures a basic firewall (port 22 for SSH, port 80 for HTTP)
- (Optionally) Accepts a startup script for post-creation tasks (e.g., install Docker)

Note: This repo currently focuses only on infrastructure provisioning.

---

## 📄 main.tf (core resources)

```hcl
resource "digitalocean_droplet" "web" {
  name              = var.droplet_name
  region            = var.region
  size              = var.droplet_size
  image             = var.image
  ssh_keys          = [var.ssh_key_id]
  tags              = var.droplet_tags
  # Optional startup script 
  # user_data         = file(var.user_data_script)
}

resource "digitalocean_firewall" "web_firewall" {
  name = "web-firewall"

  droplet_ids = [digitalocean_droplet.web.id]

  inbound_rule {
    protocol         = "tcp"
    port_range       = "22"
    source_addresses = ["0.0.0.0/0"]
  }

  inbound_rule {
    protocol         = "tcp"
    port_range       = "80"
    source_addresses = ["0.0.0.0/0"]
  }

  outbound_rule {
    protocol              = "tcp"
    port_range            = "all"
    destination_addresses = ["0.0.0.0/0"]
  }
}
```

---

## 📄 variables.tf

```hcl
variable "droplet_name" {
  type        = string
  description = "Name of the droplet"
}

variable "region" {
  type        = string
  default     = "nyc3"
}

variable "droplet_size" {
  type        = string
  default     = "s-1vcpu-1gb"
}

variable "image" {
  type        = string
  default     = "ubuntu-22-04-x64"
}

variable "ssh_key_id" {
  type        = string
  description = "DigitalOcean SSH key ID"
}

variable "user_data_script" {
  type        = string
  default     = "install-docker.sh"
}

variable "droplet_tags" {
  type        = list(string)
  default     = ["web"]
}
```

---

## 📄 terraform.tfvars

```hcl
droplet_name      = "web-droplet"
ssh_key_id        = "your-do-ssh-key-id"
```

Note: If you're not using a startup script yet, you can leave user_data_script unused.

---

## 🚀 Deploy the VM

Initialize and apply the Terraform configuration:

```bash
terraform init
terraform apply
```

When prompted, confirm the plan to create the resources.

---

## 🔐 SSH Access

Once deployed, connect to your VM using its public IP:

```bash
ssh root@<droplet-ip>
```

Your SSH key must be loaded locally with ssh-agent or specified with -i.

---

## 🧹 Teardown

Destroy the infrastructure when you’re done:

```bash
terraform destroy
```

---

## 📌 Notes
- The user_data script is included for future expansion, e.g., automatic Docker installation.
- You can later expand this to pull and run a Docker image (e.g., from ).

---
```
