import 'dart:convert';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:product_catalog_app/models/product_model.dart';
import 'package:product_catalog_app/services/like_service.dart';
import 'package:product_catalog_app/ui/pages/product_detail_page.dart';
import 'package:product_catalog_app/utils/app_url.dart';
import 'package:product_catalog_app/utils/constants/my_colors.dart';

import '../../utils/shared_preferences.dart';

class ProductPage extends StatefulWidget {
  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  String? userToken;
  int _index = 0;
  bool isFavorite = false;

  Map<int, bool>? myFavoriteMap = {};

  ProductModel? productModel;

  Future<dynamic> getProductList() async {
    await UserPreferences.getUserToken().then((value) => userToken = value!);

    Response response = await http.get(
      Uri.parse(AppUrl.productAll),
      headers: {
        'Content-Type': 'application/json',
        'access-token': userToken!,
      },
    );
    var jsonResponse = json.decode(response.body);

    var data = jsonResponse['products'];

    data.map((product) => productModel = productModel);
    return data.map((products) => new ProductModel.fromJson(products)).toList();
  }

  @override
  @override
  Widget build(BuildContext context) {
    print("my favorite list :$myFavoriteMap");
    return Scaffold(
      backgroundColor: Colors.white,
      body: myFutureBuilder(),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  FutureBuilder<dynamic> myFutureBuilder() {
    return FutureBuilder<dynamic>(
      future: getProductList(),
      builder: (context, snapshot) {
        print("snapshot");
        print(snapshot.data);
        if (snapshot.hasData) {
          return Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 120.0, horizontal: 0),
              child: myPageView(snapshot, context));
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  PageView myPageView(AsyncSnapshot<dynamic> snapshot, BuildContext context) {
    return PageView.builder(
      itemCount: snapshot.data!.length,
      onPageChanged: (int index) => setState(() => _index = index),
      controller: PageController(viewportFraction: 0.7),
      itemBuilder: (_, i) {
        return Transform.scale(
          scale: i == _index ? 1 : 0.8,
          child: InkWell(
            hoverColor: Colors.transparent,
            onTap: () {
              print("clicked product id :${snapshot.data[i].id}");

              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ProductDetailPage(
                        product: snapshot.data![i],
                        myMap: myFavoriteMap!,
                        userToken: userToken!)),
              );
            },
            child: Card(
              shape: RoundedRectangleBorder(
                side: const BorderSide(
                    color: MyColors.enabledBorderColor, width: 1),
                borderRadius: BorderRadius.circular(40),
              ),
              elevation: 3,
              child: Stack(
                children: [
                  Column(
                    children: <Widget>[
                      Expanded(
                          child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(40),
                                  topRight: Radius.circular(40)),
                              child: Container(
                                width: 300,
                                child: Image.network(
                                  'https://i.pinimg.com/564x/06/4d/1c/064d1c6660ff9750f5bfaf77fd5b0902.jpg',
                                  loadingBuilder: (BuildContext context,
                                      Widget child,
                                      ImageChunkEvent? loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return Center(
                                      child: CircularProgressIndicator(
                                        value: loadingProgress
                                                    .expectedTotalBytes !=
                                                null
                                            ? loadingProgress
                                                    .cumulativeBytesLoaded /
                                                loadingProgress
                                                    .expectedTotalBytes!
                                            : null,
                                      ),
                                    );
                                  },
                                  fit: BoxFit.fill,
                                ),
                              ))),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          snapshot.data[i].name,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 16,
                              letterSpacing: 1,
                              wordSpacing: 2,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(20),
                        child: Text(
                          '${snapshot.data[i].price.toString()} \$',
                          style: const TextStyle(
                              fontSize: 27,
                              letterSpacing: 1,
                              wordSpacing: 2,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    right: -15,
                    top: 5,
                    child: RawMaterialButton(
                        splashColor: Colors.transparent,
                        onPressed: () {
                          isFavorite = !isFavorite;
                          if (isFavorite) {
                            LikeService.likeProduct(
                              context,
                              myFavoriteMap!,
                              snapshot.data![i].id,
                              userToken!,
                            );
                          } else if (!isFavorite) {
                            LikeService.unlikeProduct(
                              context,
                              snapshot.data![i].id,
                              myFavoriteMap!,
                              userToken!,
                            );
                          }

                          setState(() {});
                        },
                        child: Icon(
                          LikeService.getFavoriteControl(
                                  snapshot.data![i].id, myFavoriteMap!)
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: Colors.yellow,
                          size: 30,
                        )
                        //onPressed: ()=> cartBloc.addProductToCartCart(_productItem),
                        ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
