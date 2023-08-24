import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:test_lyve/resources/font_manager.dart';
import 'package:test_lyve/screens/login/controller/login_getx_controller.dart';

import '../../resources/color_manager.dart';
import '../../resources/values_manager.dart';
import '../internet_checker_conroller/internet_checker_getx_controller.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //controller
  final LoginGetxController _loginGetxController =
      Get.put(LoginGetxController());
  final InternetCheckerGetxController _internetCheckerGetxController =
      Get.put(InternetCheckerGetxController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.5,
                alignment: Alignment.topLeft,
                child: Transform(
                  transform: Matrix4.skew(-16, 6),
                  child: ClipPath(
                    clipper: const ShapeBorderClipper(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(20),
                    ))),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.7,
                      color: ColorManager.primaryDark,
                    ),
                  ),
                ),
              ),
              PositionedDirectional(
                start: 40.w,
                top: 100.h,
                child: Center(
                  child: Text("Login",
                      style: TextStyle(
                          fontSize: FontSize.s30,
                          color: Colors.white,
                          fontWeight: FontWeight.bold)),
                ),
              ),
              PositionedDirectional(
                bottom: MediaQuery.of(context).size.width * 0.4,
                start: MediaQuery.of(context).size.width * 0.5,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.4,
                  alignment: Alignment.topLeft,
                  child: Transform(
                    transform: Matrix4.skew(-16, 6),
                    child: ClipPath(
                      clipper: const ShapeBorderClipper(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(100),
                        bottomLeft: Radius.circular(500),
                      ))),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.3,
                        color: Colors.blueAccent.withOpacity(0.4),
                      ),
                    ),
                  ),
                ),
              ),
              PositionedDirectional(
                start: MediaQuery.of(context).size.width * 0.7,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.5,
                  alignment: Alignment.topLeft,
                  child: Transform(
                    transform: Matrix4.skew(-16, 6),
                    child: ClipPath(
                      clipper: const ShapeBorderClipper(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(20),
                        bottomLeft: Radius.circular(40),
                      ))),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.6,
                        color: ColorManager.primary,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 40.h),
          GetBuilder<LoginGetxController>(
            builder: (controller) => Form(
              key: controller.formKey,
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      20,
                    ),
                    side: const BorderSide(color: Colors.grey)),
                elevation: 3,
                child: Container(
                  padding: EdgeInsets.all(AppPadding.p10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "User name:",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: FontSize.s18),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.name,
                        controller: controller.useNameTextController,
                        decoration:
                            const InputDecoration(hintText: "Enter user name"),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "please enter user name";
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      Text(
                        "Password:",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: FontSize.s18),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.name,
                        controller: controller.passwordTextController,
                        decoration: const InputDecoration(hintText: "Enter password"),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "please enter the password";
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                              onPressed: () {
                                if (_internetCheckerGetxController
                                        .connectionStatus ==
                                    InternetStatus.connected) {
                                  controller.login(
                                      context: context,
                                      userName:
                                          controller.useNameTextController.text,
                                      password: controller
                                          .passwordTextController.text);
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
                              child: const Text("Login")))
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    ));
  }
}
