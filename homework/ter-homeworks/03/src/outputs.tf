output "vm_list" {
value = concat ([ for i in yandex_compute_instance.web : {fqdn = i.fqdn, id = i.id, name = i.name}], [ for i in yandex_compute_instance.db : {fqdn = i.fqdn, id = i.id, name = i.name}], [ {name = yandex_compute_instance.my_storage.name, id =  yandex_compute_instance.my_storage.id, fqdn = yandex_compute_instance.my_storage.fqdn}])
}
