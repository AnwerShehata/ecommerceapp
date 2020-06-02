import 'package:ecommerceapp/Model/Producer.dart';
import 'package:ecommerceapp/provider/cartItem.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Cart_Page extends StatefulWidget {
  static String id = 'Cart_Page';
  @override
  _Cart_PageState createState() => _Cart_PageState();
}

class _Cart_PageState extends State<Cart_Page> {

  int aQu = 1;


  @override
  Widget build(BuildContext context) {
    List<Product> products = Provider.of<CartItem>(context).productes;
    return Scaffold(

      appBar: AppBar(
        title: Text("Cart Page "),
        elevation: 0,
        centerTitle: true,
      ),

      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context ,int index){
          int _price  = int.parse(products[index].proPrice);
          int _quantity  = int.parse(products[index].proQuantity);
          int _resultPrice  = _price * _quantity;
          if(products.isNotEmpty){
            return buildContainer(products, index, _quantity);
          }else{
            return Container(
              child: Text("not Fond Item Cart Page "),
            );
          }
        }),
    );
  }

  Container buildContainer(List<Product> products, int index, int _quantity) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 5,vertical:3),
        height: 100, width: double.infinity,
        color: Colors.grey[200],
        child:Row(
          children: <Widget>[

            new Container(
              padding: EdgeInsets.symmetric(horizontal: 2 ,vertical: 3),
              width: 120,
              height: 130,
              child:Image(fit: BoxFit.fill, image: NetworkImage(products[index].proLocation)),
            ),

            new Expanded(child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        new Text("${products[index].proName}" , style: TextStyle(fontSize: 18)),
                        new Text(" Prise:  ${products[index].proPrice}\$" , style: TextStyle(fontSize: 18)),
                      ],
                    ),
                  ),

                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        new Text("${products[index].proCategory}"),
                        new Row(
                          children: <Widget>[

                            new Text("quantity :${_quantity}",style: TextStyle(fontSize: 20),),

                            new IconButton(icon: Icon(Icons.delete_forever,size: 30, color: Colors.red),
                              onPressed: (){
                                   Provider.of<CartItem>(context,listen: false).removeItem(products[index]);
                            })

                          ],
                        ),
                      ],
                    ),
                  ),

                ],
              ),
            ))
          ],
        )
      );
  }
}
