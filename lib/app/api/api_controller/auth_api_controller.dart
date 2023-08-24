import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:test_lyve/app/api/api_helper.dart';
import 'package:test_lyve/app/constants.dart';

import '../../../models/api_response.dart';
import '../../../models/user.dart';
import '../../preferences/shared_pref_controller.dart';

class AuthApiController with ApiHelper {
  Future<ApiResponse> login(
      {required String userName, required String password}) async {
    var url = Uri.parse("${Constants.baseUrl}/auth/login");
    var response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(
        {"username": userName, "password": password},
      ),
    );
    var jsonData = jsonDecode(response.body);
    if (response.statusCode == 200) {
      User user1 = User.fromJson(jsonData);
      SharedPrefController().save(user: user1);
      return ApiResponse(message: "success", status: 200);
    } else {
      return ApiResponse(
          message: jsonData["message"].toString(), status: response.statusCode);
    }
  }
}
