# Создание инфраструктуры в Google Cloud Platform для развертывания YDB кластера

Для реализации данного Terraform сценария понадобится: Google Cloud Platform (GCP) аккаунт, активный платежный аккаунт, достаточное количество средства для запуска 9 виртуальных машин, подготовленные SSH-ключи.

1. Зарегистрируйтесь в Google Cloud console.
2. [Создайте](https://console.cloud.google.com/projectselector2/home) проект.
3. Скачайте и установите GCP CLI, следуя [этой](https://cloud.google.com/sdk/docs/install) инструкции.
4. Перейдите в в поддиректорию `.../google-cloud-sdk/bin` и выполните команду `./gcloud auth application-default login`.
5. 