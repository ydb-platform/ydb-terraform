# Создание инфраструктуры в Yandex Cloud для развертывания YDB кластера

Для реализации данного Terraform сценария понадобится: активный платежный аккаунт в Yandex Cloud, достаточное количество средства для запуска 9 виртуальных машин, [Yandex CLI](https://cloud.yandex.ru/ru/docs/cli/quickstart), подготовленные SSH-ключи.

Для создания инфраструктуры в Yandex Cloud с помощью Terraform нужно:

1. Подготовить облако к работе:
    * [Зарегистрироваться](https://console.yandex.cloud) в Yandex Cloud.
    * [Подключить](https://cloud.yandex/ru/docs/billing/concepts/billing-account) платежный аккаунт.
    * [Убедится](https://billing.yandex.cloud/) в наличии достаточного количества средств для создания девяти ВМ.
2. Установить и настроить Yandex Cloud CLI:
    * [Скачать](https://cloud.yandex/ru/docs/cli/quickstart) Yandex Cloud CLI.
    * [Создать](https://cloud.yandex/ru/docs/cli/quickstart#initialize) профиль
3. [Создать](https://cloud.yandex/ru/docs/tutorials/infrastructure-management/terraform-quickstart#get-credentials) сервисный аккаунт с помощью CLI.
4. [Сгенерировать](https://cloud.yandex/ru/docs/cli/operations/authentication/service-account#auth-as-sa) авторизованный ключ в JSON формате для подключения Terraform к облаку с помощью CLI: `yc iam key create --service-account-name <acc name> --output <file name> --folder-id <cloud folder id>`. В терминал будет выведена информация о созданном ключе:
    ```
    id: ajenap572v8e1l...
    service_account_id: aje90em65r69...
    created_at: "2024-09-03T15:34:57.495126296Z"
    key_algorithm: RSA_2048
    ```
    Авторизованный ключ будет создан в директории, где вызывалась команда.
5. [Настроить](https://cloud.yandex/ru/docs/tutorials/infrastructure-management/terraform-quickstart#configure-provider) Yandex Cloud Terraform провайдера.
6. Скачать данный репозиторий командой `git clone https://github.com/ydb-platform/ydb-terraform.git`.
7. Перейти в директорию `yandex_cloud` (директория в скаченном репозитории) и внести изменения в следующие переменные, в файле `variables.tf`:
    * `key_path` – путь к сгенерированному авторизованному ключу с помощью CLI.
    * `cloud_id` – ID облака. Можно получить список доступных облаков командой `yc resource-manager cloud list`.
    * `folder_id` – ID Cloud folder. Можно получить командой `yc resource-manager folder list`.

Теперь, находясь в поддиректории `yandex_cloud`, можно выполнить последовательность следующих команд для установки провайдера, инициализации модулей и создания инфраструктуры:

1. `terraform init` – установка провайдера и инициализация модулей.
2. `terraform plan` – создание плана будущей инфраструктуры.
3. `terraform apply` (повторное выполнение) – создание ресурсов в облаке.

Далее используются команды `terraform plan`, `terraform apply` и `terraform destroy` (уничтожение созданной инфраструктуры).

## Значения переменных 

Глобальные переменные проекта, содержащие данные для аутентификации, конфигурации виртуальных серверов,  находятся в корневом `variables.tf`, а локальные переменные модулей находятся в `variables.tf`, в каждом модуле. Переменные корневого файла `variables.tf`:

| Название переменной | Описание | Тип | Дефолтное значение | Примечание |
|---------------------|----------|-----|--------------------| ---------- |
| `key_path` | Путь до SA ключа в JSON формате. | string | "./prod.json" | Создать SA ключ можно с помощью CLI командой `yc iam key create \ --service-account-id < service acc ID > \ --folder-name <folder cloud name> \ --output key.json`. |
| `cloud_id` | ID облака. | string | `<yandex cloud ID >` | Можно получить список доступных облаков командой `yc resource-manager cloud list`.|
| `folder_id` | ID папки в Yandex Cloud. | string | `<yandex cloud folder ID>` | ID папки Yandex Cloud можно получить командой `yc resource-manager folder list`. |
| `vm_count` | Количество ВМ, которое будет создано в облаке. | number | 9 | Минимальное количество ВМ для создания YDB кластера – 8 ВМ. |
| `static_node_disk_per_vm` | Количество подключаемых дисков к ВМ. | 1 | |
| `vps_platform` | Тип платформы виртуализации. | string | `standard-v3` | standard-v1 – Intel Broadwell, -v2 – Intel Cascade Lake, -v3 – Intel Ice Lake. |
| `static_node_attached_disk_name` | Название подключаемого к ВМ диска. | string | "ydb-data-disk" | |
| `user` | Пользователь для подключения по SSH. | string | "ubuntu" | |
| `ssh_key_pub_path` | Путь к публичной части SSH-ключа. | string | "<path to SSH pub>" | Создать пару SSH-ключей можно командой `ssh keygen`.|
| `zone_name` | Зоны доступности Yandex Cloud. | list | ["ru-central1-a", "ru-central1-b", "ru-central1-d"] | Список зон доступности не содержит ru-central1-c зоны – она выводится из эксплуатации. | 
| `domain` | Имя доменной DNS зоны. | string | "ydb-cluster.com." | Имя доменной зоны всегда должно заканчиваться точкой. |   

