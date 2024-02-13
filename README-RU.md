# Создание инфраструктуры в Yandex Cloud для развертывания YDB кластера

Данный Terraform сценарий создаёт следующую инфраструктуру в Yandex Cloud:
1. Сетевые SSD-диски (по умолчанию 200 GB), которые подключаются к ВМ.
2. Приватную облачную сеть и три подсети в зонах доступности `ru-central1-a`, `ru-central1-b`, `ru-central1-d`.
3. Виртуальные машины (по умолчанию девять штук), распределенные по трём зонам доступности, связанные общей сетью.
4. Инсталляционную машину для установки Ansible.
5. Приватную DNS-зону.

Для работы данного Terraform сценария понадобится:
1. Активный платежный аккаунт с положительным балансом для создания и работы указанного в переменной `static_node_vm_value` количества серверов.
2. Сервисный аккаунт, который можно создать следуя следующим шагам:
    * В консоли управления выберите каталог, в котором хотите создать сервисный аккаунт.
    * На вкладке **Сервисные аккаунты** нажмите кнопку **Создать сервисный аккаунт**.
    * Введите имя сервисного аккаунта. Длина от 3 до 63 символов, может содержать строчные буквы латинского алфавита, цифры и дефисы, первый символ — буква, последний — не дефис.
    * Назначьте сервисному аккаунту роль `compute.admin`.
    * Нажмите кнопку **Создать**.
    * Зайдите в созданный сервисный аккаунт.
    * Нажмите на кнопку **Создать новый ключ** на верхней панели инструментов работы с сервисным аккаунтом.
    * Выберите **Создать авторизованный ключ**, введите описание ключа (опционально), нажмите **Создать**.
    * Скачайте ключ безопасности в удобную для вас директорию и укажите путь к нему в переменной `key_path`.
3. Установленный Yandex Cloud провайдер. Создайте конфигурационный Terraform-файл или отредактируйте его, если он уже был создан: `%APPDATA%/terraform.rc` для Windows и `~/.terraformrc` для Linux/macOS. Добавьте в него блок:
    ```tf
    provider_installation {
        network_mirror {
            url = "https://terraform-mirror.yandexcloud.net/"
            include = ["registry.terraform.io/*/*"]
        }
        direct {
            exclude = ["registry.terraform.io/*/*"]
        }
    }
    ```
