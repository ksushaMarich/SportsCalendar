<img width="180" height="390" alt="Simulator Screenshot - Clone 1 of iPhone 12 mini - 2025-12-18 at 19 28 10" src="https://github.com/user-attachments/assets/3d2d80bb-9902-48d0-a11f-ee13eefe0394" />
<img width="180" height="390" alt="Simulator Screenshot - Clone 1 of iPhone 12 mini - 2025-12-18 at 19 40 18" src="https://github.com/user-attachments/assets/6eb68340-b2a9-4b2a-9fa5-278ef823fb81" />
<img width="180" height="390" alt="Simulator Screenshot - Clone 1 of iPhone 12 mini - 2025-12-18 at 19 41 35" src="https://github.com/user-attachments/assets/003bb37a-8b01-4ba9-8961-bef968e39753" />

Требования:  
iOS: 18.6 или выше  
Xcode: 15.4 или выше  

Архитектура:  
Проект построен по паттерну MVVM:  
View — отображает календарь, список тренировок и детали выбранного дня.  
ViewModel — содержит всю логику работы с календарем, фильтрацию тренировок, смену месяцев и форматирование дат.  
Model — структура Workout и сервис MockWorkoutService для получения тренировок.  
Все события календаря фильтруются и подсвечиваются на основе данных ViewModel, что позволяет легко тестировать  
бизнес-логику независимо от UI.  

Покрытие тестами:  
Форматирование даты (formattStartDate)  
Смена месяца (changeMonth)  
Фильтрация тренировок по выбранной дате (getWorkoutsBySelectedDate)  

Особенности:  
Календарь отображает дни недели и корректно выравнивает числа по нужным дням.  
Каждая дата подсвечивается, если на неё есть тренировка.  
LazyVGrid адаптирован под динамическое количество дней и пустые ячейки в начале месяца.  
Все элементы UI адаптированы под светлую и тёмную темы.  
