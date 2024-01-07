# gameForTheFinalCut

Проект представляет собой игру из 4 экранов. Навигация - UINavigationController, написано кодом на UIkit(использовался AVFoundation для добавление музыки), архитектура MVC. Задача персонажа уворачиваться от падающих предметов. При проигрыше есть возможность начать заново. При окончании игры высвечивается время, которое персонаж смог продержаться, эти данные прокидываются в контроллер рекордов, который представляет собой UITableView. Контроллер настроек позволяет менять персонажа и скорость игры, настройки и рекорды сохраняются в UserDefaults. Данные между контроллерами прокидываются через делегаты. Использовался Auto Layout. Добавлена загрузка изображения из памяти телефона или фотокамеры(на симуляторе не доступно).

Вот видео с демонстрацией возможности игры: https://drive.google.com/file/d/1ixCwGGVhJr8XzdmMvN_E6Ad_a5C_rGam/view?usp=sharing

The project is a game of 4 screens. Navigation - UINavigationController, written in UIkit code (without using third-party libraries), MVC architecture. The playing field on which the character is located is the task of which is to dodge falling objects. If you lose, you have the opportunity to start over. When the game ends, the time that the character was able to survive is displayed, this data is transferred to the records controller, which is a UITableView. The settings controller allows you to change the character and game speed, settings and records are saved in UserDefaults. Data between controllers passed through delegates. The game is adapted for different screens, Auto Layout was used. At the moment, all that remains is to change the color of the obstacle and add an image with the user’s avatar.

Here is a video demonstrating the game's capabilities: https://drive.google.com/file/d/1ixCwGGVhJr8XzdmMvN_E6Ad_a5C_rGam/view?usp=sharing

<img width="1097" alt="Снимок экрана 2024-01-07 в 21 57 54" src="https://github.com/Croleack/gameForTheFinalCut/assets/121854191/7362500c-5c15-4f97-918d-8c108786dff8">
<img width="1088" alt="Снимок экрана 2024-01-07 в 21 58 29" src="https://github.com/Croleack/gameForTheFinalCut/assets/121854191/791b3e0f-821e-4310-b2dd-ffb9254ebede">

<img width="1103" alt="Снимок экрана 2024-01-07 в 21 59 12" src="https://github.com/Croleack/gameForTheFinalCut/assets/121854191/a63f3467-cf1d-4729-bc24-d8e00ccf5ae4">
<img width="1036" alt="Снимок экрана 2024-01-07 в 21 59 55" src="https://github.com/Croleack/gameForTheFinalCut/assets/121854191/3ffc66fe-f505-4389-9510-e8dd292efe53">

