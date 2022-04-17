import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:product_catalog_app/models/product_model.dart';
import 'package:product_catalog_app/services/ProductService.dart';
import 'package:product_catalog_app/utils/app_url.dart';
import 'package:product_catalog_app/utils/shared_preferences.dart';

class ProductService extends MyProductServices {
  String? userToken;

  @override
  Future<List<ProductModel>> fetchAllProduct() async {
    // final response = await dio.get(AppUrl.productAll);
    await UserPreferences.getUserToken().then((value) => userToken = value!);

    var result;

    Response response = await http.get(
      Uri.parse(AppUrl.productAll),
      headers: {
        'Content-Type': 'application/json',
        'access-token': userToken!,
      },
    );

    debugPrint("product body: ${response.body.toString()}");

    debugPrint("product status code : ${response.statusCode}");

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);

      final Map<String, dynamic> responseData = json.decode(response.body);

      print('response product data $responseData');

      var productData = responseData;
      //  ProductModel myProduct = ProductModel.fromJson(productData[0]);
      //print("my product : $myProduct");

      result = jsonResponse.map((v) => new ProductModel.fromJson(v)).toList();
      // result = {'status': true, 'message': 'Successful', 'product': myProduct};
    } else {
      result = {
        'status': false,
        'message': json.decode(response.body)['error']
      };
    }

    return result;
  }
}
