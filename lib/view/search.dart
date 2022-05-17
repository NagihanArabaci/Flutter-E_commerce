import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lottie/lottie.dart';
import 'package:n_e_commmerce/service/search_service.dart';
import 'package:n_e_commmerce/widgets/custom_text_field.dart';

import '../model/product_model.dart';
import '../service/favorite_service.dart';
import '../widgets/custom_snackbar.dart';
import '../widgets/loading_popup.dart';
import '../widgets/product_card.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List<ProductModelData?> products = [];
  TextEditingController _search = TextEditingController();

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

  bool isNotSearch = true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    hintText: "Ara..",
                    controller: _search,
                  ),
                ),
                IconButton(
                    onPressed: () {
                      setState(() {
                        isNotSearch = false;
                      });
                      SearchService.fetch(text: _search.text).then((value) {
                        if (value != null && value.status == true) {
                          setState(() {
                            products = value.data!;
                          });
                        }
                      });
                    },
                    icon: const Icon(CupertinoIcons.search))
              ],
            ),
          ),
          const Divider(
            height: 0,
          ),
          //TODO: henüz arama başlatılmadı
          Visibility(
            visible: isNotSearch,
            child: Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: size.height * 0.15),
                child: Lottie.asset("assets/lottie/search_first.json"),
              ),
            ),
          ),

          //TODO: arama sonucu boş
          Visibility(
            visible: !isNotSearch && products.isEmpty ? true : false,
            child: Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: size.height * 0.15),
                child: Lottie.asset("assets/lottie/search_null.json",
                width: size.width * 0.5
                    ),
              ),
            ),
          ),

          //TODO: arama sonucu dolu
          Visibility(
            visible: !isNotSearch,
            child: Expanded(
              child: GridView.builder(
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
            ),
          ),
        ],
      ),
    );
  }
}
