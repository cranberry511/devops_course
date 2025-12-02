###cloud vars
variable "token" {
  type        = string
  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
}

variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network&subnet name"
}

variable "platform_id" {
  type        = string
  default     = "standard-v3"
}

variable "os_family" {
  type        = string
  default     = "ubuntu-2404-lts"
}

variable "vm_cpu" {
  type        = number
  default     = 2
}

variable "vm_ram" {
  type        = number
  default     = 1
}

variable "vm_core_fraction" {
  type        = number
  default     = 20
}

variable "vm_web_count" {
  type        = number
  default     = 2
}

variable "vm" {
  type = list(object({  vm_name=string, cpu=number, ram=number, disk_volume=number, core_fraction=number }))
  default = [{
      vm_name = "main"
      cpu = 2
      ram = 1
      disk_volume = 10
      core_fraction = 20
    },
     {
      vm_name = "replica"
      cpu = 4
      ram = 2
      disk_volume = 20
      core_fraction = 50
    }
  ]
}
