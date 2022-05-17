import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';

class Constant {
  static const String baseUrl =
      "https://e-commerce-api-app-nodejs.herokuapp.com/api/v1/";
        static const String imageBaseUrl =
      "https://e-commerce-api-app-nodejs.herokuapp.com/";

  static Options getToken() {
    final token = GetStorage().read("token");
    return Options(headers: {"Authorization": "Bearer $token"});
  }
}
