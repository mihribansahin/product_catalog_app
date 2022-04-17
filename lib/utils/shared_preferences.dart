import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_model.dart';

class UserPreferences {

  static setUserMail(String userMail) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("email", userMail);
  }
  static Future<String?> getUserMail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? usernameOrMail = prefs.getString('email');
    return usernameOrMail;
  }
  static setUserPassword(String password) async {
    SharedPreferences  prefs = await SharedPreferences.getInstance();
    prefs.setString("password", password);
  }
  static Future<String?> getPassword() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? password = prefs.getString('password');
    return password;
  }
 static setUserToken(String userToken) async {
    SharedPreferences  prefs = await SharedPreferences.getInstance();
    prefs.setString("userToken", userToken);
  }
  static Future<String?> getUserToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userToken = prefs.getString('userToken');
    return userToken;
  }

  static setUsername(String username) async {
    SharedPreferences  prefs = await SharedPreferences.getInstance();
    prefs.setString("name", username);
  }
  static Future<String?> getUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? username = prefs.getString('name');
    return username;
  }

  static setRememberMe(bool isRemember) async {
    SharedPreferences  prefs = await SharedPreferences.getInstance();
    prefs.setBool("isRemember", isRemember);
  }
  static Future<bool?> getRememberMe() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isRemember = prefs.getBool('isRemember');
    return isRemember;
  }



  /*Future<bool> saveUser(User user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setDouble('userId', user.userId!);
    await prefs.setString('name', user.name!);
    await prefs.setString('email', user.email!);
    await prefs.setString('phone', user.phone!);
    await prefs.setString('password', user.password!);

    await prefs.setString('token', user.token!);

    return prefs.commit();
  }

  Future<User> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    //double userId = prefs.getDouble("userId")!;
    String name = prefs.getString("name")!;
    String email = prefs.getString("email")!;
    String password = prefs.getString("password")!;

    String phone = prefs.getString("phone")!;
    String token = prefs.getString("token")!;

    return User(
      // userId: userId,
      name: name,
      email: email,
      phone: phone,
      token: token,
      password: password,
    );
  }*/

  void removeUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.remove('userId');
    prefs.remove('name');
    prefs.remove('email');
    prefs.remove('phone');
    prefs.remove('password');

    prefs.remove('token');
  }

  Future<String> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token")!;
    return token;
  }
}
