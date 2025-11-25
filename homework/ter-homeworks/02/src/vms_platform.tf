variable "db_name" {
  type        = string
  default     = "netology-develop-platform-db"
}

variable "vm_db_zone" {
  type        = string
  default     = "ru-central1-b"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}

variable "vm_db_cidr" {
  type        = list(string)
  default     = ["10.0.2.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_db_name" {
  type        = string
  default     = "develop_db"
  description = "VPC network & subnet name"
}

variable "vm_db_compute_image" {
  type        = string
  default     = "ubuntu-2004-lts"
}

variable "vm_db_platform_id" {
  type        = string
  default     = "standard-v3"
}

/*variable "vm_db_cores" {
  type        = number
  default     = 2
}

variable "vm_db_memory" {
  type        = number
  default     = 2
}

variable "vm_db_core_fraction" {
  type        = number
  default     = 20
}
*/
variable "vm_db_preemptible" {
  type        = bool
  default     = true
}

variable "vm_db_nat" {
  type        = bool
  default     = false
}

/*variable "vm_db_serial-port-enable" {
  type        = number
  default     = 1
}*/

variable "resource_tags" {
  type        = map(string)
  default = {
    project     = "project-alpha"
    environment = "dev"
  }
}


variable "vms_resources" {
  type = map
  default = {
    web = {
      cores=2
      memory=1
      core_fraction=20
  },
    db = {
      cores=2
      memory=2
      core_fraction=20
  }
  }
}

variable "metadata" {
  default = {
  serial-port-enable = 1
  ssh-keys           = "ubuntu:ssh-ed25519 AA..............................................wh"
  }
}

variable "test" {
  type = map (tuple([string, string]))
   default = {
    "dev1" = [ "ssh -o 'StrictHostKeyChecking=no' ubuntu@62.84.124.117", "10.0.1.7" ]
    "dev2" = [ "ssh -o 'StrictHostKeyChecking=no' ubuntu@84.252.140.88", "10.0.2.29" ]
    "prod1" = [ "ssh -o 'StrictHostKeyChecking=no' ubuntu@51.250.2.101", "10.0.1.30" ]
  }
}
