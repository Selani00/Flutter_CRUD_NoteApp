import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:note_crud/styles/app_style.dart';

class ExistingNoteEditorScreen extends StatefulWidget {
  final String? documentId;

  ExistingNoteEditorScreen(this.doc, {super.key, this.documentId});

  QueryDocumentSnapshot doc;

  @override
  State<ExistingNoteEditorScreen> createState() =>
      _ExistingNoteEditorScreenState();
}

class _ExistingNoteEditorScreenState extends State<ExistingNoteEditorScreen> {
  String date = DateTime.now().toString();

  TextEditingController _titleController = TextEditingController();
  TextEditingController _mainController = TextEditingController();

  void initState() {
    super.initState();
    // Check if the value exists in widget.doc, then assign it to the controller
    if (widget.doc["note_title"] != null) {
      _titleController.text = widget.doc["note_title"];
    }

    if (widget.doc["note_content"] != null) {
      _mainController.text = widget.doc["note_content"];
    }
  }

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
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          "Update Notes",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
          padding: EdgeInsets.all(16.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Note Title',
              ),
              style: MyColors.mainTitle,
            ),
            SizedBox(
              height: 8.0,
            ),
            Text(
              date,
              style: MyColors.dateTitle,
            ),
            SizedBox(
              height: 28.0,
            ),
            TextField(
              controller: _mainController,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Note Content',
              ),
              style: MyColors.mainContent,
            ),
          ])),
      floatingActionButton: Transform.scale(
        scale: 1.3,
        child: FloatingActionButton(
          onPressed: () async {
            if (widget.documentId != null) {
              FirebaseFirestore.instance
                  .collection("Notes")
                  .doc(widget.documentId) // Use the document ID to update
                  .update({
                    "note_title": _titleController.text,
                    "creation_data": date,
                    "note_content": _mainController.text,
                    "color_id": backgroundColor,
                  })
                  .then((_) => Navigator.pop(context))
                  .catchError(
                      (error) => print("Failed to update note due to $error"));
            } else {
              print("Document ID is null, unable to update.");
            }
          },
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          child: Icon(
            Icons.save,
            size: 32,
          ),
        ),
      ),
    );
  }
}
