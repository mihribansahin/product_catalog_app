import 'package:flutter/material.dart';
import 'package:product_catalog_app/models/product_model.dart';
import 'package:product_catalog_app/ui/pages/products_page.dart';
import 'package:product_catalog_app/utils/constants/my_colors.dart';

import '../../services/like_service.dart';

class ProductDetailPage extends StatefulWidget {
  final ProductModel product;
  final Map<int, bool> myMap;
  final String userToken;

  ProductDetailPage(
      {required this.product, required this.myMap, required this.userToken});

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState(product);
}

class _ProductDetailPageState extends State<ProductDetailPage>
    with TickerProviderStateMixin {
  final ProductModel product;
  bool? isFavorite;

  _ProductDetailPageState(this.product);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: myAppBar(context),
      body: Scrollbar(
        trackVisibility: true,
        child: SingleChildScrollView(
          child: detailContent(screenHeight, screenWidth),
        ),
      ),
    );

    //build method
  }

  @override
  void initState() {
    super.initState();

    isFavorite = LikeService.getFavoriteControl(product.id!, widget.myMap);
  }

  Column detailContent(double screenHeight, double screenWidth) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        detailImage(screenHeight, screenWidth),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            product.name!,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.left,
            style: const TextStyle(
                fontSize: 20,
                letterSpacing: 1,
                wordSpacing: 2,
                fontWeight: FontWeight.w800),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Text(
            '${product.price} \$',
            style: const TextStyle(
                fontSize: 27,
                letterSpacing: 1,
                wordSpacing: 2,
                fontWeight: FontWeight.w600),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            'Description',
            style: TextStyle(
                fontSize: 16,
                letterSpacing: 1,
                wordSpacing: 2,
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w600),
          ),
        ),
        productDescription(),
      ],
    );
  }

  Padding productDescription() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Text(
        product.description!,
        overflow: TextOverflow.visible,
        textAlign: TextAlign.left,
        style: TextStyle(
            fontSize: 16,
            letterSpacing: 1,
            wordSpacing: 2,
            color: Colors.grey.shade600,
            fontWeight: FontWeight.w400),
      ),
    );
  }

  Center detailImage(double screenHeight, double screenWidth) {
    return Center(
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(40)),
        child: Container(
          height: screenHeight * .45,
          width: screenWidth * .8,
          child: Image.network(
            'https://i.pinimg.com/564x/06/4d/1c/064d1c6660ff9750f5bfaf77fd5b0902.jpg',
            loadingBuilder: (BuildContext context, Widget child,
                ImageChunkEvent? loadingProgress) {
              if (loadingProgress == null) return child;
              return Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                      : null,
                ),
              );
            },
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }

  AppBar myAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back,
          color: MyColors.myPurple,
          size: 30,
        ),
        onPressed: () {
          // Navigator.of(context).pop("");
          Navigator.pop(context);
        },
      ),
      actions: [
        RawMaterialButton(
            splashColor: Colors.transparent,
            onPressed: () {
              print("get favorites");
              isFavorite = !isFavorite!;
              if (isFavorite!) {
                LikeService.likeProduct(
                  context,
                  widget.myMap,
                  product.id!,
                  widget.userToken,
                );
              } else if (!isFavorite!) {
                LikeService.unlikeProduct(
                  context,
                  product.id!,
                  widget.myMap,
                  widget.userToken,
                );
              }
              setState(() {});
            },
            child: Icon(
              LikeService.getFavoriteControl(product.id!, widget.myMap)
                  ? Icons.favorite
                  : Icons.favorite_border,
              color: Colors.yellow,
              size: 30,
            )
            //onPressed: ()=> cartBloc.addProductToCartCart(_productItem),
            )
      ],
    );
  }
}
