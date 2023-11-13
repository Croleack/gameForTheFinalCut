# gameForTheFinalCut

Проект представляет собой игру из 4 экранов. Навигация - UINavigationController, написано кодом на UIkit(без использование сторонних библиотек), архитектура MVC. Игровое поле, на котором находится персонаж - задача, которого уворачиваться от падающих предметов. При проигрыше есть возможность начать заново. При окончании игры высвечивается время, которое персонаж смог продержаться, эти данные прокидываются в контроллер рекордов, который представляет собой UITableView. Контроллер настроек позволяет менять персонажа и скорость игры, настройки и рекорды сохраняются в UserDefaults. Данные между контроллерами прокидываются через делегаты. Использовался Auto Layout. Добавлена загрузка изображения из памяти телефона или фотокамеры(на симуляторе не доступно).

Вот видео с демонстрацией возможности игры: https://drive.google.com/file/d/1ixCwGGVhJr8XzdmMvN_E6Ad_a5C_rGam/view?usp=sharing




The project is a game of 4 screens. Navigation - UINavigationController, written in UIkit code (without using third-party libraries), MVC architecture. The playing field on which the character is located is the task of which is to dodge falling objects. If you lose, you have the opportunity to start over. When the game ends, the time that the character was able to survive is displayed, this data is transferred to the records controller, which is a UITableView. The settings controller allows you to change the character and game speed, settings and records are saved in UserDefaults. Data between controllers is passed through delegates. The game is adapted for different screens, Auto Layout was used. At the moment, all that remains is to change the color of the obstacle and add an image with the user’s avatar.

Here is a video demonstrating the game's capabilities: https://drive.google.com/file/d/1ixCwGGVhJr8XzdmMvN_E6Ad_a5C_rGam/view?usp=sharing
