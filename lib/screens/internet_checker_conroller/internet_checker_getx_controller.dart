import 'dart:async';
import 'package:get/get.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';



class InternetCheckerGetxController extends GetxController {
  InternetStatus? connectionStatus;
  late StreamSubscription<InternetStatus> subscription;

 Future<void> checkInternetStatus() async {
   subscription = InternetConnection().onStatusChange.listen((status) {
       connectionStatus = status;
   });
   update();
 }

}