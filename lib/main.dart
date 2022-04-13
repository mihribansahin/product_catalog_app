import 'package:flutter/material.dart';
import 'package:product_catalog_app/ui/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Product Catalog App',
      theme: ThemeData(
  
        primarySwatch: Colors.blue,
      ),
      home: HomePage()
    );
  }
}
