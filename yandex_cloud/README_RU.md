# Создание инфраструктуры в Yandex Cloud для развертывания YDB кластера

Для реализации данного Terraform сценария понадобится: активный платежный аккаунт в Yandex Cloud, достаточное количество средства для запуска 9 виртуальных машин, [Yandex CLI](https://cloud.yandex.ru/ru/docs/cli/quickstart), [AWS CLI](https://aws.amazon.com/ru/cli/), подготовленные SSH-ключи.

Для создания инфраструктуры в Yandex Cloud с помощью Terraform нужно: 
1. Подготовить облако к работе:
    * [Зарегистрироваться](https://console.cloud.yandex.ru/) в Yandex Cloud.
    * [Подключить](https://cloud.yandex.com/ru/docs/billing/concepts/billing-account) платежный аккаунт. 
    * [Убедится](https://console.cloud.yandex.ru/billing) в наличии достаточного количества средств для создания девяти ВМ.
2. Установить и настроить Yandex Cloud CLI:
    * [Скачать](https://cloud.yandex.ru/ru/docs/cli/quickstart) Yandex Cloud CLI.
    * [Создать](https://cloud.yandex.ru/ru/docs/cli/quickstart#initialize) профиль 
3. [Создать](https://cloud.yandex.com/ru/docs/tutorials/infrastructure-management/terraform-quickstart#get-credentials) сервисный аккаунт с помощью CLI.
4. [Сгенерировать](https://cloud.yandex.ru/ru/docs/cli/operations/authentication/service-account#auth-as-sa) SA ключ в JSON формате для подключения Terraform к облаку с помощью CLI: `yc iam key create --service-account-name <acc name> --output <file name> --folder-id <cloud folder id>`. Будет сгенерирован SA ключ, а в терминал будет выведена секретная информация:
    ```
    access_key:
        id: ajenhnhaqgd3vp...
        service_account_id: aje90em65r6922...
        created_at: "2024-03-05T20:10:50.0150..."
        key_id: YCAJElaLsa0z3snzH4E...
    secret: YCPKNJDVhRZgyywl4hQwVdcSRC...
    ```
    Скопируйте `access_key.id` и `secret`. Значения этих полей нужны будут в дальнейшем при работе с AWS CLI.
5. [Скачать](https://aws.amazon.com/ru/cli/) AWS CLI.
6. Настроить окружение AWS CLI: 
    * Запустите команду `aws configure` и последовательно введите сохраненные ранее `access_key.id` и `secret`. Для значения региона используйте `ru-central1`:
    ```
    aws configure
    AWS Access Key ID [None]: AKIAIOSFODNN********
    AWS Secret Access Key [None]: wJalr********/*******/bPxRfiCYEX********
    Default region name [None]: ru-central1
    Default output format [None]:
    ```
    Будут созданы файлы `~/.aws/credentials` и `~/.aws/config`. 
7. Отредактировать `~/.aws/credentials` и `~/.aws/config` следующим образом:
    * Добавьте `[Ya_def_reg]` в `~/.aws/config` перед `region = ru-central1-a`.
    * Добавьте `[Yandex]` перед секретной информацией о ключах подключения.
8. Добавить в файл `~/.terraformrc` (если файла нет – создать его) следующий блок:
    ```
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
9. [Настроить](https://cloud.yandex.com/ru/docs/tutorials/infrastructure-management/terraform-quickstart#configure-provider) Yandex Cloud Terraform провайдера.
10. Скачать данный репозиторий командой `git clone https://github.com/ydb-platform/ydb-terraform.git`.
11. Перейти в директорию `yandex_cloud` (директория в скаченном репозитории) и внести изменения в следующие переменные, в файле `variables.tf`:
    * `key_path` – путь к сгенерированному SA ключу с помощью CLI.
    * `cloud_id` – ID облака. Можно получить список доступных облаков командой `yc resource-manager cloud list`.
    * `profile` – название профиля из файла `~/.aws/config`.
    * `folder_id` – ID Cloud folder. Можно получить командой `yc resource-manager folder list`.

Теперь, находясь в директории `yandex_cloud`, можно выполните команду `terraform init` для установки провайдера и инициализации модулей. Далее нужно выполнить серию команд:
* `terraform plan` – создание плана будущей инфраструктуры.
* `terraform init` (повторный вызов) – создание ресурсов в облаке.

## Значения переменных 

Глобальные переменные проекта, содержащие данные для аутентификации, конфигурации виртуальных серверов,  находятся в корневом `variables.tf`, а локальные переменные модулей находятся в `variables.tf`, в каждом модуле. Переменные корневого файла `variables.tf`:

| Название переменной | Описание | Тип | Дефолтное значение | Примечание |
|---------------------|----------|-----|--------------------| ---------- |
| `key_path` | Путь до SA ключа в JSON формате. | string | "./prod.json" | Создать SA ключ можно с помощью CLI командой `yc iam key create \ --service-account-id < service acc ID > \ --folder-name <folder cloud name> \ --output key.json`. |
| `cloud_id` | ID облака. | string | `<yandex cloud ID >` | Можно получить список доступных облаков командой `yc resource-manager cloud list`.|
| `profile` | Имя профиля безопасности из файла `~/.aws/credentials`. | string | "Yandex" | Если в файле `~/.aws/credentials` нет профилей безопасности, то его следует создать – добавить строку `[Yandex]` перед `aws_access_key_id` и `aws_secret_access_key`. |
| `folder_id` | ID папки в Yandex Cloud. | string | `<yandex cloud folder ID>` | ID папки Yandex Cloud можно получить командой `yc resource-manager folder list`. |
| `vm_count` | Количество ВМ, которое будет создано в облаке. | number | 9 | Минимальное количество ВМ для создания YDB кластера – 8 ВМ. |
| `static_node_disk_per_vm` | Количество подключаемых дисков к ВМ. | 1 | |
| `vps_platform` | Тип платформы виртуализации. | string | `standard-v3` | standard-v1 – Intel Broadwell, -v2 – Intel Cascade Lake, -v3 – Intel Ice Lake. |
| `static_node_attached_disk_name` | Название подключаемого к ВМ диска. | string | "ydb-data-disk" | |
| `user` | Пользователь для подключения по SSH. | string | "ubuntu" | |
| `ssh_key_pub_path` | Путь к публичной части SSH-ключа. | string | "<path to SSH pub>" | Создать пару SSH-ключей можно командой `ssh keygen`.|
| `zone_name` | Зоны доступности Yandex Cloud. | list | ["ru-central1-a", "ru-central1-b", "ru-central1-d"] | Список зон доступности не содержит ru-central1-c зоны – она выводится из эксплуатации. | 
| `domain` | Имя доменной DNS зоны. | string | "ydb-cluster.com." | Имя доменной зоны всегда должно заканчиваться точкой. |   

