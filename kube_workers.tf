resource "hcloud_server" "k8s_worker" {
  count = var.kube_worker_count

  name        = "worker-${count.index + 1}.${var.az_name}.hetzner.${var.domain}"
  location    = var.az_name
  image       = var.kube_worker_image
  server_type = var.kube_worker_size

  ssh_keys = [
    hcloud_ssh_key.default.id
  ]

  firewall_ids = [
    hcloud_firewall.k8s_worker.id
  ]

  user_data = file("./user-data/centos.sh")

  labels = {
    team     = var.team_name
    provider = "hetzner"
    geo      = var.geo_name
    country  = var.region_name
    dc       = var.az_name
    class    = var.kube_worker_class_name
  }
}

resource "hcloud_server_network" "k8s_worker" {
  count = var.kube_worker_count

  server_id  = hcloud_server.k8s_worker[count.index].id
  network_id = hcloud_network.k8s_private.id
  ip         = cidrhost(hcloud_network_subnet.k8s_private.ip_range, 21 + count.index)
}

resource "hcloud_firewall" "k8s_worker" {
  name = "k8s-worker"

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
    port      = "22"
    source_ips = [
      "0.0.0.0/0",
    ]
  }

  rule {
    direction = "in"
    protocol  = "tcp"
    port      = "80"
    source_ips = [
      "0.0.0.0/0",
    ]
  }

  rule {
    direction = "in"
    protocol  = "tcp"
    port      = "443"
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

output "workers" {
  value = hcloud_server.k8s_worker
}
