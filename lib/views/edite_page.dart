import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:notic_app/constant.dart';
import 'package:notic_app/models/note_model.dart';
import 'package:notic_app/widgets/ShowSnackBar.dart';

import '../services/api.dart';
import 'home_page.dart';

class EditePage extends StatefulWidget {
  final NoteModel? notemodel;
  const EditePage({super.key, this.notemodel});
  static String ePageId = "editePage";
  @override
  State<EditePage> createState() => _EditePageState();
}

class _EditePageState extends State<EditePage> {
  Api api = Api();
  GlobalKey<FormState> formStat = GlobalKey();
  TextEditingController content = TextEditingController();
  TextEditingController title = TextEditingController();
  TextEditingController color = TextEditingController();
  File? myfile;
  bool? isLoading = false;
  editeNote() async {
    try {

     var response;
      if(myfile==null)
      {
        response = await api.post(uri: linkEditeNote, body: {
        "n_id": widget.notemodel!.nId.toString(),
        "n_title": title.text,
        "n_content": content.text,
        "imageName":widget.notemodel!.imageNmae.toString(),
      },);
      }else{
        response = await api.postFile(uri: linkEditeNote, body: {
        "n_id": widget.notemodel!.nId.toString(),
        "n_title": title.text,
        "n_content": content.text,
        "imageName":widget.notemodel!.imageNmae.toString(),
      },file: myfile!);
      }
       
      isLoading = false;
      setState(() {});
      if (response["status"] == "sucsses") {
        showSnackBar(context, "Note Added succses");
        Navigator.pushReplacementNamed(context, HomePage.homeId);
      } else {
        showSnackBar(context, "please edite note");
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    title.text = widget.notemodel!.nTitle;
    content.text = widget.notemodel!.nContent;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Edite Notes"),
        ),
        body: isLoading == true
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    key: formStat,
                    child: Column(
                      children: [
                        TextFormField(
                          validator: (value) {
                            if (value?.isEmpty ?? true) {
                              return "please enter title";
                            } else
                              return null;
                          },
                          controller: title,
                          decoration: InputDecoration(hintText: "title"),
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value?.isEmpty ?? true) {
                              return "please enter content note";
                            } else
                              return null;
                          },
                          controller: content,
                          decoration: InputDecoration(hintText: "content"),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: MaterialButton(
                                textColor: Colors.white,
                                onPressed: () {
                                  try {
                                    showModalBottomSheet(
                                      context: context,
                                      builder: (context) {
                                        return Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            height: 80,
                                            child: Column(
                                              children: [
                                                InkWell(
                                                  onTap: () async {
                                                    XFile? xFile =
                                                        await ImagePicker()
                                                            .pickImage(
                                                                source:
                                                                    ImageSource
                                                                        .gallery);
                                                    myfile = File(xFile!.path);
                                                    Navigator.pop;
                                                    setState(() {});
                                                  },
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    width: double.infinity,
                                                    child: Text(
                                                      "fom gallrey",
                                                      style: TextStyle(
                                                          fontSize: 20),
                                                    ),
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () async {
                                                    XFile? xFile =
                                                        await ImagePicker()
                                                            .pickImage(
                                                                source:
                                                                    ImageSource
                                                                        .camera);
                                                    myfile = File(xFile!.path);
                                                    Navigator.of(context).pop();
                                                    setState(() {});
                                                  },
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    width: double.infinity,
                                                    padding: EdgeInsets.only(
                                                        top: 10),
                                                    child: Text(
                                                      "fom camera",
                                                      style: TextStyle(
                                                          fontSize: 20),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  } catch (e) {
                                    print(e);
                                  }
                                },
                                child: Text("choose image "),
                                color:
                                    myfile == null ? Colors.blue : Colors.green,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: MaterialButton(
                                textColor: Colors.white,
                                onPressed: () async {
                                  try {
                                    if (formStat.currentState!.validate()) {
                                      // isLoading =true;
                                      // setState(() {
                                        
                                      // });
                                      editeNote();
                                    }
                                  } catch (e) {
                                    print(e);
                                  }
                                },
                                child: Text("Edite note"),
                                color: Colors.blue,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ));
  }
}
