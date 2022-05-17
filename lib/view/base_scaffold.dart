import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:n_e_commmerce/view/basket.dart';
import 'package:n_e_commmerce/view/favorite.dart';
import 'package:n_e_commmerce/view/home.dart';
import 'package:n_e_commmerce/view/profile.dart';
import 'package:n_e_commmerce/view/search.dart';
import 'package:n_e_commmerce/widgets/custom_appbar.dart';
import 'package:n_e_commmerce/widgets/custom_bottom_bar.dart';

class BaseScaffold extends StatefulWidget {
  const BaseScaffold({Key? key}) : super(key: key);

  @override
  State<BaseScaffold> createState() => _BaseScaffoldState();
}

class _BaseScaffoldState extends State<BaseScaffold> {
  final List<BottomNavigationBarItem> _items = [
    const BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.home), label: "Anasayfa"),
    const BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.search), label: "Ara"),
    const BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.bag), label: "Sepet"),
    const BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.heart), label: "Favoriler"),
    const BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.person), label: "Profil"),
  ];

  int _currentIndex = 0;

  Widget _body() {
    switch (_currentIndex) {
      case 0:
        return const Home();
      case 1:
        return const Search();
      case 2:
        return const Basket();
      case 3:
        return Favorite();
      case 4:
        return const Profile();
      default:
        return const Home();
    }
  }

  String _appbarTitle() {
    switch (_currentIndex) {
      case 0:
        return "Anasayfa";
      case 1:
        return "Arama";
      case 2:
        return "Sepet";
      case 3:
        return "Favoriler";
      case 4:
        return "Profil";
      default:
        return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomBottomBar(
        items: _items,
        currentIndex: _currentIndex,
        onTap: (newPageIndex) {
          setState(() {
            _currentIndex = newPageIndex;
          });
        },
      ),
      body: _body(),
      appBar: AppBarScreen(
        text: _appbarTitle(),
      ),
    );
  }
}
