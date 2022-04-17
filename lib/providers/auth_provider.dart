// ignore_for_file: constant_identifier_names

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:product_catalog_app/models/user_model.dart';
import 'package:product_catalog_app/utils/app_url.dart';
import 'package:product_catalog_app/utils/shared_preferences.dart';
import 'package:http/http.dart' as http;

enum Status {
  // ignore: constant_identifier_names
  NotLoggedIn,
  NotRegistered,
  LoggedIn,
  Registered,
  Authenticating,
  Registering,
  LoggedOut
}

class AuthProvider extends ChangeNotifier {
  Status _loggedInStatus = Status.NotLoggedIn;
  Status _registeredInStatus = Status.NotRegistered;

  Status get loggedInStatus => _loggedInStatus;

  set loggedInStatus(Status value) {
    _loggedInStatus = value;
  }

  Status get registeredInStatus => _registeredInStatus;

  set registeredInStatus(Status value) {
    _registeredInStatus = value;
  }

  Future<dynamic> register(String name, String email, String password) async {
    final Map<String, dynamic> apiBodyData = {
      'name': name,
      'email': email,
      'password': password
    };

    return await http
        .post(Uri.parse(AppUrl.register),
            body: json.encode(apiBodyData),
            headers: {'Content-Type': 'application/json'})
        .then(onValue)
        .catchError(onError);
  }

  notify() {
    notifyListeners();
  }

  static Future<FutureOr> onValue(Response response) async {
    var result;
    final Map<String, dynamic> responseData = json.decode(response.body);

    print('register responseData:  $responseData');
    debugPrint("register body: ${response.body.toString()}");

    debugPrint("register status code : ${response.statusCode}");

    if (response.statusCode == 200) {
      var userData = responseData['token'];

      User authUser = User.fromJson(responseData);
     // await UserPreferences.setUserMail(authUser.email!);
      //await UserPreferences.setUserPassword(authUser.password!);
      await UserPreferences.setUserToken(authUser.token!);

      result = {
        'status': true,
        'message': 'Successfully registered',
        'data': authUser
      };
    } else {
      result = {
        'status': false,
        'message': 'Successfully registered',
        'data': responseData
      };
    }
    return result;
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    var result;

    final Map<String, dynamic> loginData = {
      'email': email,
      'password': password
    };

    _loggedInStatus = Status.Authenticating;
    notifyListeners();

    Response response = await http.post(
      Uri.parse(AppUrl.login),
      body: json.encode(loginData),
      headers: {
        'Content-Type': 'application/json',
      },
    );
    debugPrint("body: ${response.body.toString()}");

    debugPrint("status code : ${response.statusCode}");

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);

      print('response data $responseData');

      var userData = responseData;

       User authUser = User.fromJson(userData);

     await UserPreferences.setUserToken(authUser.token!);

      await UserPreferences.setUserMail(email);
     await UserPreferences.setUserPassword(password);
     

      _loggedInStatus = Status.LoggedIn;

      notifyListeners();

      result = {'status': true, 'message': 'Successful', 'user': authUser};
    } else {
      _loggedInStatus = Status.NotLoggedIn;
      notifyListeners();
      result = {
        'status': false,
        'message': json.decode(response.body)['error']
      };
    }

    return result;
  }

  static onError(error) {
    print('error  -detail :  ${error}');
    return {'status': false, 'message': 'Unsuccessful Request', 'data': error};
  }
}
