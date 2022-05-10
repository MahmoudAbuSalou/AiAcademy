import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'const.dart';


class LogginTextField extends StatelessWidget {
  final String title;
  final String iconPath;
  Function valid;
  TextEditingController controller;
  final bool obSecureText;

  LogginTextField(
      {Key? key,
        required this.title,
        required this.iconPath,
        required this.controller,
        required this.valid,
        this.obSecureText = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 5),
            spreadRadius: 0,
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        validator: (String ?value) {
          return valid(value);

        },
        obscureText: obSecureText,
        style: const TextStyle(
          color: Colors.black,
          fontFamily: kFontFamily,
        ),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          prefixIcon: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: SvgPicture.asset(
              iconPath,
              fit: BoxFit.none,
              width: 10,
              height: 10,
            ),
          ),
          label: Text(
            title,
            style: TextStyle(
              color: Colors.black54,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
