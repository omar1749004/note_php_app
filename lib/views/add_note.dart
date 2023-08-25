
import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:notic_app/constant.dart';
import 'package:notic_app/main.dart';
import 'package:notic_app/widgets/ShowSnackBar.dart';
import '../services/api.dart';
import 'home_page.dart';
import 'package:image_picker/image_picker.dart';

class AddNotesPage extends StatefulWidget {
  const AddNotesPage({super.key});
  static String addPageId = "addnotespage";
  @override
  State<AddNotesPage> createState() => _AddNotesPageState();
}

class _AddNotesPageState extends State<AddNotesPage> {
  File? myfile;
  Api api = Api();
  GlobalKey<FormState> formStat = GlobalKey();
  TextEditingController content = TextEditingController();
  TextEditingController title = TextEditingController();
  TextEditingController color = TextEditingController();

  bool? isLoading = false;
  addNote() async {
    if(myfile == null)
      {
        return AwesomeDialog(context: context ,title: "wrong",body: Text("please enter image"))..show();
       }
       else{
        try {
          isLoading = true;
                                      setState(() {});
      var response = await api.postFile(uri: linkAddNote, body: {
        "n_title": title.text,
        "n_content": content.text,
        "id": sharedPref.getString("id"),
      }, file:  myfile!);
      isLoading = false;
      setState(() {});
      if (response["status"] == "sucsses") {
        showSnackBar(context, "Note Added succses");
        Navigator.pushReplacementNamed(context, HomePage.homeId);
      }
    } catch (e) {
      print(e);
    }
       }
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Add Notes"),
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
                                                XFile? xFile =await ImagePicker().pickImage(source: ImageSource.gallery);
                                                myfile =File(xFile!.path);
                                                Navigator.pop;
                                                setState(() {
                                                  
                                                });
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
                                                InkWell( onTap: () async {
                                                XFile? xFile =await ImagePicker().pickImage(source: ImageSource.camera);
                                                myfile =File(xFile!.path);
                                                Navigator.of(context).pop();
                                                setState(() {
                                                  
                                                });
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
                                color:myfile==null? Colors.blue:Colors.green,
                              ),
                            ),
                          ],
                        ),Row(
                          children: [
                            Expanded(
                              child: MaterialButton(
                                textColor: Colors.white,
                                onPressed: () async {
                                  try {
                                    if (formStat.currentState!.validate()) {
                                      
                                      
                                      addNote();
                                    }
                                  } catch (e) {
                                    print(e);
                                  }
                                },
                                child: Text("Add note"),
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
