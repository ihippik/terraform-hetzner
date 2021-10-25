variable "team_name" { default = "my-team" }
variable "geo_name" { default = "europe" }
variable "region_name" { default = "finland" }
variable "az_name" { default = "hel1" }
variable "class_name" { default = "compute" }
variable "ssh_key_id" {}

variable "domain" { default = "my-site.com" }

# Hetzner Cloud pricing
#   https://www.hetzner.com/cloud

variable "kube_master_count" { default = 1 }
variable "kube_master_image" { default = "centos-stream-8" }
variable "kube_master_size" { default = "cx21" }
variable "kube_master_class_name" { default = "kube-master" }

variable "kube_worker_count" { default = 2 }
variable "kube_worker_image" { default = "centos-stream-8" }
variable "kube_worker_size" { default = "cx21" }
variable "kube_worker_class_name" { default = "kube-worker" }