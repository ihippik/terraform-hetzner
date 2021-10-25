resource "hcloud_network" "private" {
  name     = "private"
  ip_range = "10.20.0.0/16"
}

resource "hcloud_network_subnet" "private" {
  network_id   = hcloud_network.private.id
  type         = "cloud"
  network_zone = "eu-central"
  ip_range     = "10.20.0.0/24"
}
