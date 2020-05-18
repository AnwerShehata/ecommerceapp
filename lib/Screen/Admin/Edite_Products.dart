import 'package:ecommerceapp/Model/Producer.dart';
import 'package:flutter/material.dart';
import 'package:ecommerceapp/Components/myTextField.dart';
import 'package:ecommerceapp/ToolsApp/WidgetApp.dart';
import 'package:ecommerceapp/ToolsApp/StyleApp.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerceapp/Server/Store.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerceapp/Model/Producer.dart';



class EditeProducts extends StatefulWidget {
  static String  id  = 'EditeProducts';
  //هنا ياتي بالقيمة من صفحة ادارة المنتج
  final String name,price,descraption,category,locationImage,proID;

  EditeProducts({this.proID,this.name, this.price, this.descraption, this.category, this.locationImage});
  _EditeProductsState createState() => _EditeProductsState();
}

class _EditeProductsState extends State<EditeProducts> {
  String _name,_price,_descraption,_category,_locationImage;
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  final _store = Store();


  TextEditingController name,price,descraption,category,locationImage= new TextEditingController();
  @override
  void initState() {
    name = TextEditingController(text: widget.name);
    price = TextEditingController(text: widget.price);
    descraption = TextEditingController(text: widget.descraption);
    category = TextEditingController(text: widget.category);
    locationImage = TextEditingController(text: widget.locationImage);
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text("Edite Products"),
      ),

      body: Form(
        key: _globalKey,
        child: ListView(
          children: <Widget>[

            //===== TextField product Name ===============================
            SizedBox(height: height * 0.02),
            myTextField(
              controller: name,
              hint:"Prodect name",
              obscureText: false,prefixIcon: Icons.message,
              textInputType: TextInputType.text, colorfill: Colors.orange.withAlpha(50),
              colorborder: Colors.grey.withAlpha(100),
              onClick: (v){_name = v;},
            ),




            //===== TextField product price ===============================
            SizedBox(height: height * 0.01),
            myTextField(
              controller: price,
              hint:"Prodect price" , obscureText: false,prefixIcon: Icons.message,
              textInputType: TextInputType.text, colorfill: Colors.orange.withAlpha(50),
              colorborder: Colors.grey.withAlpha(100), onClick: (v){_price = v;},
            ),


            //===== TextField Prodect Description ===============================
            SizedBox(height: height * 0.01),
            myTextField(
              controller: descraption,
              hint:"Prodect Description" , obscureText: false,prefixIcon: Icons.message,
              textInputType: TextInputType.text, colorfill: Colors.orange.withAlpha(50),
              colorborder: Colors.grey.withAlpha(100), onClick: (v){_descraption = v;},
              maxLines: 10,
            ),


            //===== TextField Prodect Category ===============================
            SizedBox(height: height * 0.01),
            myTextField(
              controller: category,
              hint:"Prodect Category" , obscureText: false,prefixIcon: Icons.message,
              textInputType: TextInputType.text, colorfill: Colors.orange.withAlpha(50),
              colorborder: Colors.grey.withAlpha(100), onClick: (v){_category = v;},
            ),



            //===== TextField Prodect Location ===============================
            SizedBox(height: height * 0.01),
            myTextField(
              controller: locationImage,
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
                _store.editeProducte(({
                  KeyProdectName: _name,
                  KeyProdectPrice: _price,
                  KeyProdectDescription: _descraption,
                  KeyProdectCategory: _category,
                  KeyProdectLocation: _locationImage
                }), widget.proID);
              }
              Navigator.pop(context);
            }
            )
          ],
        ),
      )
    );
  }


}
