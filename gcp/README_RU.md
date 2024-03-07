# Создание инфраструктуры в Google Cloud Platform для развертывания YDB кластера

Для реализации данного Terraform сценария понадобится: Google Cloud Platform (GCP) аккаунт, активный платежный аккаунт, достаточное количество средства для запуска 9 виртуальных машин, подготовленные SSH-ключи.

1. Зарегистрируйтесь в Google Cloud console.
2. [Создайте](https://console.cloud.google.com/projectselector2/home) проект.
3. Активируйте [платежный аккаунт](https://console.cloud.google.com/billing/manage) и пополните его средствами для запуска девяти ВМ. Рассчитать стоимость можно в [калькуляторе](https://cloud.google.com/products/calculator?hl=en&dl=CiQ2N2I0OThlMS04NmQ1LTRhMzUtOTI0NS04YmVmZTVkMWQ2ODUQCBokRjJGMjBFOTgtQkY0MC00QTcyLUFFNjktODYxMDU2QUIyRDBD). 
4. Актируйте [Compute Engine API](https://console.cloud.google.com/apis/api/compute.googleapis.com/metrics) и [Cloud DNS API](https://console.cloud.google.com/apis/api/dns.googleapis.com/metrics).
5. Скачайте и установите GCP CLI, следуя [этой](https://cloud.google.com/sdk/docs/install) инструкции.
6. Перейдите в поддиректорию `.../google-cloud-sdk/bin` и выполните команду `./gcloud compute regions list` для получения списка доступных регионов.
7. Выполните команду `./gcloud auth application-default login` для настройки профиля подключения.
8. Скачайте репозиторий с помощью команды `git clone https://github.com/ydb-platform/ydb-terraform`.
9. Перейдите в поддиректорию `gcp` (находится в скаченном репозитории) и в файле `variables.tf` задайте актуальные значения следующим переменным:
    * `project` – название проекта, которое было задано в облачной консоли Google Cloud.
    * `region` – регион, где будет развернута инфраструктура.
    * `zones` – список зон доступности, в которых будут созданы подсети и ВМ.

Теперь, находясь в поддиректории `gcp` можно выполнить последовательность следующих команд для установки провайдера, инициализации модулей и создания инфраструктуры:
* `terraform init` – установка провайдера и инициализация модулей.
* `terraform plan` – создание плана будущей инфраструктуры.
* `terraform init` (повторное выполнение) – создание ресурсов в облаке. 

Далее используются команды `terraform plan`, `terraform init` и `terraform destroy` (уничтожение созданной инфраструктуры).

## Значения переменных

Глобальные переменные проекта, содержащие данные для аутентификации, конфигурации виртуальных серверов,  находятся в корневом `variables.tf`, а локальные переменные модулей находятся в `variables.tf`, в каждом модуле. Переменные корневого файла `variables.tf`:

| Название переменной | Описание | Тип | Дефолтное значение | Примечание |
|---------------------|----------|-----|--------------------| ---------- |
| `project` | Название проекта, которое было задано в облачной консоли Google Cloud. | string | <project name> ||
| `region` | Регион, где будет развернута инфраструктура. | string | <region> | Список регионов можно получить командой `./gcloud compute regions list`.|
| `zones` | Список зон доступности, в которых будут созданы подсети и ВМ. | list(string) | [\<zone name>, ... ] | Список зон доступности можно получить командой `./gcloud compute zones list \| grep <region-name>`.|
| `vpc_name` | Название облачной сети. | string | ydb-vpc ||
| `subnet_count` | Количество подсетей. | string | 3 | Сети создаются в разных зонах доступности. |
| `subnet_name` | Префикс названия подсети. | ydb-inner | Полное имя подсети формируется из префикса названия подсети и её порядково номера создания. |
| `vm_count` | Количество создаваемых ВМ | number | 9 | Минимальное количество ВМ для создания YDB кластера – 8 ВМ.|
| `vm_name` | Имя ВМ. | string | ydb-node | |
| `vm_size` | Название шаблона ВМ, из которого будет создан сервер. | string | e2-small | Шаблон определяет количество ядер CPU и объём RAM. Список доступных шаблонов для конкретных зон доступности можно получить командой `./gcloud compute machine-types list --filter="zone:( <zone name> )"`. В качестве разделителя в списке зон используется пробел. Кавычки в списке не требуются. |
| `bootdisk_image` | Название шаблона загрузочного диска. | string | ubuntu-minimal-2204-jammy-v20240229 | Список доступных образов загрузочных дисков можно получить командой `./gcloud compute images list --filter="family:<os name>"`. |
| `user` | Имя пользователя для подключения по SSH. | string | ubuntu ||
| `ssh_key_pub_path` | Путь к публичному SSH ключу, который будет загружен на сервер. | string | <path to SSH pub key> | Сгенерировать пару SSH ключей можно командой `ssh keygen`. |
| `domain` | Имя домена DNS приватной зоны. | string | ydb-cluster.com. ||  
