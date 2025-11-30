resource "local_file" "hosts_for" {
  content =  <<-EOT
  [webservers] %{for i in yandex_compute_instance.web }
  ${i["name"]}   ansible_host=${i["network_interface"][0]["nat_ip_address"]} fqdn=${i["fqdn"]} %{endfor}
  
  [storage]
  ${yandex_compute_instance.my_storage.name}   ansible_host=${yandex_compute_instance.my_storage.network_interface[0].nat_ip_address} fqdn=${yandex_compute_instance.my_storage.fqdn}
  
  [db] %{for i in yandex_compute_instance.db }
  ${i["name"]}   ansible_host=${i["network_interface"][0]["nat_ip_address"]} fqdn=${i["fqdn"]} %{endfor}
   EOT
  filename = "${abspath(path.module)}/hosts.ini"
}