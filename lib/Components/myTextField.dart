import 'dart:core';
import 'dart:core';
import 'package:flutter/material.dart';
import '../ToolsApp/StyleApp.dart';


class myTextField extends StatelessWidget {
  final String hint;
  final String labelText;
  final IconData prefixIcon;
  final TextEditingController controller;
  final bool obscureText;
  final TextInputAction textInputAction;
  final TextInputType textInputType;
  final Function onClick;
  final Color colorfill ;
  final Color colorborder;
  final int maxLines;
  final IconData suffixIcon;
  final Function FunSuffixIcon;

  myTextField({
    this.FunSuffixIcon,this.suffixIcon,this.maxLines,
    this.colorfill,this.colorborder,this.onClick,this.textInputType,this.
    textInputAction,@required this.hint,this.controller,
    this.labelText,this.prefixIcon,this.obscureText});

  String _errorMessage(String srt){
    switch(hint){
      case "Email" : return "Enter Email";
      case "Password" : return "Enter Password";
      case "Full Name" : return "Enter Name";
      case "Prodect name" : return "Enter Prodect name";
      case "Prodect price" : return "Enter Prodect price";
      case "Prodect Description" : return "Enter Prodect Description";
      case "Prodect Category" : return "Enter Prodect Category";
      case "Prodect Location" : return "Prodect Location";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10 ,vertical: 0),
      child: new TextFormField(
        validator: (value){ if(value.isEmpty) return _errorMessage(hint); },
        onSaved: onClick,
        controller: controller,
        obscureText: obscureText == null ? obscureText == false : obscureText== true,
        //لون الايقونة
        cursorColor: Colors.black,
        textInputAction: textInputAction,
        keyboardType: textInputType,
        maxLines: maxLines,
        decoration:InputDecoration(

            suffixIcon: IconButton(icon: suffixIcon==null ? Icon(null) : Icon(suffixIcon), onPressed: FunSuffixIcon ,),
            hintText:hint,
            labelText: labelText,
            prefixIcon: Icon(prefixIcon, color: Colors.amber[800],),
            filled: true,
            fillColor: colorfill,

            //========في حالة الظهور العادي=======================
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: colorborder,width: 1),
              borderRadius: BorderRadius.circular(10),
            ),

            //============في حالة الطغط تظهر هذا التاثيرات
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: anWhite ,width: 1),
              borderRadius: BorderRadius.circular(10),
            ),

          //========في حالة اظهار خطاء=======================
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color:anBlack,width: 1),
            borderRadius: BorderRadius.circular(10),
          ),

          //========في حالة الضغط اظهار خطاء=======================
          focusedErrorBorder:OutlineInputBorder(
            borderSide: BorderSide(color: anBlack ,width: 1),
            borderRadius: BorderRadius.circular(10),
          ),

          errorStyle: TextStyle(color: anBlack)

        ),
      ),
    );
  }
}
