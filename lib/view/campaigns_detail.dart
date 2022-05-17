import 'package:flutter/material.dart';
import 'package:n_e_commmerce/constant/constant.dart';
import 'package:n_e_commmerce/model/campaign_model.dart';
import 'package:n_e_commmerce/widgets/custom_appbar.dart';

class CampaignsDetail extends StatelessWidget {
  CampaignModelData model;
  CampaignsDetail({required this.model});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBarScreen(
        text: "Kampanya Detayı",
      ),
      body: ListView(
        children: [
          Hero(
            tag: model.image!,
            child: Image.network(
              "${Constant.imageBaseUrl}uploads/slider/${model.image}",
              height: size.height * 0.3,
              width: size.width,
              fit: BoxFit.contain,
            ),
          ),
          Center(
            child: Text(
              model.title ?? "",
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              model.description ?? "",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        ],
      ),
    );
  }
}
