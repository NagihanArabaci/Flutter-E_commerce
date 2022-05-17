import 'package:dio/dio.dart';
import 'package:n_e_commmerce/model/basket_model.dart';
import 'package:n_e_commmerce/model/global_model.dart';

import '../constant/constant.dart';

class BasketService {
  static Future<BasketModel?> fetch() async {
    try {
      var response = await Dio().get(
        "${Constant.baseUrl}cartBring",
        options: Constant.getToken(),
      );
      if (response.statusCode == 200) {
        var result = BasketModel.fromJson(response.data);
        return result;
      }
    } catch (e) {
      print("Gelen hata: $e");
    }
    return null;
  }

  static Future<GlobalModel?> addBasket({required int productId}) async {
    try {
      var response = await Dio().post(Constant.baseUrl + "cartAdd",
          data: {"productId": productId}, options: Constant.getToken());
      if (response.statusCode == 200) {
        var result = GlobalModel.fromJson(response.data);
        return result;
      }
    } catch (e) {
      print("Gelen hata: $e");
    }
  }

    static Future<GlobalModel?> deleteBasket({required int productId}) async {
    try {
      var response = await Dio().post(Constant.baseUrl + "cartDelete",
          data: {"productId": productId}, options: Constant.getToken());
      if (response.statusCode == 200) {
        var result = GlobalModel.fromJson(response.data);
        return result;
      }
    } catch (e) {
      print("Gelen hata: $e");
    }
  }
}
