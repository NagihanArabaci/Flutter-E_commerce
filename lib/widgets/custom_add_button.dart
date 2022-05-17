import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomAddButton extends StatelessWidget {
  Function() onTap;
  CustomAddButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: OutlinedButton(
        onPressed: () => onTap.call(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: const [
            Text(
              "Sepete Ekle",
              style: TextStyle(),
            ),
            Icon(
              FontAwesomeIcons.cartPlus,
              size: 20,
            )
          ],
        ),
      ),
    );
  }
}
