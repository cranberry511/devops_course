resource "yandex_vpc_network" "develop" {
  name = var.vpc_name
}

resource "yandex_vpc_network" "develop_db" {
  name = var.vpc_db_name
}

resource "yandex_vpc_subnet" "develop" {
  name           = var.vpc_name
  zone           = var.default_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.default_cidr
  route_table_id = yandex_vpc_route_table.rt_web.id
}

resource "yandex_vpc_subnet" "develop_db" {
  name           = var.vpc_db_name
  zone           = var.vm_db_zone
  network_id     = yandex_vpc_network.develop_db.id
  v4_cidr_blocks = var.vm_db_cidr
  route_table_id = yandex_vpc_route_table.rt_db.id
}


data "yandex_compute_image" "ubuntu" {
  family = var.vm_db_compute_image
}
resource "yandex_compute_instance" "platform" {
  name        = local.web_vm_name
  zone           = var.default_zone
  platform_id = var.vm_web_platform_id
  resources {
    cores         = var.vms_resources.web.cores
    memory        = var.vms_resources.web.memory
    core_fraction = var.vms_resources.web.core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }
  scheduling_policy {
    preemptible = var.vm_web_preemptible
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = var.vm_web_nat
  }

  metadata = var.metadata

}

resource "yandex_compute_instance" "platform_db" {
  name        = local.db_vm_name
  zone           = var.vm_db_zone
  platform_id = var.vm_db_platform_id
  resources {
    cores         = var.vms_resources.db.cores
    memory        = var.vms_resources.db.memory
    core_fraction = var.vms_resources.db.core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }
  scheduling_policy {
    preemptible = var.vm_db_preemptible
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop_db.id
    nat       = var.vm_db_nat
  }

  metadata = var.metadata
}

resource "yandex_vpc_gateway" "nat_gateway_web" {
  name = "web-gateway"
  shared_egress_gateway {}
}

resource "yandex_vpc_route_table" "rt_web" {
  name       = "web-route-table"
  network_id = yandex_vpc_network.develop.id

  static_route {
    destination_prefix = "0.0.0.0/0"
    gateway_id         = yandex_vpc_gateway.nat_gateway_web.id
  }
}

resource "yandex_vpc_gateway" "nat_gateway_db" {
  name = "db-gateway"
  shared_egress_gateway {}
}

resource "yandex_vpc_route_table" "rt_db" {
  name       = "db-route-table"
  network_id = yandex_vpc_network.develop_db.id

  static_route {
    destination_prefix = "0.0.0.0/0"
    gateway_id         = yandex_vpc_gateway.nat_gateway_db.id
  }
}
