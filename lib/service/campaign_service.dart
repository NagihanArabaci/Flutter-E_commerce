import 'package:dio/dio.dart';
import 'package:n_e_commmerce/constant/constant.dart';
import 'package:n_e_commmerce/model/campaign_model.dart';

class CampaignService {
  static Future<CampaignModel?> fetch() async {
    try {
      var response = await Dio().get(Constant.baseUrl + "slider");
      if (response.statusCode == 200) {
        var result = CampaignModel.fromJson(response.data);
        return result;
      }
    } catch (e) {
      print("Gelen hata: $e");
    }
  }
}
