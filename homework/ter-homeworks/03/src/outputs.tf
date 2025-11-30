output "web_name" {
  value = { for i in yandex_compute_instance.web : i.name => {fqdn = i.fqdn, id = i.id, name = i.name}}
}

output "db_name" {
  value = { for i in yandex_compute_instance.db : i.name => {fqdn = i.fqdn, id = i.id, name = i.name}}
}

output "storage_name" {
  value = { "${yandex_compute_instance.my_storage.name}" = {name = yandex_compute_instance.my_storage.name, id =  yandex_compute_instance.my_storage.id, fqdn = yandex_compute_instance.my_storage.fqdn}}
}
