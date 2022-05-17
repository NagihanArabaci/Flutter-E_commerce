import 'package:dio/dio.dart';
import 'package:n_e_commmerce/constant/constant.dart';
import 'package:n_e_commmerce/model/user_model.dart';

class UserService {
  static Future<UserModel?> fetch() async {
    try {
      var response = await Dio()
          .get(Constant.baseUrl + "userInfo", options: Constant.getToken());
      if (response.statusCode == 200) {
        var result = UserModel.fromJson(response.data);
        return result;
      }
    } catch (e) {
      print("Gelen hata: $e");
    }
  }
}
