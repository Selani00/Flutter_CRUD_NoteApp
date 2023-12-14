import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:note_crud/styles/app_style.dart';

// ignore: must_be_immutable
class NoteReader extends StatefulWidget {
  NoteReader(this.doc, {super.key});

  QueryDocumentSnapshot doc;

  @override
  State<NoteReader> createState() => _NoteReaderState();
}

class _NoteReaderState extends State<NoteReader> {
  @override
  Widget build(BuildContext context) {
    int colorId = int.tryParse(widget.doc['color_id'].toString()) ?? 0;

    Color backgroundColor =
        colorId >= 0 && colorId < MyColors.cardsColors.length
            ? MyColors.cardsColors[colorId]
            : Colors.grey;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0.0,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.doc["note_title"],
              style: MyColors.mainTitle,
            ),
            SizedBox(height: 4.0),
            Text(
              widget.doc["creation_data"],
              style: MyColors.dateTitle,
            ),
            SizedBox(height: 30.0),
            Text(
              widget.doc["note_content"],
              style: MyColors.mainContent,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
