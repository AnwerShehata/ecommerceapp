import 'package:flutter/material.dart';
import 'package:ecommerceapp/Model/Producer.dart';
import 'package:ecommerceapp/ToolsApp/WidgetApp.dart';
import 'package:ecommerceapp/ToolsApp/StyleApp.dart';
import 'package:ecommerceapp/FuncationApp/Funcation_App.dart';

class product_detalis extends StatefulWidget {
  static String id  ='product_detalis';
  @override
  _product_detalisState createState() => _product_detalisState();
}

class _product_detalisState extends State<product_detalis> {
  int _quantity = 1;


  void _funAdd(Product product) {
    setState(() {
      if(_quantity < int.parse(product.proQuantity)) {
        _quantity ++;
      }
    });
  }

  void _funRemove(Product product) {
   setState(() {
     if(_quantity > 1){
       _quantity --;
     }
   });
  }

  @override
  Widget build(BuildContext context) {
    Product product = ModalRoute.of(context).settings.arguments;
    double heightQuery = MediaQuery.of(context).size.height;
    int price = int.parse(product.proPrice) * int.parse(_quantity.toString());
    return Scaffold(

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.grey,
        title: Text(product.proName),
        centerTitle: true,
      ),

      bottomNavigationBar: Builder(
        builder: (context) =>Container(
          height: 70, color: anOrange,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              my_ButtonIcon(
                  textButton: "favorite" ,
                  icon: Icons.favorite_border,
                  colorBorderSide: anOrange,
                  colorButton: anOrange, onPressed: (){}),

              my_ButtonIcon(textButton: "Add To Cart" ,
                  icon: Icons.shopping_cart,
                  colorBorderSide: anOrange ,
                  colorButton: anOrange,
                  onPressed: (){

                funAddToCart(product,context,_quantity);
                product.proQuantity = _quantity.toString();
                product.proPrice = price.toString();

                }),
            ],
          ),
        ),
      ),



      body: ListView(
        children: <Widget>[

          //===Image Box ==============================
          Container(
            height: heightQuery*0.70,
            decoration: BoxDecoration(
                image: DecorationImage(fit: BoxFit.fill,image: NetworkImage(product.proLocation))
            ),
          ),

          Container(
            padding: EdgeInsets.symmetric(horizontal: 10 , vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new Text("${price}\$" , style: TextStyle(fontSize: 30),),
                new Row(
                  children: <Widget>[

                    InkWell(
                      onTap:(){_funAdd(product);},
                      child: new CircleAvatar(backgroundColor: Colors.red,
                      child: Icon(Icons.add),maxRadius: 15,)
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal:3),
                      child: new Text(_quantity.toString() , style: TextStyle(fontSize: 40),),
                    ),

                    InkWell(
                        onTap:(){_funRemove(product);},
                        child: new CircleAvatar(backgroundColor: Colors.red,
                          child: Icon(Icons.remove),maxRadius: 15,)
                    ),

                  ],
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: new Text(product.proCategory),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: new Text(product.proDescription),
          ),


        ],
      ),

    );
  }
}
