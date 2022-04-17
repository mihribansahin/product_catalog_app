import 'package:flutter/material.dart';
import 'package:product_catalog_app/models/user_model.dart';
import 'package:product_catalog_app/providers/auth_provider.dart';
import 'package:product_catalog_app/providers/user_provider.dart';
import 'package:product_catalog_app/ui/pages/home_page.dart';
import 'package:product_catalog_app/ui/pages/login_page.dart';
import 'package:product_catalog_app/ui/pages/products_page.dart';
import 'package:product_catalog_app/utils/constants/my_colors.dart';
import 'package:product_catalog_app/utils/shared_preferences.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Product Catalog App',
          theme: ThemeData(
            primarySwatch: Palette.myPrimaryColor,
          ),
          // home: LoginPage(),
          home:
              LoginPage() //   Provider.of<UserProvider>(context).setUser(snapshot.data);
          ),
    );
  }
}
