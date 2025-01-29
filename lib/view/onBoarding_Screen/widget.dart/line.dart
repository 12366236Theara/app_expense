import 'package:flutter/material.dart';

Widget lines(Color color) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      line(),
      SizedBox(
        width: 7,
      ),
      Text(
        "OR",

        style: TextStyle(color: color , fontSize: 11) ,
      ),
      SizedBox(
        width: 7,
      ),
      line(),
    ],
  );
}

Widget line() {
  return Container(
    height: 1,
    width: 40,
    color: Colors.grey,
  );
}
