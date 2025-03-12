import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Импортируем shared_preferences
import '../constants/constants.dart'; // Импортируем константы

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String greeting = 'Привет'; // По умолчанию "Привет"

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _checkUserRegistrationStatus(); // Проверяем статус регистрации при запуске
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // Функция для сохранения состояния регистрации
  Future<void> setUserRegistered(bool isRegistered) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isRegistered', isRegistered);
  }

  // Функция для проверки, был ли пользователь зарегистрирован
  Future<bool> isUserRegistered() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isRegistered') ?? false;
  }

  // Проверяем, был ли пользователь зарегистрирован
  Future<void> _checkUserRegistrationStatus() async {
    final isRegistered = await isUserRegistered();
    if (isRegistered) {
      setState(() {
        greeting = 'С возвращением'; // Меняем приветствие
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkGraphite, // Используем темный графит как цвет фона
      appBar: AppBar(
        title: Text(
          greeting, // Используем переменную greeting
          style: TextStyle(
            color: textColor, // Цвет текста
            fontFamily: 'Marmelad-Regular', // Название шрифта
            fontStyle: FontStyle.italic, // Курсивное начертание
          ),
        ),
        backgroundColor: myColor, // Используем основной цвет для AppBar
        centerTitle: true, // Центрирование заголовка
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Вход'), // Вкладка для авторизации
            Tab(text: 'Регистрация'), // Вкладка для регистрации
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Содержимое вкладки "Вход"
          _buildLoginTab(),
          // Содержимое вкладки "Регистрация"
          _buildRegistrationTab(),
        ],
      ),
    );
  }

  // Виджет для вкладки "Вход"
  Widget _buildLoginTab() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              labelText: 'Email',
              labelStyle: TextStyle(color: textColor), // Цвет текста
            ),
          ),
          const SizedBox(height: 16.0),
          TextField(
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'Пароль',
              labelStyle: TextStyle(color: textColor), // Цвет текста
            ),
          ),
          const SizedBox(height: 24.0),
          ElevatedButton(
            onPressed: () async {
              // Действие при нажатии на кнопку авторизации
              final isRegistered = await isUserRegistered();
              if (isRegistered) {
                setState(() {
                  greeting = 'С возвращением'; // Меняем приветствие
                });
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: myColor, // Используем основной цвет
            ),
            child: Text(
              'Войти',
              style: TextStyle(color: textColor), // Цвет текста
            ),
          ),
        ],
      ),
    );
  }

  // Виджет для вкладки "Регистрация"
  Widget _buildRegistrationTab() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              labelText: 'Имя',
              labelStyle: TextStyle(color: textColor), // Цвет текста
            ),
          ),
          const SizedBox(height: 16.0),
          TextField(
            decoration: InputDecoration(
              labelText: 'Email',
              labelStyle: TextStyle(color: textColor), // Цвет текста
            ),
          ),
          const SizedBox(height: 16.0),
          TextField(
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'Пароль',
              labelStyle: TextStyle(color: textColor), // Цвет текста
            ),
          ),
          const SizedBox(height: 24.0),
          ElevatedButton(
            onPressed: () async {
              // Действие при нажатии на кнопку регистрации
              await setUserRegistered(true); // Сохраняем флаг регистрации
              setState(() {
                greeting = 'С возвращением'; // Меняем приветствие
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: myColor, // Используем основной цвет
            ),
            child: Text(
              'Зарегистрироваться',
              style: TextStyle(color: textColor), // Цвет текста
            ),
          ),
        ],
      ),
    );
  }
}
