resource "local_file" "hosts_templatefile6" {
  content = templatefile("${path.module}/hosts6.tftpl",

  { webservers = yandex_compute_instance.web })

  filename = "${abspath(path.module)}/hosts6.ini"
}