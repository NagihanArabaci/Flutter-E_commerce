import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:n_e_commmerce/constant/constant.dart';
import 'package:n_e_commmerce/model/campaign_model.dart';
import 'package:n_e_commmerce/model/category_model.dart';
import 'package:n_e_commmerce/service/campaign_service.dart';
import 'package:n_e_commmerce/service/category_service.dart';
import 'package:n_e_commmerce/view/campaigns_detail.dart';
import 'package:n_e_commmerce/view/category_detail.dart';
import 'package:n_e_commmerce/widgets/custom_snackbar.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategoryModelData?> categorys = [];
  List<CampaignModelData?> campaigns = [];
  bool isLoading = false;

  @override
  void initState() {
    CategoryService.fetch().then((value) {
      if (value != null) {
        if (value.status!) {
          categorys = value.data!;
          CampaignService.fetch().then((campaignValue) {
            if (campaignValue != null) {
              if (campaignValue.status!) {
                campaigns = campaignValue.data!;
                setState(() {
                  isLoading = true;
                });
              }
            }
          });
        } else {
          customSnackbar(
              context, "Veri getirilirken bir sorun oluştu: ${value.message}");
        }
      } else {
        customSnackbar(context, "Veri getirilirken bir sorun oluştu");
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: isLoading == false
          ? const LoadingWidget()
          : ListView(
              padding: const EdgeInsets.symmetric(vertical: 15),
              children: [
                CarouselSlider.builder(
                  options: CarouselOptions(
                    height: size.height * 0.2,
                    viewportFraction: 0.9,
                    autoPlay: true,
                  ),
                  itemCount: campaigns.length,
                  itemBuilder: (context, index, pageIndex) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    CampaignsDetail(model: campaigns[index]!)));
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Hero(
                            tag: campaigns[index]!.image!,
                            child: Image.network(
                              "${Constant.imageBaseUrl}uploads/slider/${campaigns[index]!.image!}",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 40, bottom: 20),
                  child: Text(
                    "Kategoriler",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
                GridView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    childAspectRatio: 0.79,
                  ),
                  itemCount: categorys.length,
                  itemBuilder: (context, index) {
                    CategoryModelData item = categorys[index]!;
                    return InkWell(
                      borderRadius: BorderRadius.circular(10),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CategoryDetail(
                              categoryName: item.categoryName!,
                              categoryId: item.id!,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        margin: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: const [
                              BoxShadow(color: Colors.black12, blurRadius: 10)
                            ]),
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                "${Constant.imageBaseUrl}uploads/categorys/${item.image}",
                                width: size.width * 0.17,
                                height: size.width * 0.17,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Text(
                                item.categoryName!,
                                style: Theme.of(context).textTheme.bodyLarge,
                                textAlign: TextAlign.center,
                                maxLines: 2,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
    );
  }
}

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.asset("assets/lottie/loading.json"),
    );
  }
}
