import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:note_crud/styles/app_style.dart';

class NoteEditorScreen extends StatefulWidget {
  const NoteEditorScreen({super.key});

  @override
  State<NoteEditorScreen> createState() => _NoteEditorScreenState();
}

class _NoteEditorScreenState extends State<NoteEditorScreen> {
  int color_id = Random().nextInt(MyColors.cardsColors.length);
  String date = DateTime.now().toString();

  TextEditingController _titleController = TextEditingController();
  TextEditingController _mainController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.cardsColors[color_id],
      appBar: AppBar(
        backgroundColor: MyColors.cardsColors[color_id],
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          "Add a new Note",
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
              keyboardType: TextInputType.multiline,
              maxLines: null,
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
            FirebaseFirestore.instance
                .collection("Notes")
                .add({
                  "note_title": _titleController.text,
                  "creation_data": date,
                  "note_content": _mainController.text,
                  "color_id": color_id.toString(),
                })
                .then((value) => {print(value.id), Navigator.pop(context)})
                .catchError(
                    (error) => print("Failed to add new note due to $error"));
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
