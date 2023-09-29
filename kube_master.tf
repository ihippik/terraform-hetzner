resource "hcloud_server" "k8s_master" {
  count = var.kube_master_count

  name        = "master-${count.index + 1}.${var.az_name}.hetzner.${var.domain}"
  location    = var.az_name
  image       = var.kube_master_image
  server_type = var.kube_master_size

  ssh_keys = [
    hcloud_ssh_key.default.id
  ]

  firewall_ids = [
    hcloud_firewall.k8s_master.id
  ]

  user_data = file("./user-data/centos.sh")

  labels = {
    team     = var.team_name
    provider = "hetzner"
    geo      = var.geo_name
    country  = var.region_name
    dc       = var.az_name
    class    = var.kube_master_class_name
  }
}

resource "hcloud_server_network" "k8s_master" {
  count = var.kube_master_count

  server_id  = hcloud_server.k8s_master[count.index].id
  network_id = hcloud_network.k8s_private.id
  ip         = cidrhost(hcloud_network_subnet.k8s_private.ip_range, 11 + count.index)
}

resource "hcloud_firewall" "k8s_master" {
  name = "k8s-master"

  rule {
    direction = "in"
    protocol  = "tcp"
    port      = "22"
    source_ips = [
      "0.0.0.0/0",
    ]
  }

  rule {
    direction = "in"
    protocol  = "tcp"
    port      = "6443"
    source_ips = [
      "0.0.0.0/0",
    ]
  }

  rule {
    direction = "in"
    protocol  = "tcp"
    port      = "any"
    source_ips = [
      "10.0.0.0/8",
    ]
  }

  rule {
    direction = "in"
    protocol  = "udp"
    port      = "any"
    source_ips = [
      "10.0.0.0/8",
    ]
  }

  rule {
    direction = "in"
    protocol  = "icmp"
    source_ips = [
      "10.0.0.0/8",
    ]
  }
}
