import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class CustomButton extends StatelessWidget {
   CustomButton({ this.onTap,required this.title}) ;
  final String title;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:onTap,
      child: Container(
              decoration: BoxDecoration(
                 color: Colors.white.withOpacity(.2),
                 
                borderRadius: BorderRadius.circular(8)
              ),
            child: Center(child: Text(title,
            style:const TextStyle(
              fontSize: 25,
              
            ),
            )),
            height: 60,
             width: double.infinity,
            
            ),
    );
  }
}