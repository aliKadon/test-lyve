import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:test_lyve/resources/theme_manager.dart';
import 'package:test_lyve/screens/internet_checker_conroller/internet_checker_getx_controller.dart';
import 'package:test_lyve/screens/login/login_screen.dart';

import 'app/preferences/shared_pref_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefController().initPref();
  runApp(
    MyApp(),

    // this code i use To ensure that the application interfaces will be suitable for all dimensions of the devices "device_preview" package.

    // DevicePreview(
    //   enabled: !kReleaseMode,
    //   builder: (context) => MyApp(), // Wrap your app
    // ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //controller
  final InternetCheckerGetxController _internetCheckerGetxController =
      Get.put(InternetCheckerGetxController());

  @override
  void initState() {
    // check the internet connection
    _internetCheckerGetxController.checkInternetStatus();
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      builder: (context, child) {
        return GetMaterialApp(
          builder: DevicePreview.appBuilder,
          debugShowCheckedModeBanner: false,
          home: LoginScreen(),
          theme: getApplicationTheme(),
        );
      },
    );
  }
}
