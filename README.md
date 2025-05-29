#1221SystemTestProject
Я реализовал отображение всех описанных в ТЗ параметров для 5 дней из прогноза погоды. По дефолту прогноз для Москвы. 
Так же добавил поле ввода названия города, использовав его можно получить прогноз для любого другого города.
## 📸 Скриншоты :
![Simulator Screenshot - iPhone 14 Pro - 2025-05-29 at 16 14 09](https://github.com/user-attachments/assets/a7256160-4d35-411d-b1cd-339d5438eb38)
![Simulator Screenshot - iPhone 14 Pro - 2025-05-29 at 16 14 18](https://github.com/user-attachments/assets/0f8c339c-3225-4fd0-a430-bc78ee315f02)
![Simulator Screenshot - iPhone 14 Pro - 2025-05-29 at 16 14 31](https://github.com/user-attachments/assets/d82e4c32-312c-4553-8a2c-0038a20f7579)

## 🛠 Технологии :

1. Язык программирования:  
   - Swift  

2. Фреймворки:  
   - SwiftUI  
   - Foundation 

3. Архитектура:  
   - MVVM (Model-View-ViewModel)  
   - Компоненты:  
     - Views (`WeatherView.swift`)  
     - ViewModels (`WeatherViewModel.swift`)  
     - Models (`WeatherModels.swift`)  
     - Services (`WeatherService.swift`)  

4. Ключевые особенности:  
   - Async/await для асинхронных операций  
   - `@MainActor` для работы в главном потоке  
   - `@Published` свойства для реактивных обновлений  
   - `@StateObject` и `@State` для управления состоянием  

5. Интеграция с внешним API:  
   - WeatherAPI.com (используется REST API)  
   - Аутентификация по API-ключу  

6. UI-компоненты:  
   - NavigationView  
   - List  
   - TextField  
   - Button  
   - AsyncImage  
   - ProgressView  
   - Кастомные вью (WeatherDayRow)  

7. Среда разработки:  
   - Xcode (судя по структуре проекта)  
   - Минимальная версия iOS: 15.0  
   - Поддержка iPhone и iPad (универсальное приложение)  

8. Работа с данными:  
   - Протокол `Codable` для парсинга JSON  
   - `URLSession` для сетевых запросов  
   - Обработка ошибок через кастомный `WeatherError` enum  
