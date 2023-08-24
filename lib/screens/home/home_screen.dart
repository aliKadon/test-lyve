import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:test_lyve/app/utils/app_shared_data.dart';
import 'package:test_lyve/models/Products.dart';
import 'package:test_lyve/resources/color_manager.dart';
import 'package:test_lyve/resources/font_manager.dart';
import 'package:test_lyve/resources/values_manager.dart';
import 'package:test_lyve/screens/home/controller/home_getx_controller.dart';
import 'package:test_lyve/screens/internet_checker_conroller/internet_checker_getx_controller.dart';

import '../../widget/product_item_wedgit.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //controller
  final HomeGetxController _homeGetxController = Get.put(HomeGetxController());
  final InternetCheckerGetxController _internetCheckerGetxController =
      Get.put(InternetCheckerGetxController());

  bool _doubleBackToExitPressedOnce = false;


  // to exit from app when the  user press back twice
  Future<bool> onWillPop() async {
    if (_doubleBackToExitPressedOnce) {
      return true;
    }
    _doubleBackToExitPressedOnce = true;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Press back again to exit')),
    );
    Timer(const Duration(seconds: 2), () {
      _doubleBackToExitPressedOnce = false;
    });
    return false;
  }

  @override
  void initState() {
    _homeGetxController.getProducts(context: context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: onWillPop,
        child: SafeArea(
          child: SingleChildScrollView(
            child: GetBuilder<HomeGetxController>(
              builder: (controller) => Column(
                children: [
                  Row(
                    children: [
                      const Spacer(),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(40),
                        child: Image.network(
                          "${AppSharedData.currentUser?.image}",
                          height: 90.h,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(Icons.person_off);
                          },
                        ),
                      ),
                      // SizedBox(
                      //   width: 30.w,
                      // ),
                      const Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${AppSharedData.currentUser?.firstName} ${AppSharedData.currentUser?.lastName}",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: FontSize.s14,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Welcome back",
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: FontSize.s10,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "Test Lyve",
                            style: TextStyle(
                                color: ColorManager.primary,
                                fontWeight: FontWeight.bold),
                          ),
                          Icon(
                            Icons.language,
                            color: ColorManager.primary,
                          )
                        ],
                      ),
                      const Spacer(),
                    ],
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  GetBuilder<HomeGetxController>(
                    builder: (controller) => Container(
                        margin: EdgeInsets.symmetric(horizontal: AppMargin.m12),
                        padding: EdgeInsets.symmetric(horizontal: AppPadding.p10),
                        height: AppSize.s50,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30.r),
                            border: Border.all(color: Colors.black12)),
                        child: TextFormField(
                          onChanged: (value) {
                            if (_internetCheckerGetxController.connectionStatus ==
                                InternetStatus.connected) {
                              controller.getProducts(
                                  context: context,
                                  search: controller
                                      .searchTextEditingController.text);
                            } else {
                              Get.showSnackbar(
                                GetSnackBar(
                                  title: "No internet connection!!!",
                                  message: "Try again!",
                                  icon: const Icon(Icons.refresh),
                                  duration: const Duration(seconds: 2),
                                  backgroundColor: Colors.red,
                                  borderRadius: 20,
                                  onTap: (snack) {},
                                ),
                              );
                            }
                          },
                          controller: controller.searchTextEditingController,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            icon: Icon(Icons.search),
                            hintText: "Search",
                          ),
                        )),
                  ),
                  SizedBox(
                    height: AppSize.s25,
                  ),
                  controller.products.isEmpty
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2, mainAxisSpacing: 20.h),
                          itemCount: controller.products.length,
                          itemBuilder: (context, index) {
                            Get.put<Products>(controller.products[index],
                                tag: "${controller.products[index].id}");
                            return ProductItemWedgit(
                              tag: "${controller.products[index].id}",
                            );
                          },
                        )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
