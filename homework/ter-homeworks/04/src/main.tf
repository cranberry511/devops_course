/*module "vpc_dev" {
  source       = "./vpc"
  env_name     = "develop"
  zone = "ru-central1-a"
  cidr = ["10.0.1.0/24"]
}*/

module "vpc_prod" {
  source       = "./vpc"
  env_name     = "production"
  subnets = [
    { zone = "ru-central1-a", cidr = "10.0.1.0/24" },
    { zone = "ru-central1-b", cidr = "10.0.2.0/24" },
    { zone = "ru-central1-d", cidr = "10.0.3.0/24" },
  ]
}

module "vpc_dev" {
  source       = "./vpc"
  env_name     = "develop"
  subnets = [
    { zone = "ru-central1-a", cidr = "10.0.1.0/24" },
  ]
}

/*
resource "random_string" "unique_id" {
  length  = 8
  upper   = false
  lower   = true
  numeric = true
  special = false
}

module "s3" {
  source = "git::https://github.com/terraform-yc-modules/terraform-yc-s3.git?ref=master"
  bucket_name = "simple-bucket-${random_string.unique_id.result}"
  max_size   = 1073741824
}
*/

module "marketing-vm" {
  source         = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"
  env_name       = "develop" 
  network_id     = module.vpc_dev.yandex_vpc_network
  subnet_zones   = [var.default_zone]
  subnet_ids     = [module.vpc_dev.yandex_vpc_subnet[var.default_zone].id]
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
  network_id     = module.vpc_dev.yandex_vpc_network
  subnet_zones   = [var.default_zone]
  subnet_ids     = [module.vpc_dev.yandex_vpc_subnet[var.default_zone].id]
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


resource "yandex_vpc_network" "mysql_net" {
  name = "mysql_net"
}

module "mysql_cluster" {
  source       = "./mysql"
  name     = "example"
  net_id = yandex_vpc_network.mysql_net.id
  HA = true
}

module "mysql_db_user" {
  source       = "./mysql_db_user"
  cluster_id = module.mysql_cluster.cluster_id
  db_name     = "test"
  db_user = "app"
}


provider "vault" {
 address = "http://127.0.0.1:8200"
 skip_tls_verify = true
 token = "education"
}
data "vault_generic_secret" "vault_example"{
 path = "secret/example"
}

output "vault_example" {
 value = "${nonsensitive(data.vault_generic_secret.vault_example.data)}"
}

resource "vault_generic_secret" "my_secret" {
  path = "secret/new_path"
  data_json = jsonencode({
     "spell": "Abrakadabra!"
  })
}