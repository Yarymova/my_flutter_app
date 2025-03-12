import 'package:flutter/material.dart';
import 'screens/auth_screen.dart'; // Импортируем экран авторизации
import 'constants/constants.dart'; // Импортируем константы

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Автоматический переход через 5 секунд
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              const AuthScreen(), // Переход на экран авторизации
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkGraphite, // Используем темный графит как цвет фона
      body: Stack(
        children: [
          // Фото заставка
          SizedBox.expand(
            child: Image.asset(
              'assets/images/5267235368422467596.jpg', // Путь к фото заставке
              fit: BoxFit.cover,
            ),
          ),

          // Затемнение фона
          Container(
            color: Colors.black
                .withOpacity(0.5), // Затемнение для лучшей читаемости текста
            child: Center(
              child: Text(
                'Еда',
                style: TextStyle(
                  fontFamily: 'GreatVibes-Regular',
                  fontSize: 80,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                  color: textColor, // Используем цвет текста
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
