import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomtextField extends StatelessWidget {
  final TextEditingController textEditingController;
  final TextInputType textInputType;
  final String hintText;
  final String labelText;
  final Icon icon;
  final Widget suffix;
  final TextStyle textStyle;
  final bool obscureText;
  final int maxLines;


  CustomtextField({this.hintText,
    this.textEditingController,
    this.textInputType = TextInputType.text,
    this.labelText,
    this.icon,
    this.suffix,
    this.textStyle,
    this.obscureText = false,
    this.maxLines = 1,
    });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 15, right: 15),
      width: 350,
      child: TextField(
        controller: this.textEditingController,
        style: this.textStyle,
        obscureText: this.obscureText,
        maxLines: this.maxLines,
        keyboardType: this.textInputType,
        decoration: InputDecoration(
          labelText: this.labelText,
          suffix: this.suffix,
          hintText: this.hintText,
          icon: this.icon,
        ),
      ),
    );
  }
}
