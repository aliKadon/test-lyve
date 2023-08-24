import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_lyve/app/api/api_controller/product_api_controller.dart';
import 'package:test_lyve/models/Products.dart';

class ProductDetailsGetxController extends GetxController {

  final ProductsApiController _productsApiController = ProductsApiController();

  int rate = 1;

  Products? product;

  void getProductById({required BuildContext context , required int id}) async {
    try {
      product = await _productsApiController.getProductsById(id: id);
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