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
}


