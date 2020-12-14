import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintValue;
  final Function onChanged;
  final TextInputType keyboard;
  CustomTextField({this.hintValue, this.onChanged, this.keyboard});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      child: TextField(
        keyboardType: keyboard,
        autocorrect: false,
        textCapitalization: TextCapitalization.none,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
          fillColor: Colors.white,
          filled: true,
          labelText: hintValue,
          labelStyle: TextStyle(color: Colors.black),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20.0),
            ),
          ),
        ),
        onChanged: onChanged,
      ),
    );
  }
}
