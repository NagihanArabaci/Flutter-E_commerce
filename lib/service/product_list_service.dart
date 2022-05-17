import 'package:dio/dio.dart';
import 'package:n_e_commmerce/constant/constant.dart';
import 'package:n_e_commmerce/model/product_model.dart';

class ProductListService {
  static Future<ProductModel?> fetch({required int categoryId}) async {
    try {
      var response = await Dio().post("${Constant.baseUrl}productsList",
          data: {"categoryId": categoryId}, options: Constant.getToken());
      if (response.statusCode == 200) {
        var result = ProductModel.fromJson(response.data);
        return result;
      }
    } catch (e) {
      print("Gelen hata: $e");
    }
    return null;
  }
}
