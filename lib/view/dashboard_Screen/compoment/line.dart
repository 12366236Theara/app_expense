import 'package:flutter/material.dart';

Widget line() {
  return Column(
    children: [
      Row(
        children: [
          Container(
            height: 10,
            width: 10,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50), color: Colors.red),
          ),
          SizedBox(
            width: 10,
          ),
          Text("Min")
        ],
      ),
      Row(
        children: [
          Container(
            height: 10,
            width: 10,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50), color: Colors.indigo),
          ),
          SizedBox(
            width: 10,
          ),
          Text("Mix")
        ],
      ),
      Row(
        children: [
          Container(
            height: 10,
            width: 10,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.blueGrey),
          ),
          SizedBox(
            width: 10,
          ),
          Text("Others")
        ],
      ),
    ],
  );
}
