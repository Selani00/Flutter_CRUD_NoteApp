import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note_crud/screens/note_editor.dart';
import 'package:note_crud/screens/note_editor_existing.dart';
import 'package:note_crud/screens/note_reader.dart';
import 'package:note_crud/styles/app_style.dart';
import 'package:note_crud/widgets/note_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: MyColors.mainColor,
        appBar: AppBar(
          elevation: 0.0,
          title: Text("FireNotes",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold)),
          centerTitle: true,
          backgroundColor: MyColors.mainColor,
        ),
        body: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Your recent Notes",
                  style: GoogleFonts.roboto(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 22),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection("Notes")
                        .snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      //checking the connection state , if we still load the data we can display
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (snapshot.hasData) {
                        return GridView(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2),
                          children: snapshot.data!.docs
                              .map((note) => noteCard(() {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ExistingNoteEditorScreen(note),
                                        ));
                                  }, note))
                              .toList(),
                        );
                      }
                      return Text(
                        "there's no Notes",
                        style: GoogleFonts.nunito(color: Colors.white),
                      );
                    },
                  ),
                )
              ]),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => NoteEditorScreen()));
          },
          label: Text("Add Note"),
          icon: Icon(Icons.add),
        ));
  }
}
