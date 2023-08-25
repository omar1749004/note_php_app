import 'package:flutter/material.dart';

class CustomeSearchIcone extends StatelessWidget {
  const CustomeSearchIcone({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 30,
        width: 40,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(.08),
         borderRadius: BorderRadius.circular(16)  
        ),
        child: Center(
          child: Icon(Icons.search,size: 25,)
        ,),
      ),
    );
  }
}