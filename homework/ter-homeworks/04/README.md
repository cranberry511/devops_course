## Решение задания 1

1. Создание 2 ВМ:
![Создание 2 ВМ](img/create_vm.jpg)

3. Добавление в файл cloud-init.yml установку nginx.
![Добавление nginx](img/add_nginx.jpg)

4. Подключения к консоли:
![Подключение к консоли](img/connect.jpg)

Вывод команды ```sudo nginx -t```:
![Вывод nginx](img/nginx_info.jpg)

Cкриншот консоли ВМ yandex cloud:
![Скриншот консоли YC](img/vm_list.jpg)

Скриншот содержимого модуля:
![Скриншот модуля](img/output.jpg)


## Решение задания 2
3. Скриншот информации о модуле vpc_dev:
![Скриншот модуля vpc_dev](img/console_modules.jpg)
5. Документацию к модулю:
```docker run --rm --volume "$(pwd):/terraform-docs" -u $(id -u) quay.io/terraform-docs/terraform-docs:0.16.0 markdown /terraform-docs```
https://github.com/cranberry511/devops_course/blob/main/homework/ter-homeworks/04/src/docs.md
 
## Решение задания 3
1. Вывести список ресурсов в стейте:
```terraform state list```
![Список ресурсов](img/state_list.jpg)

2-4. Список команд:
terraform state rm module.vpc_dev.yandex_vpc_network.develop
terraform state rm module.vpc_dev.yandex_vpc_subnet.develop
terraform state rm module.analytics-vm.yandex_compute_instance.vm[0]
terraform state rm module.marketing-vm.yandex_compute_instance.vm[0]
terraform import  module.marketing-vm.yandex_compute_instance.vm[0] fhmrd3utk7vu92pfa8a3
terraform import  module.analytics-vm.yandex_compute_instance.vm[0] fhmi5jen4f96ue9cmfmu
terraform import module.vpc_dev.yandex_vpc_network.develop enpsgvmucertf5ef99nv
terraform import module.vpc_dev.yandex_vpc_subnet.develop e9b28hvu0bogeg76qvql

Скриншоты шагов:
![Удаление ресурсов](img/state_rm.jpg)

![Импорт ресурсов1](img/state_import1.jpg)

![Импорт ресурсов2](img/state_import2.jpg)

![Импорт ресурсов3](img/state_import3.jpg)

![Импорт ресурсов4](img/state_import4.jpg)

Скриншот terraform plan:
![Скриншот terraform plan](img/terraform_plan.jpg)


## Решение задания 4

1. Код измененного модуля vpc:
![Код vpc](img/vpc_new.jpg)

Результат выполнения:
![Результат выполнения](img/network_result.jpg)

## Решение задания 5

1. Модуль для создания кластера БД Mysql:
![Код модуля](img/mysql_code.jpg)

2. Модуль создания базы данных и пользователя:
![Код модуля БД и пользователя](img/module_mysql_db_user.jpg)

Вызов модуля по созданию базы данных и пользователя:
![Вызов модуля БД и пользователя](img/call_mysql_db_user.jpg)

3. Создание кластера example из одном хосте:
![Вызов модуля БД 1](img/standalone_run.jpg)

Результат создания БД test и пользователя app::
![Результат вызова модуля БД 1](img/standalone_result.jpg)
![Результат вызова модуля БД 2](img/standalone_result2.jpg)

Перевод сингл хоста в кластер из 2-х серверов:
![HA run](img/ha_run.jpg)

Процесс обновления кластера:
![HA run in process](img/cluster_status_updating.jpg)

Результат:
![HA результат](img/ha_result.jpg)


## Решение задания 6
1. Код создания s3 бакета размером 1 ГБ:
![Код создания s3 бакета](img/s3_code.jpg)

Результат:
![Результат S3](img/s3_result.jpg)

## Решение задания 7
2. Вход в web-интерфейс:
![Вход в web-интерфейс](img/enter_vault.jpg)

3. Создание нового секрета:
![Создание секрета](img/example_secret.jpg)
 
4. Считывание секрета с помощью terraform:
![Считывание секрета](img/vault_output.jpg)

5. Запись нового секрета в vault:
![Запись секрета](img/create_secret.jpg)

Результат:
![Результат записи секрета](img/my_secret.jpg)

## Решение задания 8
Разделение на два отдельных root-модуля: создание VPC , создание ВМ, ссылки на соответствующие root-модули:
https://github.com/cranberry511/devops_course/tree/main/homework/ter-homeworks/04/vpc
https://github.com/cranberry511/devops_course/tree/main/homework/ter-homeworks/04/vm





