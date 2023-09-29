variable "team_name" { default = "scum-electro" }
variable "geo_name" { default = "europe" }
variable "region_name" { default = "germany" }
variable "az_name" { default = "nbg1" }
variable "class_name" { default = "compute" }
variable "ssh_key_id" {}

variable "domain" { default = "scum-gazeta.com" }

# Hetzner Cloud pricing
#   https://www.hetzner.com/cloud

variable "kube_master_count" { default = 1 }
variable "kube_master_image" { default = "centos-stream-9" }
variable "kube_master_size" { default = "cx21" }
variable "kube_master_class_name" { default = "kube-master" }

variable "kube_worker_count" { default = 3 }
variable "kube_worker_image" { default = "centos-stream-9" }
variable "kube_worker_size" { default = "cx21" }
variable "kube_worker_class_name" { default = "kube-worker" }
variable "hcloud_token" {}