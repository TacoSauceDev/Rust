data "template_file" "user_data" {
  template = file("./cloud-init/default.yaml")
}
resource "digitalocean_droplet" "rust_pve_dev" {
    image = "ubuntu-20-04-x64"
    name = "Rust-PVE-Dev"
    region = "nyc1"
    size = "s-1vcpu-1gb"
    private_networking = true
    user_data = data.template_file.user_data.rendered
    lifecycle {
    create_before_destroy = true
  }
}
resource "digitalocean_floating_ip" "rust_floating_ip" {
  droplet_id = digitalocean_droplet.rust_pve_dev.id
  region     = digitalocean_droplet.rust_pve_dev.region
}

resource "digitalocean_floating_ip_assignment" "rust_floating_ip_assignment" {
  ip_address = digitalocean_floating_ip.rust_floating_ip.ip_address
  droplet_id = digitalocean_droplet.rust_pve_dev.id
}
