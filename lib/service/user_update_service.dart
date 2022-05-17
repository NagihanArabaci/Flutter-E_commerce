import 'package:dio/dio.dart';
import 'package:n_e_commmerce/constant/constant.dart';
import 'package:n_e_commmerce/model/user_update_model.dart';

class UserUpdateService {
  static Future<UserUpdateModel?> fetch(
      {required String email,
      required String name,
      required String phone}) async {
    try {
      var response = await Dio().post("${Constant.baseUrl}userUpdate",
          data: {"name": name, "phone": phone, "email": email},
          options: Constant.getToken());
      if (response.statusCode == 200) {
        var result = UserUpdateModel.fromJson(response.data);
        return result;
      }
    } catch (e) {
      print("Gelen hata: $e");
    }
    return null;
  }
}
