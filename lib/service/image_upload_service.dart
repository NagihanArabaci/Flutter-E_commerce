import 'dart:io';

import 'package:dio/dio.dart';
import 'package:n_e_commmerce/constant/constant.dart';

class ImageUploadService {
  static Future fetch({required File file}) async {
    var formData = FormData.fromMap({
      'avatar':
          await MultipartFile.fromFile(file.path, filename: '${file.path}.jpg'),
    });
    var response = await Dio().post(Constant.baseUrl + "avatarAdd",
        data: formData, options: Constant.getToken());
    if (response.statusCode == 200) {
      return Future.value(true);
    } else {
      return Future.value(false);
    }
  }
}
