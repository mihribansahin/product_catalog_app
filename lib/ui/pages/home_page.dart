import 'package:flutter/material.dart';
import 'package:product_catalog_app/utils/constants/my_colors.dart';
import 'package:provider/provider.dart';

import '../widgets/card_item.dart';
import 'login_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    // final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white, actions: [
        ActionChip(
            shadowColor: MyColors.myPink,
            backgroundColor: Colors.yellow,
            label: Text("(8)"),
            avatar: Icon(Icons.stars),
            onPressed: () {})
      ]),
      body: tempBuildBody(),
    );
  }

  Widget tempBuildBody() {
    return GridView.builder(
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (context, index) {
        return Text("mihri");
      },
    );
  }


}
