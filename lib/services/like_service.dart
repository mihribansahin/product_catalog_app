import 'dart:convert';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

import '../utils/app_url.dart';
import '../utils/constants/my_colors.dart';

class LikeService {
  static likeProduct(BuildContext context, Map<int, bool> favoriteMap,
      int productId, String userToken) async {
    final Map<String, dynamic> apiBodyData = {
      'productId': productId,
    };

    favoriteMap.addEntries([MapEntry(productId, true)]);

    Response response = await http.post(
      Uri.parse(AppUrl.productLike),
      body: json.encode(apiBodyData),
      headers: {
        'Content-Type': 'application/json',
        'access-token': userToken,
      },
    );

    var jsonResponse = json.decode(response.body);
    print("Like response body:$jsonResponse");
    Flushbar(
      borderRadius: BorderRadius.circular(30),
      backgroundColor: MyColors.myYellow,
      title: "Ürün Favorilere eklendi.",
      titleColor: Colors.black,
      message: "  ",
      duration: Duration(seconds: 1),
    ).show(context);
  }

  static unlikeProduct(BuildContext context, int productId,
      Map<int, bool> favoriteMap, String userToken) async {
    final Map<String, dynamic> apiBodyData = {
      'productId': productId,
    };
// ignore: unrelated_type_equality_checks
    favoriteMap.remove(productId);

    Response response = await http.post(
      Uri.parse(AppUrl.productUnlike),
      body: json.encode(apiBodyData),
      headers: {
        'Content-Type': 'application/json',
        'access-token': userToken,
      },
    );
    Flushbar(
      borderRadius: BorderRadius.circular(30),
      backgroundColor: MyColors.errorBorderColor,
      title: "Ürün Favorilerden Çıkartıldı.",
      titleColor: Colors.black,
      message: "  ",
      duration: Duration(seconds: 1),
    ).show(context);
    var jsonResponse = json.decode(response.body);
    print("Unlike response body:  $productId $jsonResponse");
  }

  static bool getFavoriteControl(int productId, Map<int, bool> myMap) {
    bool myValue = false;
    myMap.forEach((key, value) {
      if (key == productId) {
        myValue = value;
      }
    });
    return myValue;
  }
}
