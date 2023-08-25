import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class CustomTextFailed extends StatelessWidget {
   CustomTextFailed({this.hintText,this.onchange, this.secur = false});
  final String? hintText;
  final Function(String)? onchange;
  final bool? secur ;
  @override
  Widget build(BuildContext context) {
    
    return TextFormField(
      obscureText: secur!,
      validator: (value) {
        if(value?.isEmpty ?? true){
          return "field is required";
        }
        else return null;
        
      },
      onChanged: onchange,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle:const TextStyle(color: Colors.white),
            enabledBorder:const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white)
            ),
            border:const OutlineInputBorder(),
            
          ),
          
        );
  }
}