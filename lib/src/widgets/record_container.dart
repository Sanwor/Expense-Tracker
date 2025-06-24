import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';

class RecordContainer extends StatelessWidget {
  final String title;
  final String description;
  final File itemImage;
  final Double itemPrice;
  final IconData icon;

  const RecordContainer(
      {super.key,
      required this.title,
      required this.description,
      required this.itemImage,
      required this.itemPrice,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
      color: Color(0xffEFE9FD),
      width: double.infinity,
      child: Column(
        children: [
          //title and icon
          Row(children: [
            Text(title),
            IconButton(onPressed: () {}, icon: Icon(Icons.more_vert))
          ]),

          //image and description
          Row(children: [Image.file(itemImage), Text(description)]),

          //price
          Row(children: [Text(itemPrice.toString())]),
        ],
      ),
    );
  }
}
