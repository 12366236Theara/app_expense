import 'package:flutter/material.dart';

Widget imageContain(String image) {
  return Container(
      padding: EdgeInsets.all(7),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, style: BorderStyle.solid),
          borderRadius: BorderRadius.circular(50)),
      child: Image.asset(
        image,
        alignment: Alignment.center,
        height: 25,
        fit: BoxFit.cover,
      ));
}
