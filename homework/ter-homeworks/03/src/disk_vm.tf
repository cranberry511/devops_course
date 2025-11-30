resource "yandex_compute_disk" "my_disk" {
  count = 3
  name     = "disk-${count.index+1}"
  type     = "network-hdd"
  size = 1
}

resource "yandex_compute_instance" "my_storage" {
  name        = "storage"
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

  dynamic secondary_disk {
    for_each = toset(["0", "1", "2"])
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