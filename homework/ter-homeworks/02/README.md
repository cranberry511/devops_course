## Решение задания 1
5. Ошибки связаны в попыткой использовать некорректные опции для процессора при создания ВМ.
6. Выполнение команды ``` curl ifconfig.me```на удаленной машине:
![Выполнение команды curl](img/remote_ip.jpg)

скриншот ЛК Yandex Cloud с созданной ВМ:
![Скриншот ЛК Yandex Cloud](img/remote_host_yconsole.jpg)

8. Параметры ```preemptible = true``` (Прерываемая ВМ) и ```core_fraction=5``` (гарантированная доля vCPU) позволяют значительно сэкономить при платежах за ВМ, что очень удобно для обучения.


### Решение задания 2
1. Замена всех хардкод-параметров на  переменные:
![Замена всех хардкод-параметров](img/transition_to_var.jpg)

3. Проверка terraform plan:
![Проверка terraform plan](img/no_change.jpg)


### Решение задания 3
1. Создание файла 'vms_platform.tf':
![Создание файла vms_platform.tf](img/db_var.jpg)


### Решение задания 4
1. Объявление в файле outputs.tf output:
![Объявление output](img/output_code.jpg)

Вывод ```terraform output```:
![Вывод terraform output](img/output.jpg)

2. Вывод внешних ip-адресов:
![Вывод ip-адресов](img/external_ip.jpg)


### Решение задания 5
1. Описание имен ВМ в файле locals.tf:
![Описание имен ВМ](img/local_env.jpg)


### Решение задания 6
1. Конфиг в виде вложенного map(object):
![Конфиг в виде вложенного map](img/map_env.jpg)


### Решение задания 7
1. Какой командой можно отобразить **второй** элемент списка test_list - local.test_list[1]:
![Второй элемент списка](img/output_local_list_element.jpg)

2. Длина списка test_list с помощью функции length(<имя переменной>):
![Длина списка test_list](img/local_list_length.jpg)

3. Какой командой можно отобразить значение ключа admin из map test_map - local.test_map.admin:
![Значение ключа admin](img/test_map_admin.jpg)

4. Interpolation-выражение:
```"${local.test_map.admin} is ${keys(local.test_map)[0]} for ${keys(local.servers)[1]} server based on OS ${local.servers.production.image} with ${local.servers.production.cpu} vcpu, ${local.servers.production.ram} ram and ${length(local.servers.production.disks)} virtual disks"```
![Выражение](img/console_phrase.jpg)


### Решение задания 8
1. Описание переменной test:
![Описание переменной test](img/test_var.jpg)

2. Выражение в terraform console, которое позволяет вычленить строку "ssh -o 'StrictHostKeyChecking=no' ubuntu@62.84.124.117" из переменной test:
var.test.dev1[0]
![Строка переменной test](img/console_ssh_var.jpg)


### Решение задания 9
Подключение к ВМ через serial console:
![Подключение к ВМ](img/serial_port_login.jpg)

Проверка доступа в интернет с ВМ:
![Проверка доступа в интернет](img/ping_ya.jpg)
