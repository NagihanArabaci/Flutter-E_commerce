import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  Function()? onTap;
  String text;
  Color? color;
  Color? textColor;
  CustomButton({
    required this.text,
    this.onTap,
    this.color,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      height: 45,
      child: ElevatedButton(
        onPressed: () => onTap?.call(),
        style: ElevatedButton.styleFrom(
          primary: color ?? Color(0xFF4AC4A9),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: Text(
          text,
          style: Theme.of(context).textTheme.labelLarge!.copyWith(
                color: textColor ?? Colors.white,
                fontSize: 16,
              ),
        ),
      ),
    );
  }
}
