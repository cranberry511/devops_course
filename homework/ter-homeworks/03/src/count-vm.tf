data "yandex_vpc_security_group" "example" {
  name = "example_dynamic"
}

resource "yandex_compute_instance" "web" {
  depends_on = [ yandex_compute_instance.db ]
  count = var.vm_web_count
  name        = "web-${count.index+1}"
  zone           = var.default_zone
  platform_id = var.platform_id
  resources {
    cores         = var.vm_cpu
    memory        = var.vm_ram
    core_fraction = var.vm_core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.my_image_family.id
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