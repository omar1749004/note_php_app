
import 'package:flutter/src/widgets/framework.dart';
import "package:flutter/material.dart";
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:notic_app/services/api.dart';
import 'package:notic_app/views/home_page.dart';

import '../constant.dart';
import '../main.dart';
import '../widgets/ShowSnackBar.dart';
import '../widgets/custom_botton.dart';
import '../widgets/custome_text_failed.dart';
import 'login_page.dart';


class RegisterPage extends StatefulWidget {
  static String id = "RegisterPage";

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String? email;
  String? userName;
  String? password;
  bool isLoading = false;
  GlobalKey<FormState> formkey = GlobalKey();
   Api api =Api();
  Map<String ,dynamic>? body ;
  
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
       
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Form(
            key: formkey,
            child: ListView(children: [
              const SizedBox(
                height: 75,
              ),
              CircleAvatar(
                radius: 90,
                backgroundImage: AssetImage(
                  "assets/images/Untitled design.png",
                  
                           
                  
                ),
              ),
              SizedBox(height: 20,),
              const Center(
                child: Text(
                  "Note App",
                  style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                      fontFamily: "Pacifico"),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              const Row(
                children: [
                  Text("Register",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      )),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextFailed(
                hintText: "User Name",
                onchange: (data) {
                  userName = data;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextFailed(
                hintText: "Email",
                onchange: (data) {
                  email = data;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextFailed(
                secur: true,
                hintText: "Password",
                onchange: (data) {
                  password = data;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              CustomButton(
                onTap: () async {
                  
                  if (formkey.currentState!.validate()) {
                    isLoading = true;
                  setState(() {});
                  body ={"username": userName , "email" :email, "password" :password};
                  signUp();
                  
                    // try {
                    //   await RegisreUser();
                    //   Navigator.pushNamed(context, ChatPage.ChatPageiId,arguments:email);
                    // } on FirebaseAuthException catch (e) {
                    //   if (e.code == 'weak-password') {
                    //     showSnackBar(
                    //         context, "The password provided is too weak");
                    //   } else if (e.code == 'email-already-in-use') {
                    //     showSnackBar(context,
                    //         "The account already exists for that email");
                    //   }
                    //  isLoading = false;
                    //  setState(() {});
                    // } 
                  }
                  
                  
                },
                title: "Rigester",
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "already have an account ?",
                    style: TextStyle(color: Colors.white),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushReplacementNamed(context, LoginPage.loginId);
                    },
                    child: const Text(
                      "   Log in",
                      style: TextStyle(color: Color(0xffC7EDE7)),
                    ),
                  )
                ],
              ),
            ]),
          ),
        ),
      ),
    );
  }

  // Future<void> RegisreUser() async {
  //   UserCredential user = await FirebaseAuth.instance
  //       .createUserWithEmailAndPassword(email: email!, password: password!);
  // }
  signUp()async {
    Map<String,dynamic> response = await api.post(uri: linkSignUp, body: body, );
    isLoading =false;
    setState(() {
        
      });
    if(response["status"] == "sucsses"){
      sharedPref.setString("id" , response["data"]["id"].toString());
      sharedPref.setString("email" , response["data"]["email"].toString());
      sharedPref.setString("user name" , response["data"]["username"].toString());
      showSnackBar(context,"تم انشاء الحساب يرجى تسجيل الدخول");
      
       Navigator.pushNamedAndRemoveUntil(context,HomePage.homeId,(Route)=>false);
    }
    else{
      print("fail");
    }
  }
}
