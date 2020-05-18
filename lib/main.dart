import 'package:flutter/material.dart';
import 'package:ecommerceapp/Screen/Register/login_Screen.dart';
import 'package:ecommerceapp/Screen/Register/signUp_Screen.dart';
import 'package:ecommerceapp/Screen/User/HomePage.dart';
import 'package:provider/provider.dart';
import './provider/ModelHud.dart';
import './provider/adminModel.dart';
import 'package:ecommerceapp/Screen/Admin/Add_Products.dart';
import 'package:ecommerceapp/Screen/Admin/Edite_Products.dart';
import 'package:ecommerceapp/Screen/Admin/Manage_Product.dart';
import 'package:ecommerceapp/Screen/Admin/Admin_Home.dart';



void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<adminModel>(create: (context)=> adminModel()),
        ChangeNotifierProvider<ModelHud>(create: (context) => ModelHud())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,


        initialRoute: HomePage.id,
        routes: {
          LoginScreen.id : (context) => LoginScreen(),
          signUp_Screen.id : (context) => signUp_Screen(),
          HomePage.id : (context)=>HomePage(),
          Admin_Home.id : (context)=> Admin_Home(),
          EditeProducts.id :(context)=> EditeProducts(),
          Manage_Product.id:(context)=> Manage_Product(),
          Add_Products.id:(context)=> Add_Products(),
        },


      ),
    );

  }
}
