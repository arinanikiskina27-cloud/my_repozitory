workspace "Bookstore Management System" "Система управления деятельностью книжного магазина" {

    model {
        // Акторы (внешние пользователи)
        customer = person "Покупатель" "Использует систему для поиска, выбора и оформления заказа на книги, получения информации о наличии товаров и акциях"
        salesConsultant = person "Продавец-консультант" "Вводит информацию о продажах, консультирует клиентов и управляет кассовыми операциями"
        storeAdministrator = person "Администратор магазина" "Контролирует работу магазина, формирует отчеты, управляет ассортиментом и складскими запасами"
        supplier = person "Поставщик" "Взаимодействует с системой для обновления данных о поставках и статуса заказов"
        accountant = person "Бухгалтер" "Использует систему для учета финансовых операций и формирования налоговой отчетности"

        // Основная система
        bookstoreSystem = softwareSystem "Bookstore Management System" "Система управления деятельностью книжного магазина"

        // Внешние системы и интерфейсы
        warehouseSystem = softwareSystem "Складская система учета" "Обеспечивает актуальные данные о запасах и движении товаров" "External"
        paymentSystem = softwareSystem "Платежные системы" "Позволяют обрабатывать электронные платежи и проводить финансовые транзакции" "External"
        reportingSystem = softwareSystem "Системы отчетности и налогового учета" "Автоматизируют передачу необходимой документации в государственные органы" "External"
        logisticsService = softwareSystem "Службы логистики и доставки" "Координируют доставку заказанных товаров покупателям" "External"
        onlineStore = softwareSystem "Интернет-магазин" "Интегрирован с системой для обработки онлайн-заказов и синхронизации остатков" "External"

        // Связи акторов с системой
        customer -> bookstoreSystem "Поиск, выбор и оформление заказов; получение информации о товарах и акциях"
        salesConsultant -> bookstoreSystem "Ввод информации о продажах; консультирование клиентов; управление кассой"
        storeAdministrator -> bookstoreSystem "Контроль работы; формирование отчетов; управление ассортиментом и запасами"
        supplier -> bookstoreSystem "Обновление данных о поставках и статусе заказов"
        accountant -> bookstoreSystem "Учет финансовых операций; формирование налоговой отчетности"

        // Связи системы с внешними системами
        bookstoreSystem -> warehouseSystem "Получение данных о запасах и движении товаров"
        bookstoreSystem -> paymentSystem "Обработка платежей и транзакций"
        bookstoreSystem -> reportingSystem "Передача документации для отчетности и налогов"
        bookstoreSystem -> logisticsService "Координация доставки товаров"
        bookstoreSystem -> onlineStore "Обработка онлайн-заказов и синхронизация остатков"
    }

    views {
        // Диаграмма системного контекста
        systemContext bookstoreSystem "SystemContext" {
            include *
            autoLayout lr 1000 200
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
            element "External" {
                background #999999
                color #ffffff
            }
        }
    }
}
