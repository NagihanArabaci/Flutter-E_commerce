import 'package:flutter/material.dart';
import 'package:n_e_commmerce/constant/constant.dart';
import 'package:n_e_commmerce/model/product_detail_model.dart';
import 'package:n_e_commmerce/service/product_detail_service.dart';
import 'package:n_e_commmerce/view/home.dart';
import 'package:n_e_commmerce/widgets/custom_appbar.dart';
import 'package:n_e_commmerce/widgets/custom_button.dart';
import 'package:n_e_commmerce/widgets/custom_snackbar.dart';

import '../service/basket_service.dart';
import '../service/favorite_service.dart';
import '../widgets/loading_popup.dart';

class ProductDetail extends StatefulWidget {
  int productId;
  ProductDetail({required this.productId});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  ProductDetailModel? model;
  bool isLoading = false;
  int currentIndex = 0;
  void addFavorite({required ProductDetailModel model}) {
    loadingPopup(context);
    FavoriteService.add(productId: model.data!.id!).then((value) {
      if (value != null && value.status == true) {
        setState(() {
          model.data!.isFavorite = true;
        });
        Navigator.pop(context);
      } else {
        Navigator.pop(context);
        customSnackbar(context, "Bir sorun oluştu ${value?.message ?? ""}");
      }
    });
  }

  void removeFavorite({required ProductDetailModel model}) {
    loadingPopup(context);
    FavoriteService.add(productId: model.data!.id!).then((value) {
      if (value != null && value.status == true) {
        setState(() {
          model.data!.isFavorite = false;
        });
        Navigator.pop(context);
      } else {
        Navigator.pop(context);
        customSnackbar(context, "Bir sorun oluştu ${value?.message ?? ""}");
      }
    });
  }

  @override
  void initState() {
    print("Product ıd : ${widget.productId}");
    super.initState();
    ProductDetailService.fetch(productId: widget.productId).then((value) {
      if (value != null && value.status == true) {
        setState(() {
          model = value;
          isLoading = true;
        });
      } else {
        customSnackbar(context, "Bir sorun oluştu");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBarScreen(
        text: "Ürün Detay",
      ),
      body: isLoading == false
          ? const LoadingWidget()
          : Column(
              children: [
                Stack(
                  children: [
                    SizedBox(
                      height: size.height * 0.3,
                      child: PageView.builder(
                        itemCount: model!.data!.image!.length,
                        onPageChanged: (newPageIndex) {
                          setState(() {
                            currentIndex = newPageIndex;
                          });
                        },
                        itemBuilder: (context, index) {
                          return Hero(
                            tag: model!.data!.image!,
                            child: Image.network(
                              "${Constant.imageBaseUrl}uploads/products/${model!.data!.image![index]}",
                              height: size.height * 0.3,
                              width: double.maxFinite,
                              fit: BoxFit.contain,
                              errorBuilder: (context, obje, stac) {
                                return SizedBox(
                                  height: size.height * 0.3,
                                  width: double.maxFinite,
                                  child: const Icon(
                                    Icons.warning_amber,
                                    size: 40,
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ),
                    Positioned.fill(
                      left: size.width / 2,
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Row(
                          children: [
                            for (int i = 0; i < model!.data!.image!.length; i++)
                              Container(
                                margin: const EdgeInsets.only(right: 8),
                                width: currentIndex == i ? 20 : 10,
                                height: currentIndex == i ? 20 : 10,
                                decoration: BoxDecoration(
                                  color: currentIndex == i
                                      ? Colors.black
                                      : Colors.grey.shade400,
                                  shape: BoxShape.circle,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                    // Align(
                    //   alignment: Alignment.topRight,
                    //   child: GestureDetector(
                    //     onTap: () {
                    //       if (model!.data!.isFavorite == true) {
                    //         removeFavorite(model: model!);
                    //       } else {
                    //         if (GetStorage().read("token") != null) {
                    //           addFavorite(model: model!);
                    //         } else {
                    //           customSnackbar(context,
                    //               "Favorilere eklemek için önce giriş yapmalısınız.");
                    //         }
                    //       }
                    //     },
                    //     child: Container(
                    //       margin: const EdgeInsets.all(10),
                    //       decoration: const BoxDecoration(
                    //           color: Colors.white,
                    //           shape: BoxShape.circle,
                    //           boxShadow: [
                    //             BoxShadow(color: Colors.black12, blurRadius: 10)
                    //           ]),
                    //       padding: const EdgeInsets.all(8.0),
                    //       child: Icon(
                    //         model!.data!.isFavorite == true
                    //             ? CupertinoIcons.heart_fill
                    //             : CupertinoIcons.heart,
                    //         color: model!.data!.isFavorite == true
                    //             ? Colors.red
                    //             : Colors.grey,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      model!.data!.title!,
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      model?.data?.description ?? "",
                      style: Theme.of(context).textTheme.bodyLarge,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const Spacer(),
                Container(
                  color: Colors.grey.shade200,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "Fiyat: ${model?.data?.price ?? ""} ₺",
                        style: Theme.of(context).textTheme.headline5!.copyWith(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Expanded(
                          child: CustomButton(
                        text: "Sepete Ekle",
                        onTap: () {
                          BasketService.addBasket(productId: model!.data!.id!)
                              .then((value) {
                            if (value != null && value.status == true) {
                              customSnackbar(context,
                                  "${model!.data!.title} başarıyla sepete eklendi");
                            } else {
                              customSnackbar(context,
                                  "${model!.data!.title} sepete eklenirken sorun oluştu.");
                            }
                          });
                        },
                      )),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
