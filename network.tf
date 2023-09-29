resource "hcloud_network" "k8s_private" {
  name     = "k8s-private"
  ip_range = "10.20.0.0/16"
}

resource "hcloud_network_subnet" "k8s_private" {
  network_id   = hcloud_network.k8s_private.id
  type         = "cloud"
  network_zone = "eu-central"
  ip_range     = "10.20.0.0/24"
}
