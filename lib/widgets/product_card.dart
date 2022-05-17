import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:n_e_commmerce/constant/constant.dart';
import 'package:n_e_commmerce/service/basket_service.dart';
import 'package:n_e_commmerce/view/product_detail.dart';
import 'package:n_e_commmerce/widgets/custom_snackbar.dart';

import '../model/product_model.dart';
import 'custom_add_button.dart';

class ProductCard extends StatelessWidget {
  Function()? favoriteOnTap;
  ProductCard({Key? key, required this.item, this.favoriteOnTap})
      : super(key: key);

  final ProductModelData item;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      borderRadius: BorderRadius.circular(15),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductDetail(productId: item.id!),
            ));
      },
      child: Stack(
        children: [
          Card(
            color: Colors.white,
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Hero(
                      tag: item.image!,
                      child: Image.network(
                        "${Constant.imageBaseUrl}uploads/products/${item.image}",
                        fit: BoxFit.cover,
                        width: size.width * 0.21,
                        height: size.width * 0.21,
                        errorBuilder: (context, objec, stackTree) {
                          return SizedBox(
                              width: size.width * 0.21,
                              height: size.width * 0.21,
                              child: const Icon(Icons.error_outline));
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: Text(
                      item.title!,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(fontWeight: FontWeight.bold),
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 8, right: 8, bottom: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Fiyat:",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                  fontWeight: FontWeight.normal,
                                  color: Colors.grey),
                        ),
                        Text(
                          "${item.price} ₺",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Expanded(child: CustomAddButton(
                    onTap: () {
                      BasketService.addBasket(productId: item.id!)
                          .then((value) {
                        if (value != null && value.status == true) {
                          customSnackbar(context,
                              "${item.title} başarıyla sepete eklendi");
                        } else {
                          customSnackbar(context,
                              "${item.title} sepete eklenirken sorun oluştu.");
                        }
                      });
                    },
                  )),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: GestureDetector(
              onTap: () => favoriteOnTap?.call(),
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(color: Colors.black12, blurRadius: 10)
                    ]),
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  item.isFavorite == true
                      ? CupertinoIcons.heart_fill
                      : CupertinoIcons.heart,
                  color: item.isFavorite == true ? Colors.red : Colors.grey,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
