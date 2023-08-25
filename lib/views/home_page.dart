import 'package:flutter/material.dart';
import 'package:notic_app/auth/register_page.dart';
import 'package:notic_app/constant.dart';
import 'package:notic_app/main.dart';
import 'package:notic_app/models/note_model.dart';
import 'package:notic_app/services/api.dart';
import 'package:notic_app/views/add_note.dart';
import 'package:notic_app/views/edite_page.dart';

import '../widgets/ShowSnackBar.dart';
import '../widgets/noteItem.dart';
import '../widgets/searchIcone.dart';

class HomePage extends StatefulWidget {
  static String homeId = "homeId";
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Api api = Api();
  bool isloading = false;

  Future<List<dynamic>> getNote() async {
    return await api
        .post(uri: linkReadNote, body: {"id": sharedPref.getString("id")});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () async {
            await Navigator.pushNamed(context, AddNotesPage.addPageId);
            setState(() {});
          },
        ),
        appBar: AppBar(
          actions: [
            CustomeSearchIcone(),
            IconButton(
                onPressed: () {
                  sharedPref.clear();
                  Navigator.pushNamedAndRemoveUntil(
                      context, RegisterPage.id, (route) => false);
                },
                icon: Icon(Icons.exit_to_app))
          ],
          elevation: 0,
          title: Text(
            "Notes",
            style: TextStyle(fontSize: 26),
          ),
        ),
        body: isloading == true
            ? Center(child: CircularProgressIndicator())
            : FutureBuilder<List<dynamic>>(
                future: getNote(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<NoteModel> notes = []; //snapshot.data!;

                    for (int i = 0; i < snapshot.data!.length; i++) {
                      notes.add(NoteModel.fromjsone(snapshot.data![i]));
                    }

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: ListView.builder(
                          itemCount: notes.length,
                          shrinkWrap: true,
                          itemBuilder: (context, itemcount) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: NoteItem(
                                  notemodel: notes[itemcount],
                                  delete: () async {
                                    try {
                                      
                                      var response = await Api()
                                          .post(uri: linkDeleteNote, body: {
                                        "id": notes[itemcount].nId
                                            .toString(),
                                            "imageName" :notes[itemcount].imageNmae
                                            .toString(),
                                          
                                      });
                                      if (response["status"] == "sucsses") {
                                        showSnackBar(
                                            context, "Note Delete succses");
                                        Navigator.pushReplacementNamed(
                                            context, HomePage.homeId);
                                      }
                                    }  catch (e) {
                                      print(e);
                                    }
                                  },
                                  edite: () {
                                    print(notes[itemcount]);
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) => EditePage(
                                                notemodel: notes[itemcount])));
                                  }),
                            );
                          }),
                    );
                  } else {
                    return Container();
                  }
                }));
  }
}
