import 'package:dio/dio.dart';
import 'package:n_e_commmerce/constant/constant.dart';
import 'package:n_e_commmerce/model/category_model.dart';

class CategoryService {
  static Future<CategoryModel?> fetch() async {
    try {
      var response = await Dio().get(Constant.baseUrl + "categorys");
      if (response.statusCode == 200) {
        var result = CategoryModel.fromJson(response.data);
        return result;
      }
    } catch (e) {
      print("Gelen hata: $e");
    }
  }
}
