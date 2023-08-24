import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_lyve/app/api/api_controller/auth_api_controller.dart';
import 'package:test_lyve/app/preferences/shared_pref_controller.dart';
import 'package:test_lyve/app/utils/helpers.dart';
import 'package:test_lyve/models/api_response.dart';
import 'package:test_lyve/screens/home/home_screen.dart';

class LoginGetxController extends GetxController with Helpers {
  final TextEditingController useNameTextController = TextEditingController();
  final TextEditingController passwordTextController = TextEditingController();

  final AuthApiController _authApiController = AuthApiController();

  late final GlobalKey<FormState> formKey = GlobalKey();

  void login(
      {required BuildContext context,
      required String userName,
      required String password}) async {
    if (!formKey.currentState!.validate()) return;
    showLoadingDialog(context: context, title: "loading");
    try {
      final ApiResponse apiResponse = await _authApiController.login(
          userName: userName, password: password);
      Navigator.of(context).pop();
      if (apiResponse.status == 200) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => HomeScreen(),
        ));
        Get.showSnackbar(
          GetSnackBar(
            title: "Welcome back",
            message: SharedPrefController().getUser()?.firstName,
            duration: const Duration(seconds: 2),
            backgroundColor: Colors.green,
            borderRadius: 20,
          ),
        );
      } else {
        Get.showSnackbar(
          GetSnackBar(
            title: apiResponse.message,
            message: "Try again!",
            icon: const Icon(Icons.refresh),
            duration: const Duration(seconds: 2),
            backgroundColor: Colors.red,
            borderRadius: 20,
          ),
        );
      }
    } catch (e) {
      Navigator.of(context).pop();
      showSnackBar(context, message: e.toString(), error: true);
    }
  }
}
