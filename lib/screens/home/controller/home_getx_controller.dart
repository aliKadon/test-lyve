
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_lyve/app/api/api_controller/product_api_controller.dart';

import '../../../models/Products.dart';

class HomeGetxController extends GetxController {
  final ProductsApiController _productsApiController = ProductsApiController();

  final TextEditingController searchTextEditingController = TextEditingController();

  List<Products> products = [];

  void getProducts({required BuildContext context,String? search = ""}) async {
    try {
      products = await _productsApiController.getProducts(search: search);
      update();
    }catch (e) {
      Get.showSnackbar(
        GetSnackBar(
          title: e.toString(),
          message: "Try again!",
          icon: const Icon(Icons.refresh),
          duration: const Duration(seconds: 2),
          backgroundColor: Colors.red,
          borderRadius: 20,
        ),
      );
    }
  }


}
