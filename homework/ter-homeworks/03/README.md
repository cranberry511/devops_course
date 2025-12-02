## Дополнение
- Жестко заданные значения параметров изменены на переменные. Теперь код выглядит следующим образом:
![Новый код](img/new_code.jpg)
- Изменено подключение дополнительных дисков
![Подключение дисков](img/new_code_storage.jpg)
- Изменен output:
![Изменен output](img/output_code.jpg)

Теперь вывод выглядит следующим образов:
![Вывод output](img/output.jpg)

-----------------------------------------------
## Решение задания 1
Cкриншот входящих правил «Группы безопасности» в ЛК Yandex Cloud:
![Входящие правила](img/security_groups.jpg)


## Решение задания 2
1. Файл count-vm.tf:
![Файл count-vm.tf](img/count-vm.jpg)

2. Файл for_each-vm.tf:
![Файл for_each-vm.tf](img/for_each_vm.jpg) 


## Решение задания 3
1. Создание 3 одинаковых виртуальных диска размером 1 Гб в файле **disk_vm.tf** :
![Файл disk_vm.tf](img/disk_vm.jpg) 

2. Создание ВМ c именем "storage" и подключение дисков:
![Подключение дисков](img/disk_connect.jpg) 


## Решение задания 4
1. Файл ansible.tf:
![Создание inventory](img/ansible.jpg)

Файл inventory:
![Файл inventory](img/inventory.jpg)


## Решение задания 5
1. Output, который отображает ВМ в виде списка словарей:
![Output код](img/output_code.jpg)

Вывод команды ```terrafrom output```:
![Output](img/output.jpg)


## Решение задания 6
3.Файл-шаблон hosts6.tftpl:
![Файл-шаблон](img/hosts_tftpl.jpg)

Результат:
![Результат](img/inventory_6.jpg)

https://github.com/cranberry511/devops_course/blob/main/homework/ter-homeworks/03/src/hosts6.tftpl
https://github.com/cranberry511/devops_course/blob/main/homework/ter-homeworks/03/src/inventory6.tf

## Решение задания 7
Выражение в terraform console, которое удаляет 3 элемент:
```
{"network_id" = "enp7i560tb28nageq0cc", subnet_ids = [for index, id in local.vpc.subnet_ids : id if index != 2], subnet_zones  = [for index, zone in local.vpc.subnet_zones : zone if index != 2]}
```

Результат:
![Результат](img/7_exercise.jpg)


## Решение задания 8
Ошибка заключается в некорректно расположении фигурных скобок, закрывающих вывод для переменной ansible_host, а также в лишнем пробеле для "platform_id ":
![Ошибка](img/error.jpg)

Правильный вариант:
![Ошибка](img/correct.jpg)


## Решение задания 9
1. ```[for i in range(1, 100) : "rc${i}"]```
![Результат](img/range.jpg)

2. ```[for i in range(1, 97) :  "rc${i}" if i == 19 || !contains(["0","7","8","9"], substr(i, -1, 1))]```
![Результат](img/range_excl.jpg)