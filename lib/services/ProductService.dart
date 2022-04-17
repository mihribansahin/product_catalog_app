import 'package:product_catalog_app/models/product_model.dart';

abstract class MyProductServices {

  Future<List<ProductModel>> fetchAllProduct();
}
