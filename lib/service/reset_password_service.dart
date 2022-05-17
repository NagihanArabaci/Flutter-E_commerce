import 'package:dio/dio.dart';
import 'package:n_e_commmerce/constant/constant.dart';
import 'package:n_e_commmerce/model/user_update_model.dart';

class ResetPasswordService {
  static Future<UserUpdateModel?> fetch({
    required String last,
    required String newP,
  }) async {
    try {
      var response = await Dio().post("${Constant.baseUrl}resetPassword",
          data: {"password": last, "newPassword": newP},
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
