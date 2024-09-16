import 'package:movie_mate/data/model/response/user_response_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthLocalDatasource {
  Future<void> saveAuthData(UserResponseModel user);
  Future<void> removeAuthData();
  Future<bool> isLogin();
}

class AuthLocalDatasourceImpl implements AuthLocalDatasource {
  @override
  Future<bool> isLogin() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey('auth_data');
  }

  @override
  Future<void> removeAuthData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_data');
  }

  @override
  Future<void> saveAuthData(UserResponseModel user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_data', user.toJson());
  }
}
