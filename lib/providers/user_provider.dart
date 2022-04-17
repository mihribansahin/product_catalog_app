import 'package:flutter/cupertino.dart';
import 'package:product_catalog_app/models/user_model.dart';

class UserProvider extends ChangeNotifier{

  User _user = User();

  User get user => _user;

  void setUser (User user){
    _user = user;
    notifyListeners();
  }
}