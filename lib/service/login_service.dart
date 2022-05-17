import 'package:dio/dio.dart';
import 'package:n_e_commmerce/constant/constant.dart';
import 'package:n_e_commmerce/model/login_model.dart';

class LoginService {
  static Future<LoginModel?> fetch(
      {required String email, required String password}) async {
    try {
      var response = await Dio().post(Constant.baseUrl + "login",
          data: {"email": email, "password": password});
      if (response.statusCode == 200) {
        var result = LoginModel.fromJson(response.data);
        return result;
      }
    } catch (e) {
      print("Gelen hata: $e");
    }
  }
}
