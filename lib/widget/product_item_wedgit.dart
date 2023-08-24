import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:test_lyve/models/Products.dart';
import 'package:test_lyve/screens/product_details/product_details_screen.dart';

class ProductItemWedgit extends StatefulWidget {
  final String tag;

  ProductItemWedgit({required this.tag});

  @override
  State<ProductItemWedgit> createState() => _ProductItemWedgitState();
}

class _ProductItemWedgitState extends State<ProductItemWedgit> {
  //controller
  final Products _products = Get.put(Products());

  num total = 0;


  // calculate the total price after discount
  void calculate({required num price, required num discountPercentage}) {
    var discount = (price * discountPercentage) / 100;
    total = price - discount;
    total = num.parse(total.toStringAsFixed(2));
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<Products>(
      tag: widget.tag,
      builder: (controller) {
        calculate(
            price: controller.price!,
            discountPercentage: controller.discountPercentage!);
        return GestureDetector(
          onTap: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ProductDetailsScreen(tag: widget.tag,total: total),
          )),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.r)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.r),
                  child: Image.network(
                    "${controller.images?[0]}",
                    height: 130.h,
                    width: 110.w,
                    fit: BoxFit.fill,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(Icons.error_outline);
                    },
                  ),
                ),
              ),
              const Spacer(),
              SizedBox(
                width: 150.w,
                child: Text(
                  "${controller.title}",
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const Spacer(),
              Row(
                children: [
                  const Spacer(),
                  Text(
                    "$total",
                    style: const TextStyle(
                      color: Colors.green,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    "${controller.price}",
                    style: const TextStyle(
                        color: Colors.red,
                        decoration: TextDecoration.lineThrough),
                  ),
                  const Spacer(),
                ],
              ),
              const Spacer(),
            ],
          ),
        );
      },
    );
  }
}
