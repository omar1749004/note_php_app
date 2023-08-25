import 'package:flutter/material.dart';
import 'package:notic_app/auth/login_page.dart';
import 'package:notic_app/views/add_note.dart';
import 'package:notic_app/views/edite_page.dart';
import 'package:notic_app/views/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'auth/register_page.dart';

late SharedPreferences  sharedPref;
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  sharedPref =await SharedPreferences.getInstance();
  runApp(  MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
        appBarTheme: AppBarTheme(
          color: Colors.grey[850]),
          fontFamily: "Poppins"
      ),
      initialRoute: sharedPref.getString("id")==null ? RegisterPage.id :HomePage.homeId,
      routes: {
        AddNotesPage.addPageId : (context)=> AddNotesPage(),
        EditePage.ePageId :(context) => EditePage(),
        LoginPage.loginId:(context) => LoginPage(),
        RegisterPage.id :(context) => RegisterPage(),
        HomePage.homeId :(context) => HomePage()
      },
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }

}
