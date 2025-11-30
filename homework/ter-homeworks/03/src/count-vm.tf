data "yandex_vpc_security_group" "example" {
  name = "example_dynamic"
}

resource "yandex_compute_instance" "web" {
  depends_on = [ yandex_compute_instance.db ]
  count = 2
  name        = "web-${count.index+1}"
  zone           = var.default_zone
  platform_id = "standard-v3"
  resources {
    cores         = 2
    memory        = 1
    core_fraction = 20
  }
  boot_disk {
    initialize_params {
      image_id = "fd8qa5pcd0l7123dpvhc"
    }
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    security_group_ids = [data.yandex_vpc_security_group.example.id]
    nat       = false
  }

  metadata = {
    ssh-keys = "ubuntu:${local.vms_ssh_root_key}"
  }

}