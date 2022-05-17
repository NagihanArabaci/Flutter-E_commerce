import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

void loadingPopup(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return Material(
        type: MaterialType.transparency,
        child: Center(
          child: Lottie.asset("assets/lottie/loading.json"),
        ),
      );
    },
    barrierDismissible: false,
  );
}
