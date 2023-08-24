import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:test_lyve/models/Products.dart';
import 'package:test_lyve/resources/color_manager.dart';
import 'package:test_lyve/resources/font_manager.dart';
import 'package:test_lyve/resources/values_manager.dart';
import 'package:test_lyve/screens/product_details/controller/product_details_getx_controller.dart';
import 'package:test_lyve/widget/slider_banner.dart';

import '../internet_checker_conroller/internet_checker_getx_controller.dart';

class ProductDetailsScreen extends StatefulWidget {
  final num? total;
  final String? tag;

  ProductDetailsScreen({required this.tag, this.total});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<Products>(
        tag: widget.tag,
        builder: (controller) => Container(
          width: double.infinity,
          child: Column(
            children: [
              SizedBox(
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: Stack(
                    children: [
                      Image.network(controller.thumbnail!,
                              fit: BoxFit.fill,errorBuilder: (context, error, stackTrace) {
                                return Icon(Icons.error_outline,size: AppSize.s360);
                              },),
                      PositionedDirectional(
                        top: 250.h,
                        start: 90.w,
                        child: ClipRRect(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10.r),
                              bottomRight: Radius.circular(10.r),
                            ),
                            child: SliderBanner(
                              images: controller.images,
                            )),
                      ),
                      PositionedDirectional(
                        top: 40.h,
                        start: 40.w,
                        child: GestureDetector(
                          onTap: () => Navigator.of(context).pop(),
                          child: Container(
                            height: 40.h,
                            width: 40.h,
                            decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(50.r)),
                            child: const Icon(Icons.arrow_back,),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              Padding(
                padding: EdgeInsets.all(8.w),
                child: Text(
                  "${controller.title}",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: FontSize.s20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Text("${controller.brand} (${controller.category})",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: ColorManager.primary,
                      fontWeight: FontWeight.w500,
                      fontSize: FontSize.s18)),
              Padding(
                padding: EdgeInsets.all(8.w),
                child: Row(
                  children: [
                    RatingBar.builder(
                      itemSize: 25.h,
                      initialRating: controller.rating!.toDouble(),
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      glow: false,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      unratedColor: Colors.grey.shade300,
                      onRatingUpdate: (value) {},
                    ),
                    Text(
                      "(${controller.rating})",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: FontSize.s14,
                      ),
                    ),
                    const Spacer(),
                    Column(
                      children: [
                        Text(
                          "\$ ${widget.total}",
                          style: TextStyle(
                              color: Colors.green,
                              fontSize: FontSize.s14,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "\$ ${controller.price}",
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: FontSize.s10,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.lineThrough),
                        ),
                      ],
                    ),
                    const Spacer(),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.w),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Description : ",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: FontSize.s18,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(8.w),
                width: double.infinity,
                child: Text(
                  "${controller.description}",
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: FontSize.s16,
                      fontWeight: FontWeight.w500),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
