import 'package:get/get.dart';

class Products extends GetxController {
  num? id;
  String? title;
  String? description;
  num? price;
  num? discountPercentage;
  num? rating;
  num? stock;
  String? brand;
  String? category;
  String? thumbnail;
  List<dynamic>? images;

  Products({
    this.price,
    this.id,
    this.title,
    this.description,
    this.images,
    this.brand,
    this.category,
    this.discountPercentage,
    this.rating,
    this.stock,
    this.thumbnail,
  });

  factory Products.fromJson(Map<String, dynamic> json) => Products(
        title: json["title"],
        id: json["id"],
        description: json["description"],
        brand: json["brand"],
        category: json["category"],
        discountPercentage: json["discountPercentage"],
        images: json["images"],
        price: json["price"],
        rating: json["rating"],
        stock: json["stock"],
        thumbnail: json["thumbnail"],
      );
}
