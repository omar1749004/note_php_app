
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showSnackBar(BuildContext context,String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      
      SnackBar(
        content: Center(
          child: Text(message,
              ),
        ) ,)   )   ;
}