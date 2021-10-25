resource "hcloud_server" "kube_master" {
  count = var.kube_master_count

  name        = "master-${count.index + 1}.${var.az_name}.hetzner.${var.domain}"
  location    = var.az_name
  image       = var.kube_master_image
  server_type = var.kube_master_size

  ssh_keys = [
    var.ssh_key_id
  ]

  firewall_ids = [
    hcloud_firewall.kube_master.id
  ]

  user_data = file("./user-data/prepare.sh")

  labels = {
    team     = var.team_name
    provider = "hetzner"
    geo      = var.geo_name
    country  = var.region_name
    dc       = var.az_name
    class    = var.kube_master_class_name
  }
}

resource "hcloud_server_network" "kube_master" {
  count = var.kube_master_count

  server_id  = hcloud_server.kube_master[count.index].id
  network_id = hcloud_network.private.id
  ip         = cidrhost(hcloud_network_subnet.private.ip_range, 11 + count.index)
}

resource "hcloud_firewall" "kube_master" {
  name = "kube-master"

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
