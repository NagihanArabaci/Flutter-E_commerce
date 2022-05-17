import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:n_e_commmerce/service/favorite_service.dart';
import 'package:n_e_commmerce/service/product_list_service.dart';
import 'package:n_e_commmerce/view/home.dart';

import 'package:n_e_commmerce/widgets/custom_appbar.dart';
import 'package:n_e_commmerce/widgets/custom_snackbar.dart';
import 'package:n_e_commmerce/widgets/loading_popup.dart';

import '../model/product_model.dart';
import '../widgets/product_card.dart';

class CategoryDetail extends StatefulWidget {
  String categoryName;
  int categoryId;

  CategoryDetail({required this.categoryName, required this.categoryId});

  @override
  State<CategoryDetail> createState() => _CategoryDetailState();
}

class _CategoryDetailState extends State<CategoryDetail> {
  List<ProductModelData?> products = [];

  bool isLoading = false;

  void addFavorite({required ProductModelData model}) {
    loadingPopup(context);
    FavoriteService.add(productId: model.id!).then((value) {
      if (value != null && value.status == true) {
        setState(() {
          model.isFavorite = true;
        });
        Navigator.pop(context);
      } else {
        Navigator.pop(context);
        customSnackbar(context, "Bir sorun oluştu ${value?.message ?? ""}");
      }
    });
  }

  void removeFavorite({required ProductModelData model}) {
    loadingPopup(context);
    FavoriteService.add(productId: model.id!).then((value) {
      if (value != null && value.status == true) {
        setState(() {
          model.isFavorite = false;
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
    super.initState();
    ProductListService.fetch(categoryId: widget.categoryId).then((value) {
      if (value != null) {
        products = value.data!;
        setState(() {
          isLoading = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarScreen(
        text: widget.categoryName,
      ),
      body: isLoading == false
          ? const LoadingWidget()
          : GridView.builder(
              itemCount: products.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                childAspectRatio: 0.8,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              itemBuilder: (context, index) {
                ProductModelData item = products[index]!;
                return ProductCard(
                  item: item,
                  favoriteOnTap: () {
                    if (item.isFavorite == true) {
                      removeFavorite(model: item);
                    } else {
                      if (GetStorage().read("token") != null) {
                        addFavorite(model: item);
                      } else {
                        customSnackbar(context,
                            "Favorilere eklemek için önce giriş yapmalısınız.");
                      }
                    }
                  },
                );
              },
            ),
    );
  }
}
