import 'package:dio/dio.dart';
import 'package:n_e_commmerce/constant/constant.dart';
import 'package:n_e_commmerce/model/favorite_model.dart';
import 'package:n_e_commmerce/model/global_model.dart';

class FavoriteService {
  static Future<FavoriteModel?> fetch() async {
    try {
      var response = await Dio().get(
        "${Constant.baseUrl}favoriList",
        options: Constant.getToken(),
      );
      if (response.statusCode == 200) {
        var result = FavoriteModel.fromJson(response.data);
        return result;
      }
    } catch (e) {
      print("Gelen hata: $e");
    }
    return null;
  }

  static Future<GlobalModel?> add({required int productId}) async {
    try {
      var response = await Dio().post(
        "${Constant.baseUrl}favoriAdd",
        data: {
          "productId": productId,
        },
        options: Constant.getToken(),
      );
      if (response.statusCode == 200) {
        return GlobalModel.fromJson(response.data);
      }
    } catch (e) {
      print("Gelen hata: $e");
    }
  }

  static Future<GlobalModel?> remove({required int productId}) async {
    try {
      var response = await Dio().post(
        "${Constant.baseUrl}favoriRemove",
        data: {
          "productId": productId,
        },
        options: Constant.getToken(),
      );
      if (response.statusCode == 200) {
        return GlobalModel.fromJson(response.data);
      }
    } catch (e) {
      print("Gelen hata: $e");
    }
  }
}
