import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:notic_app/auth/register_page.dart';
import 'package:notic_app/constant.dart';
import 'package:notic_app/main.dart';
import 'package:notic_app/services/api.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import '../views/home_page.dart';
import '../widgets/custom_botton.dart';
import '../widgets/custome_text_failed.dart';

class LoginPage extends StatefulWidget {
      static String loginId ="loginId";

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? emailAddress;
  Map<String ,dynamic>? body ;

  String? password;
  bool isLoading = false;
  Api api =Api();
  GlobalKey<FormState> formkey = GlobalKey();
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
                      fontSize: 28,
                      color: Colors.white,
                      fontFamily: "Pacifico"),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              const Row(
                children: [
                  Text("Log in",
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
                hintText: "Email",
                onchange: (data) {
                  emailAddress = data;
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
                title: "Log in",
                onTap: () async {
                  if (formkey.currentState!.validate()) {
                    body = {"email" :emailAddress, "password" :password};
                   isLoading = true;
                    setState(() {
                      
                    });
                    login();

                    // try {
                    //   isLoading = true;
                    //   setState(() {});
                    //   await loginuser();
                    //   //Navigator.pushNamed(context, .ChatPageiId, arguments: emailAddress);
                    // } on FirebaseAuthException catch (e) {
                    //   if (e.code == 'user-not-found') {
                    //     showSnackBar(context, 'No user found for that email.');
                    //   } else if (e.code == 'wrong-password') {
                    //     showSnackBar(
                    //         context, 'Wrong password provided for that user.');
                    //   }
                    //   isLoading = false;
                    //   setState(() {});
                    // }
                  }
                },
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "don't have an account ?",
                    style: TextStyle(color: Colors.white),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, RegisterPage.id);
                    },
                    child: const Text(
                      "Register",
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

  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

//   Future<void> loginuser() async {
//     UserCredential user = await FirebaseAuth.instance
//         .signInWithEmailAndPassword(email: emailAddress!, password: password!);
//   }
login()async{
 

   
   Map<String,dynamic>
 response =  await api.post(uri: linkLogin, body: body);
   isLoading =false;
    setState(() {
        
      });

    if(response["status"] == "sucsses"){
      sharedPref.setString("id" , response["data"]["id"].toString());
      sharedPref.setString("email" , response["data"]["email"].toString());
      sharedPref.setString("user name" , response["data"]["username"].toString());
 
      showSnackBar(context,"تم تسجيل دخول ينجاح");
      Navigator.pushNamedAndRemoveUntil(context,HomePage.homeId,(Route)=>false);
    }else
    {
      AwesomeDialog(btnCancel: Text("Canseled"),
        context: context,title: "تنبيه",body: Text("خطأ في التسجيل"));
    }

}
}
//0xff2B475E
//'No user found for that email.'