import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ecommerceapp/ToolsApp/StyleApp.dart';
import 'package:ecommerceapp/ToolsApp/WidgetApp.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../Admin/Manage_Product.dart';
import 'package:ecommerceapp/Screen/Admin/Admin_Home.dart';
import 'package:ecommerceapp/Screen/Admin/Add_Products.dart';


class Admin_Home extends StatefulWidget {
  static String id = "AdminHome";
  @override
  _Admin_HomeState createState() => _Admin_HomeState();
}

class _Admin_HomeState extends State<Admin_Home> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text("Admin Home"),
      ),

      body: Center(
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

                my_Button(
                  horizontal: 50,vertical: 10, textButton: "Add Prodecut", colorButton: Colors.blue,
                  fontSize: 20, radiusButton: 20, heightButton: 60,
                  onBtnclicked: (){ Navigator.pushNamed(context,Add_Products.id); }
                  ),

                my_Button(
                  horizontal: 50,vertical: 10, textButton: "Manage Product", colorButton: Colors.amber,
                  fontSize: 20, radiusButton: 20, heightButton: 60,
                  onBtnclicked: (){ Navigator.pushNamed(context, Manage_Product.id); }
                  ),

          ],
        )),


    );

  }
}