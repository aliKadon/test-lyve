import 'package:shared_preferences/shared_preferences.dart';

import '../../models/user.dart';
import '../utils/app_shared_data.dart';

enum PrefKeys {
  token,
  id,
  firstName,
  lastName,
  userName,
  email,
  gender,
  image

}

class SharedPrefController {
  SharedPrefController._internal();

  late SharedPreferences _sharedPreferences;
  static SharedPrefController? _instance;

  factory SharedPrefController() {
    return _instance ??= SharedPrefController._internal();
  }

  ///TO DO CALLED IN MAIN AFTER --WidgetsFlutterBinding-- AND BEFORE runApp()
  Future<void> initPref() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  var key = 'ar';

  Future<bool> clear() async {
    return _sharedPreferences.clear();
  }

  Future<void> save({required User user}) async {
    await _sharedPreferences.setString(PrefKeys.userName.name, user.username ?? "");
    await _sharedPreferences.setString(
        PrefKeys.firstName.name, user.firstName ?? "");
    await _sharedPreferences.setString(PrefKeys.lastName.name, user.lastName?? "");
    await _sharedPreferences.setString(PrefKeys.email.name, user.email?? "");
    await _sharedPreferences.setString(
        PrefKeys.image.name, user.image?? "");
    await _sharedPreferences.setString(
        PrefKeys.gender.name, user.gender?? "");

    await _sharedPreferences.setInt(
        PrefKeys.id.name, user.id ?? 0);
    await _sharedPreferences.setString(
        PrefKeys.token.name, user.token ?? "");
  }

  User? getUser() {
    return AppSharedData.currentUser = User(
      username: _sharedPreferences.getString(PrefKeys.userName.name),
      firstName: _sharedPreferences.getString(PrefKeys.firstName.name),
      lastName: _sharedPreferences.getString(PrefKeys.lastName.name),
      token: _sharedPreferences.getString(PrefKeys.token.name),
      email: _sharedPreferences.getString(PrefKeys.email.name),
      gender: _sharedPreferences.getString(PrefKeys.gender.name),
      image: _sharedPreferences.getString(PrefKeys.image.name),
      id: _sharedPreferences.getInt(PrefKeys.id.name),
    );
  }
}
