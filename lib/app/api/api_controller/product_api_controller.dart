import 'dart:convert';

import 'package:test_lyve/app/api/api_helper.dart';
import 'package:test_lyve/app/constants.dart';
import 'package:test_lyve/models/Products.dart';
import 'package:http/http.dart' as http;

class ProductsApiController with ApiHelper {
  
  Future<List<Products>> getProducts({String? search}) async {
    var url = Uri.parse("${Constants.baseUrl}/products/search?q=$search");
    var response = await http.get(url,headers: headers);
    if(response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      return List<Products>.from(jsonData["products"].map((x) => Products.fromJson(x)));
    }
    return [];
  }


  Future<Products?> getProductsById({int? id}) async {
    var url = Uri.parse("${Constants.baseUrl}/products/$id");
    var response = await http.get(url,headers: headers);
    if(response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      return Products.fromJson(jsonData);
    }
    return null;
  }
}