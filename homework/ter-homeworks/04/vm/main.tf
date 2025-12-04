data "terraform_remote_state" "vpc" {
  backend = "local"
  config = {
    path = "../vpc/terraform.tfstate"
  }
}

module "marketing-vm" {
  source         = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"
  env_name       = "develop" 
  network_id     = data.terraform_remote_state.vpc.outputs.yandex_vpc_network
  subnet_zones   = [var.default_zone]
  subnet_ids     = [data.terraform_remote_state.vpc.outputs.yandex_vpc_subnet[var.default_zone].id]
  instance_name  = "marketing"
  instance_count = var.instance_count
  image_family   = var.image_family
  public_ip      = var.public_ip

  labels = { 
    project = "marketing"
     }

  metadata = {
    user-data          = data.template_file.cloudinit.rendered
  }

}

module "analytics-vm" {
  source         = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"
  env_name       = "develop"
  network_id     = data.terraform_remote_state.vpc.outputs.yandex_vpc_network
  subnet_zones   = [var.default_zone]
  subnet_ids     = [data.terraform_remote_state.vpc.outputs.yandex_vpc_subnet[var.default_zone].id]
  instance_name  = "analytics"
  instance_count = var.instance_count
  image_family   = var.image_family
  public_ip      = var.public_ip

  labels = { 
    project = "analytics"
     }

  metadata = {
    user-data          = data.template_file.cloudinit.rendered
  }

}

data "template_file" "cloudinit" {
  template = file("./cloud-init.yml")
  vars = {
    ssh_public_key     = file("~/.ssh/id_ed25519.pub")
  }
}

