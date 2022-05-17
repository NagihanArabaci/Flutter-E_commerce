import 'package:dio/dio.dart';
import 'package:n_e_commmerce/constant/constant.dart';
import 'package:n_e_commmerce/model/product_detail_model.dart';

class ProductDetailService {
  static Future<ProductDetailModel?> fetch({required int productId}) async {
    try {
      var response = await Dio().post(
        "${Constant.baseUrl}productDetail",
        data: {"productId": productId},
        options: Constant.getToken(),
      );
      if (response.statusCode == 200) {
        var result = ProductDetailModel.fromJson(response.data);
        return result;
      }
    } catch (e) {
      print("Gelen hata: $e");
    }
    return null;
  }
}
