import 'package:flutter/material.dart';

class AppBarScreen extends StatelessWidget with PreferredSizeWidget {
  @override
  final Size preferredSize;
  final String text;

  AppBarScreen({Key? key, required this.text})
      : preferredSize = const Size.fromHeight(56.0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Text(
        text,
        style: Theme.of(context)
            .textTheme
            .labelLarge!
            .copyWith(color: Colors.black, fontSize: 17),
      ),
      iconTheme: const IconThemeData(color: Colors.black),
      backgroundColor: Colors.white,
      elevation: 0.5,
    );
  }
}
