import 'package:dio/dio.dart';
import 'package:n_e_commmerce/constant/constant.dart';
import 'package:n_e_commmerce/model/product_model.dart';
import 'package:n_e_commmerce/model/search_model.dart';

class SearchService {
  static Future<ProductModel?> fetch(
      {required String text}) async {
    try {
      var response = await Dio().post(Constant.baseUrl + "search",
          data: {"search": text});
      if (response.statusCode == 200) {
        var result = ProductModel.fromJson(response.data);
        return result;
      }
    } catch (e) {
      print("Gelen hata: $e");
    }
  }
}
