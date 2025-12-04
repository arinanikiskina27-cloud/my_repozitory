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
            backendAPI = container "Backend API" "API для управления бизнес-логикой" "Spring Boot/Java" {
                userService = component "UserService" "Управление регистрацией и аутентификацией пользователей, профилями пользователей и их правами"
                bookService = component "BookService" "Управление каталогом книг: добавление, редактирование, удаление. Поиск и фильтрация книг по различным критериям"
                orderService = component "OrderService" "Обработка заказов: создание, обновление статуса, отмена. Управление корзиной пользователя"
                paymentService = component "PaymentService" "Обработка платежей и интеграция с платёжными системами, управление возвратами и статусами транзакций"
                reviewService = component "ReviewService" "Управление отзывами и рейтингами книг, модерация пользовательских отзывов"
                notificationService = component "NotificationService" "Отправка уведомлений пользователям (email, push-уведомления), управление подписками на уведомления"
            }
            messageBroker = container "Message Broker" "Обрабатывает очереди оплаты и внутренние сообщения между сотрудниками" "RabbitMQ" "Message Broker"
            database = container "База данных" "Хранение данных" "PostgreSQL" "Database"
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
        supplier -> backendAPI "Обновление данных о поставках и статуса заказов"
        accountant -> backendAPI "Учет финансовых операций; формирование налоговой отчетности"

        // Связи контейнеров внутри системы
        webApp -> backendAPI "Вызывает API для обработки запросов"
        backendAPI -> database "Читает/пишет данные"
        backendAPI -> messageBroker "Публикует сообщения для асинхронной обработки"
        messageBroker -> backendAPI "Доставляет сообщения для обработки"

        // Связи компонентов внутри Backend API
        userService -> database "Читает/пишет данные пользователей"
        bookService -> database "Читает/пишет данные книг"
        orderService -> database "Читает/пишет данные заказов"
        paymentService -> database "Читает/пишет данные платежей"
        reviewService -> database "Читает/пишет данные отзывов"
        notificationService -> database "Читает данные подписок"

        // Связи между компонентами (примеры, основанные на логике)
        userService -> notificationService "Отправляет уведомления при регистрации/аутентификации"
        bookService -> notificationService "Отправляет уведомления при изменениях в каталоге"
        orderService -> paymentService "Инициирует платежи"
        orderService -> notificationService "Отправляет уведомления о статусе заказа"
        reviewService -> notificationService "Отправляет уведомления о новых отзывах"

        // Связи с Message Broker
        paymentService -> messageBroker "Отправляет сообщения в очередь оплаты для асинхронной обработки платежей"
        notificationService -> messageBroker "Отправляет внутренние сообщения между сотрудниками (например, уведомления о заказах или изменениях)"
        messageBroker -> paymentService "Доставляет сообщения из очереди оплаты для обработки"
        messageBroker -> notificationService "Доставляет внутренние сообщения для отправки уведомлений сотрудникам"

        // Связи системы с внешними системами (через компоненты)
        paymentService -> paymentSystem "Интегрируется с платёжными системами"
        notificationService -> onlineStore "Отправляет уведомления для синхронизации"
        backendAPI -> warehouseSystem "Получение данных о запасах"
        backendAPI -> reportingSystem "Передача документации"
        backendAPI -> logisticsService "Координация доставки"
    }

    views {
        // Диаграмма компонентов для Backend API
        component backendAPI "Components" {
            include *
            autoLayout lr 600 800  // Увеличено nodeSeparation до 600 для лучшего распределения и избежания наложения надписей
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
            element "Component" {
                background #85bbf0
                color #000000
            }
            element "Database" {
                shape Cylinder
            }
            element "Message Broker" {
                shape Pipe
            }
            element "External" {
                background #999999
                color #ffffff
            }
        }
    }
}
