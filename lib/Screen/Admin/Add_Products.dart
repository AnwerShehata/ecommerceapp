import 'package:ecommerceapp/Model/Producer.dart';
import 'package:flutter/material.dart';
import 'package:ecommerceapp/Components/myTextField.dart';
import 'package:ecommerceapp/ToolsApp/WidgetApp.dart';
import 'package:ecommerceapp/ToolsApp/StyleApp.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerceapp/Server/Store.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class Add_Products extends StatefulWidget {
  static String  id  = 'AdminPage';
  @override
  _Add_ProductsState createState() => _Add_ProductsState();
}

class _Add_ProductsState extends State<Add_Products> {

  String _name,_price,_descraption,_category,_locationImage;
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  final _store = Store();

  TextEditingController name = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text("Add Products"),
      ),

      body: Form(
        key: _globalKey,
        child: ListView(
          children: <Widget>[

            //===== TextField product Name ===============================
            SizedBox(height: height * 0.02),
            myTextField(
              hint:"Prodect name" , obscureText: false,prefixIcon: Icons.message,
              textInputType: TextInputType.text, colorfill: Colors.orange.withAlpha(50),
              colorborder: Colors.grey.withAlpha(100),
              onClick: (v){_name = v;},
            ),



            //===== TextField product price ===============================
            SizedBox(height: height * 0.01),
            myTextField(
              hint:"Prodect price" , obscureText: false,prefixIcon: Icons.message,
              textInputType: TextInputType.text, colorfill: Colors.orange.withAlpha(50),
              colorborder: Colors.grey.withAlpha(100), onClick: (v){_price = v;},
            ),


            //===== TextField Prodect Description ===============================
            SizedBox(height: height * 0.01),
            myTextField(
              hint:"Prodect Description" , obscureText: false,prefixIcon: Icons.message,
              textInputType: TextInputType.text, colorfill: Colors.orange.withAlpha(50),
              colorborder: Colors.grey.withAlpha(100), onClick: (v){_descraption = v;},
              maxLines: 10,
            ),


            //===== TextField Prodect Category ===============================
            SizedBox(height: height * 0.01),
            myTextField(
              hint:"Prodect Category" , obscureText: false,prefixIcon: Icons.message,
              textInputType: TextInputType.text, colorfill: Colors.orange.withAlpha(50),
              colorborder: Colors.grey.withAlpha(100), onClick: (v){_category = v;},
            ),



            //===== TextField Prodect Location ===============================
            SizedBox(height: height * 0.01),
            myTextField(
              hint:"Prodect Location" , obscureText: false,prefixIcon: Icons.message,
              textInputType: TextInputType.text, colorfill: Colors.orange.withAlpha(50),
              colorborder: Colors.grey.withAlpha(100), onClick: (v){_locationImage = v;},
            ),


            my_Button(
            fontSize: 20,textButton: "Add Prodect",heightButton: 60 , horizontal: 10,
            vertical: 20,radiusButton: 10 ,
            onBtnclicked: (){
              if(_globalKey.currentState.validate()){
                _globalKey.currentState.save();
                _store.addProdect(Product(
                    proName: _name,
                    proPrice: _price,
                    proDescription: _descraption,
                    proCategory: _category,
                    proLocation: _locationImage
                ));
                Navigator.pop(context);
              }
            }
            )
          ],
        ),
      )
    );
  }


}
