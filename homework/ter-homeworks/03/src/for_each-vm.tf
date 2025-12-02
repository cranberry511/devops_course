resource "yandex_compute_instance" "db" {
  for_each = { for vm in var.vm : vm.vm_name => vm }
  name        = each.key
  zone           = var.default_zone
  platform_id = var.platform_id
  resources {
    cores         = each.value.cpu
    memory        = each.value.ram
    core_fraction = each.value.core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.my_image_family.id
      size = each.value.disk_volume
    }
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${local.vms_ssh_root_key}"
  }

}