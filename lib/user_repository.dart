import 'package:shared_preferences/shared_preferences.dart';

class UserRepository {
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
}