resource "yandex_compute_disk" "my_disk" {
  count = 3
  name     = "disk-${count.index+1}"
  type     = "network-hdd"
  size = 1
}

resource "yandex_compute_instance" "my_storage" {
  name        = "storage"
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

  dynamic secondary_disk {
   for_each = yandex_compute_disk.my_disk
    content {
      disk_id     = yandex_compute_disk.my_disk[secondary_disk.key].id      
    }
  } 
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${local.vms_ssh_root_key}"
  }
}