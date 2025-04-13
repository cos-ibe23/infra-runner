variable "do_token" {
  description = "DigitalOcean API token"
  type        = string
  sensitive   = true
}

variable "droplet_name" {
  description = "The name of the Droplet"
  type        = string
}

variable "region" {
  description = "The region to deploy the Droplet"
  type        = string
}

variable "droplet_size" {
  description = "The size of the Droplet"
  type        = string
}

variable "image" {
  description = "The image for the Droplet"
  type        = string
}

variable "droplet_tags" {
  description = "Tags to assign to the Droplet"
  type        = list(string)
}

variable "firewall_name" {
  description = "The name of the Firewall"
  type        = string
}
