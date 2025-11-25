output "web_name" {
  value = yandex_compute_instance.platform.name
}

output "web_fqdn" {
  value = yandex_compute_instance.platform.fqdn
}

output "web_external_ip_address" {
  value = yandex_compute_instance.platform.network_interface[0].nat_ip_address
}

output "db_name" {
  value = yandex_compute_instance.platform_db.name
}

output "db_fqdn" {
  value = yandex_compute_instance.platform_db.fqdn
}

output "db_external_ip_address" {
  value = yandex_compute_instance.platform_db.network_interface[0].nat_ip_address
}
