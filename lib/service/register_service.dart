import 'dart:math';

import 'package:dio/dio.dart';
import 'package:n_e_commmerce/constant/constant.dart';
import 'package:n_e_commmerce/model/login_model.dart';

class RegisterService {
  static Future<LoginModel?> fetch(
      {required String name,
      required String phone,
      required String email,
      required String password}) async {
    print("name : $name phone: $phone email: $email password: $password ");
    try {
      var response = await Dio().post("${Constant.baseUrl}register", data: {
        "name": name,
        "phone": phone,
        "email": email,
        "password": password,
      });
      if (response.statusCode == 200) {
        var result = LoginModel.fromJson(response.data);
        return result;
      }
    } catch (e) {
      print("Gelen hata: $e");
    }
    return null;
  }
}
