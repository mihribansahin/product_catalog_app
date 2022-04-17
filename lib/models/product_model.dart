

class ProductModel {
  int? id;
  String? name;
  int? price;
  String? image;
  String? description;
  String? timeStamp;

  ProductModel(
      {this.id,
      this.name,
      this.price,
      this.image,
      this.description,
      this.timeStamp});

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    image = json['image'];
    description = json['description'];
    timeStamp = json['timeStamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['image'] = this.image;
    data['description'] = this.description;
    data['timeStamp'] = this.timeStamp;
    return data;
  }
}