import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:n_e_commmerce/model/favorite_model.dart';
import 'package:n_e_commmerce/service/favorite_service.dart';
import 'package:n_e_commmerce/view/home.dart';
import 'package:n_e_commmerce/widgets/custom_snackbar.dart';
import 'package:n_e_commmerce/widgets/loading_popup.dart';

import '../model/product_model.dart';
import '../widgets/product_card.dart';

class Favorite extends StatefulWidget {
  const Favorite({Key? key}) : super(key: key);

  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  List<FavoriteModelData?> products = [];
  bool isLoading = false;

  void removeFavorite({required FavoriteModelData model}) {
    loadingPopup(context);
    FavoriteService.remove(productId: model.productId!).then((value) {
      products.remove(model);
      setState(() {});
      Navigator.pop(context);
    });
  }

  @override
  void initState() {
    super.initState();
    FavoriteService.fetch().then((value) {
      if (value != null && value.status == true) {
        products = value.data!;
        setState(() {
          isLoading = true;
        });
      } else {
        customSnackbar(context, "Bir sorun oluştu");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: isLoading == false
          ? const LoadingWidget()
          : products.isEmpty
              ? Center(
                  child: Lottie.asset("assets/lottie/favorite.json"),
                )
              : GridView.builder(
                  shrinkWrap: true,
                  itemCount: products.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 20,
                    childAspectRatio: 0.8,
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  itemBuilder: (context, index) {
                    ProductModelData item = ProductModelData(
                      id: products[index]!.productId,
                      image: products[index]!.image,
                      price: products[index]!.price,
                      title: products[index]!.title,
                      isFavorite: products[index]!.isFavorite,
                    );
                    return ProductCard(
                      item: item,
                      favoriteOnTap: () =>
                          removeFavorite(model: products[index]!),
                    );
                  },
                ),
    );
  }
}
