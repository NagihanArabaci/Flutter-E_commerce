import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:n_e_commmerce/constant/constant.dart';
import 'package:n_e_commmerce/model/basket_model.dart';
import 'package:n_e_commmerce/service/basket_service.dart';
import 'package:n_e_commmerce/view/home.dart';
import 'package:n_e_commmerce/view/product_detail.dart';
import 'package:n_e_commmerce/widgets/custom_button.dart';
import 'package:n_e_commmerce/widgets/custom_snackbar.dart';

class Basket extends StatefulWidget {
  const Basket({Key? key}) : super(key: key);

  @override
  State<Basket> createState() => _BasketState();
}

class _BasketState extends State<Basket> {
  BasketModelData? products;

  bool isLoading = false;

  void getBasket() {
    setState(() {
      isLoading = false;
    });
    BasketService.fetch().then((value) {
      if (value != null && value.status == true) {
        products = value.data;
        setState(() {
          isLoading = true;
        });
      } else {
        customSnackbar(context, "Bir sorun oluştu");
        Navigator.pop(context);
        setState(() {
          isLoading = true;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getBasket();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: isLoading == false
          ? const LoadingWidget()
          : ListView(
              padding: const EdgeInsets.symmetric(vertical: 11),
              children: [
                ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 15,
                  ),
                  shrinkWrap: true,
                  padding:
                      const EdgeInsets.only(right: 11, left: 11, bottom: 11),
                  itemCount: products!.products!.length,
                  itemBuilder: (context, index) {
                    BasketModelDataProducts item = products!.products![index]!;
                    return Dismissible(
                      key: Key(item.title!),
                      secondaryBackground: slideLeftBackground(),
                      background: slideLeftBackground(),
                      confirmDismiss: (direction) async {
                        if (direction == DismissDirection.endToStart) {
                          final bool res = await showCupertinoDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return CupertinoAlertDialog(
                                  title: const Text("Sil"),
                                  content: Text(
                                      "${item.title} silmek istiyor musunuz?"),
                                  actions: [
                                    CupertinoDialogAction(
                                        child: const Text("Evet"),
                                        onPressed: () {
                                          BasketService.deleteBasket(
                                                  productId: item.productId!)
                                              .then((value) {
                                            if (value != null &&
                                                value.status == true) {
                                              setState(() {
                                                products!.products!
                                                    .remove(item);
                                              });
                                            } else {
                                              customSnackbar(
                                                  context, "Bir sorun oluştu");
                                            }
                                          });
                                          Navigator.of(context).pop();
                                        }),
                                    CupertinoDialogAction(
                                        child: const Text("Hayır"),
                                        onPressed: () {
                                          setState(() {});
                                          Navigator.of(context).pop();
                                        })
                                  ],
                                );
                              });
                          return res;
                        } else {
                        }
                        return null;
                      },
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ProductDetail(productId: item.productId!),
                            ),
                          );
                        },
                        child: SizedBox(
                          height: size.height * 0.15
                          ,
                          child: Card(
                            child: IntrinsicHeight(
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Hero(
                                      tag: item.image!,
                                      child: Image.network(
                                        "${Constant.imageBaseUrl}uploads/products/${item.image}",
                                        fit: BoxFit.cover,
                                        width: size.width * 0.3,
                                        height: size.height * 0.12,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Text(
                                            item.title!,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge,
                                            maxLines: 2,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "Fiyat:",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge!
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        color: Colors.grey),
                                              ),
                                              const SizedBox(
                                                width: 20,
                                              ),
                                              Text(
                                                "${products!.totalPrice} ₺",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge!
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                if (item.productQuantity !=
                                                    null) {
                                                  item.productQuantity =
                                                      item.productQuantity! + 1;
                                                  getBasket();
                                                }
                                              });
                                            },
                                            child: const Icon(CupertinoIcons.add),
                                          ),
                                          Text(
                                            item.productQuantity.toString(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                if (item.productQuantity !=
                                                    null) {
                                                  if (item.productQuantity! > 1) {
                                                    item.productQuantity =
                                                        item.productQuantity! - 1;
                                                    getBasket();
                                                  }
                                                }
                                              });
                                            },
                                            child: const Icon(Icons.remove),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Toplam Tutar:",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      Text(
                        "${products?.totalPrice ?? 0.0} ₺",
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: CustomButton(text: "Sipariş Ver"),
                )
              ],
            ),
    );
  }

  Widget slideLeftBackground() {
    return Container(
      color: Colors.red,
      child: Align(
        alignment: Alignment.centerRight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: const <Widget>[
            Icon(
              Icons.delete,
              color: Colors.white,
            ),
            Text(
              " Sil",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.right,
            ),
            SizedBox(
              width: 20,
            ),
          ],
        ),
      ),
    );
  }
}