4. Настроенные [квоты](https://cloud.yandex.ru/ru/docs/compute/concepts/limits) ресурсов Yandex Cloud. Достижение лимитов квот при создании инфраструктуры с помощью Terraform приведёт к ошибкам создания ресурсов. Обратите внимание на следующие квоты: 
* `Compute Cloud`:
    + `Количество vCPU виртуальных машин` – стандартное значение квоты: 32.
    + `Общий объём RAM виртуальных машин` – стандартное значение квоты: 128 GiB.
    + `Количество виртуальных машин ` – стандартное значение квоты: 12.
    + `Общий объём SSD-дисков ` – стандартное значение квоты: 200 GiB.
* `Virtual Private Cloud`:
    + `Количество облачных сетей` – стандартное значение квоты: 2.
    + `Количество статических публичных IP-адресов` – стандартное значение квоты: 2.
5. Подготовленная пара SSH-ключей. Путь к публичному ключу, который будет загружен на серверы, задается в переменной `ssh_key_pub_path`.

## Структура проекта и значение переменных

Проект состоит из трёх файлов: `main.tf` – сценарий создания ресурсов в облаке, `vars_init.tf` – инициализация переменных, `terraform.tvars` – значение переменных. Переменные содержат настройки ресурсов Yandex Cloud. Часть из них можно оставить дефолтными, а переменные содержащие данные для аутентификации должны быть обновлены.

#### Переменные, содержащие данные для аутентификации

#|
|| **Название переменной** | **Описание переменной** | **Тип данных** | **Пример** ||
||`key_path`| Путь к авторизованному ключу в формате JSON, созданному с помощью команды: 
```bash
yc iam key create \
--service-account-name <service-acc-name> \
--output key.json --folder-id <folder-id>
``` | Строка | "../auth_key.json"||
|| `cloud_id`| Идентификатор облака. Получить ID облака можно командой `yc resource-manager cloud list` (сервисный аккаунт должен обладать ролью `resource-manager.clouds.member`) или скопировать из консоли облака. ID облака располагается рядом с его названием. | Строка | "b1gv7kfcttiop..."||
|| `folder_id` | Идентификатор каталога. Получить ID каталога можно командой ```yc resource-manager folder list``` или скопировать из консоли облака. ID каталога располагается рядом с его названием. | Строка | "b1gd9ii2bbihond..."||
|| `zone_name` | Зона доступности Yandex Cloud – это инфраструктура внутри дата-центра, в котором размещается платформа Yandex Cloud. Доступны четыре зоны, но рекомендуется использовать: `ru-central1-a` и `ru-central1-b`. По умолчанию, если зона явно не задана используется, то используется зона `ru-central1-a`. | Строка | "ru-central1-a" |
|#

#### Переменные, содержащие параметры конфигурации ВМ

#|
|| **Название переменной** | **Описание переменной** | **Тип данных** | **Пример** ||
|| `vps_platform` | Наименование платформы для ВМ. Каждая платформа соответствует одной из процессорных микроархитектур, разрабатываемых Intel: `standard-v1` – Intel Broadwell, `standard-v2` – Intel Cascade Lake, `standard-v3` – Intel Ice Lake. | Строка | "standard-v1" ||
|| `vps_name` | Имя ВМ. Имя может содержать строчные буквы латинского алфавита, цифры и дефисы. Первый символ – буква, а последний – не дефис. Допустимая длина: от 3 до 63 символов. | Строка | "ydb-one-node-base" ||
|| `cores` | Количество ядер у ВМ. Минимальное количество ядер 2, максимальное количество – 32 ядра. | Число | 2 || 
|| `memory` | Объем памяти у ВМ. Минимальный объём памяти – 2 GB, максимальный объём – 32 GB. | Число | 4 ||
|| `os_image_id` | Идентификатор образа OS. Получить список всех образов OS можно командой 
```bash
yc compute image list --folder-id standard-images
``` | Строка | "fd8clogg1kull9084s9o" ||
|| `storage_size` | Размер стартового диска. Придельные границы размера зависят от типа накопителя: HHD и SSD – от 8GB до 8192GB, SSD IO и нереплицируемый SSD – от 93GB до 262074GB. | Число | 120 ||
|| `storage_type_ssd`| Тип накопителя. Может принимать значения:  `network-ssd` — быстрый сетевой SSD-диск, `network-hdd` – стандартный сетевой HDD-диск, `network-ssd-nonreplicated` – сетевой SSD-диск с повышенной производительностью без избыточности, `network-ssd-io-m3` – высокопроизводительный SSD-диск, обеспечивающий избыточность. | Строка | "network-ssd" ||
|#


#### Переменные, содержащие данные для подключения диска к ВМ

#|
|| **Название переменной** | **Описание переменной** | **Тип данных** | **Пример** ||
|| `attache_disk_name` | Имя присоединяемого к ВМ диска. Правила нейминга такие же как для имен ВМ. | Строка  | "ydb-disk" ||
|| `attache_disk_size` | Размер подключаемого диска (GB). Размер диска зависит от его типа, если выбран тип `network-ssd-nonreplicated`, то минимальное размер диска будет равен 93GB, шаг увелечения размера – 93GB. Для дисков других типов ограничения на шаг увелечения размера диска – 1GB. | Число | 93 ||  
|| `attache_disk_type` | Тип присоединяемого диска к ВМ. Используются такие же типы как для стартового диска: `network-ssd`, `network-hdd`, `network-ssd-nonreplicated`, `network-ssd-io-m3`. | Строка |"network-ssd-nonreplicated" ||
|#


#### Переменные, содержащие данные для подключения к ВМ

#|
|| **Название переменной** | **Описание переменной** | **Тип данных** | **Пример** ||
|| `user`| Имя пользователя для подключения по SSH. | Строка | "ubuntu" ||
|| `ssh_key_pub_path` | Путь к публичной части SSH-ключа, расположенной на локальной машине. | Строка | "~/yandex.pub" ||
|#

## Создание, удаление и изменение инфраструктуры

Все команды выполняются в директории, где располагается Terraform сценарий:
* Создать план развертывания инфраструктуры можно командой `terraform plan`. При первом вызове команды `terraform plan` может потребоваться выполнить команду `terraform apply`.
* Развернуть инфраструктуру можно командой `terraform apply`.
* Удалить инфраструктуру можно командой `terraform destroy`. Она же применяется, если произошёл сбой в развертывании инфраструктуры.

Изменить создаваемые ресурсы можно следующим способом:
* Изменить значение ресурсов с помощью переменных в файле `terraform.tvars` или добавить/удалить ресурсы в файле `main.tf`;
* Выполнить команду `terraform plan` для проверки сценария изменения инфраструктуры и выполнить команду `terraform apply` для применения изменений.

Изменение ресурсов относящихся к ВМ происходит с остановкой серверов. 
