
import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController textController;
  final VoidCallback onPressed;
  final String hintText;

  AppTextField(this.textController,this.hintText,{@required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
        controller: textController,
        autofocus: false,
        maxLines: 1,
        style: TextStyle(),
        decoration: new InputDecoration(
            hintStyle: TextStyle(color: Color(0xffBDBDBD)),
            hintText: this.hintText,
            filled: true,
            fillColor: Color(0xffF7F7F7),
            suffixIcon: Container(
              margin: EdgeInsets.only(right: 8.0),
              decoration: BoxDecoration(
                  color: Colors.black, borderRadius: BorderRadius.circular(25.0)),
              child: IconButton(
                icon: Icon(Icons.arrow_forward),
                onPressed: onPressed,
                color: Colors.white,
              ),
            ),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xffF7F7F7), width: 1.0),
                borderRadius:
                const BorderRadius.all(const Radius.circular(30.0))),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xffBDBDBD), width: 1.0),
                borderRadius:
                const BorderRadius.all(const Radius.circular(30.0)))),
      ),
    );;
  }
}
