import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:note_crud/styles/app_style.dart';

Widget noteCard(Function()? onTap, QueryDocumentSnapshot doc) {
  int? colorId =
      int.tryParse(doc['color_id'].toString() ?? ''); // Convert string to int

  Color selectedColor =
      colorId != null && colorId >= 0 && colorId < MyColors.cardsColors.length
          ? MyColors.cardsColors[colorId]
          : Colors.grey; // Default color if index is invalid

  return InkWell(
    onTap: onTap,
    child: Container(
      padding: EdgeInsets.all(8.0),
      margin: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: selectedColor,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            doc["note_title"],
            style: MyColors.mainTitle,
          ),
          SizedBox(
            height: 4.0,
          ),
          Text(
            doc["creation_data"],
            style: MyColors.dateTitle,
          ),
          SizedBox(
            height: 8.0,
          ),
          Text(
            doc["note_content"],
            style: MyColors.mainContent,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    ),
  );
}
