import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomTextField extends StatefulWidget {
  String? hintText;
  TextEditingController? controller;
  TextInputType? keyboardType;
  bool isPassword;
  bool passwordField;

  CustomTextField({
    this.controller,
    this.keyboardType,
    this.hintText,
    this.isPassword = false,
    this.passwordField = false,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      obscureText: widget.isPassword,
      decoration: InputDecoration(
        hintText: widget.hintText,
        border: _border(),
        disabledBorder: _border(),
        enabledBorder: _border(),
        focusedBorder: _border(),
        filled: true,
        fillColor: Colors.grey.shade200,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        suffixIcon: widget.passwordField
            ? GestureDetector(
                onTap: () {
                  setState(() {
                    widget.isPassword = !widget.isPassword;
                  });
                },
                child: Icon(widget.isPassword
                    ? FontAwesomeIcons.eye
                    : FontAwesomeIcons.eyeSlash),
              )
            : null,
      ),
    );
  }

  OutlineInputBorder _border() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: const BorderSide(color: Colors.grey, width: 0.5),
    );
  }
}
