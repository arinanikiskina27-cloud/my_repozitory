workspace "Bookstore Management System" "Система управления деятельностью книжного магазина" {

    model {
        // Акторы (внешние пользователи)
        customer = person "Покупатель" "Использует систему для поиска, выбора и оформления заказа на книги, получения информации о наличии товаров и акциях"
        salesConsultant = person "Продавец-консультант" "Вводит информацию о продажах, консультирует клиентов и управляет кассовыми операциями"
        storeAdministrator = person "Администратор магазина" "Контролирует работу системы, формирует отчеты, управляет ассортиментом и складскими запасами"
        supplier = person "Поставщик" "Взаимодействует с системой для обновления данных о поставках и статуса заказов"
        accountant = person "Бухгалтер" "Использует систему для учета финансовых операций и формирования налоговой отчетности"

        // Основная система с контейнерами
        bookstoreSystem = softwareSystem "Bookstore Management System" "Система управления деятельностью книжного магазина" {
            webApp = container "Web App" "Веб-приложение для взаимодействия с пользователями" "React/Vue.js" "Web Browser"
            backendAPI = container "Backend API" "API для управления бизнес-логикой" "Spring Boot/Java"
            database = container "База данных" "Хранение данных" "PostgreSQL" "Database"
            messageBroker = container "Message Broker" "Обрабатывает очереди оплаты и внутренние сообщения между сотрудниками" "RabbitMQ" "Message Broker"
        }

        // Внешние системы и интерфейсы
        warehouseSystem = softwareSystem "Складская система учета" "Обеспечивает актуальные данные о запасах и движении товаров" "External"
        paymentSystem = softwareSystem "Платежные системы" "Позволяют обрабатывать электронные платежи и проводить финансовые транзакции" "External"
        onlineStore = softwareSystem "Интернет-магазин" "Интегрирован с системой для обработки онлайн-заказов и синхронизации остатков" "External"
        reportingSystem = softwareSystem "Системы отчетности и налогового учета" "Автоматизируют передачу необходимой документации в государственные органы" "External"
        logisticsService = softwareSystem "Службы логистики и доставки" "Координируют доставку заказанных товаров покупателям" "External"

        // Связи акторов с контейнерами
        customer -> webApp "Поиск, выбор и оформление заказов; получение информации о товарах и акциях"
        salesConsultant -> webApp "Ввод информации о продажах; консультирование клиентов; управление кассой"
        storeAdministrator -> webApp "Контроль работы; формирование отчетов; управление ассортиментом и запасами"
        supplier -> webApp "Обновление данных о поставках и статусе заказов"
        accountant -> webApp "Учет финансовых операций; формирование налоговой отчетности"

        // Связи контейнеров внутри системы
        webApp -> backendAPI "Вызывает API для обработки запросов"
        backendAPI -> database "Читает/пишет данные"
        backendAPI -> messageBroker "Отправляет/получает сообщения очередей оплаты"
        messageBroker -> backendAPI "Обрабатывает асинхронные задачи оплаты"

        // Связи сотрудников с брокером для внутренних сообщений
        salesConsultant -> messageBroker "Отправляет/получает внутренние сообщения (например, уведомления о заказах)"
        storeAdministrator -> messageBroker "Отправляет/получает внутренние сообщения (например, отчеты и обновления)"
        accountant -> messageBroker "Отправляет/получает внутренние сообщения (например, финансовые уведомления)"

        // Связи системы с внешними системами (через контейнеры)
        backendAPI -> warehouseSystem "Получение данных о запасах и движении товаров"
        backendAPI -> paymentSystem "Обработка платежей и транзакций"
        backendAPI -> onlineStore "Обработка онлайн-заказов и синхронизация остатков"
        backendAPI -> reportingSystem "Передача документации для отчетности и налогов"
        backendAPI -> logisticsService "Координация доставки товаров"
    }

    views {
        // Диаграмма контейнеров
        container bookstoreSystem "Containers" {
            include *
            autoLayout lr 900 200
        }

        // Стили для диаграмм
        styles {
            element "Person" {
                background #08427b
                color #ffffff
                shape Person
            }
            element "Software System" {
                background #1168bd
                color #ffffff
            }
            element "Container" {
                background #438dd5
                color #ffffff
            }
            element "Database" {
                shape Cylinder
            }
            element "Message Broker" {
                shape Pipe
                background #ffcc00
                color #000000
            }
            element "External" {
                background #999999
                color #ffffff
            }
        }
    }
}
