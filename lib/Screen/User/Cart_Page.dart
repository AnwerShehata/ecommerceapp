import 'package:ecommerceapp/Model/Producer.dart';
import 'package:ecommerceapp/provider/cartItem.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ecommerceapp/Model/Producer.dart';


class Cart_Page extends StatefulWidget {
  static String id = 'Cart_Page';
  @override
  _Cart_PageState createState() => _Cart_PageState();
}

class _Cart_PageState extends State<Cart_Page> {


  int aQu = 1;
  var price ;

  void _showCustemDilog(List<Product> productes , BuildContext context)async{
    price = getTotelPrice(productes);
    AlertDialog alertDialog = AlertDialog(
      actions: <Widget>[
        FlatButton(onPressed: (){}, child: Text("add"))
      ],
      content: TextFormField(
        decoration: InputDecoration(
          hintText: 'add your Addres'
        ),
      ),
      title: Text("$price"),
    );
    await showDialog(
        context: context,
        builder: (context){
          return alertDialog;
        }
    );

  }

  getTotelPrice(List<Product> productes) {
    var price = 0;
    for(var product in productes){
      price += int.parse(product.proQuantity) * int.parse(product.proPrice);
    }
    return price;
  }

  @override
  Widget build(BuildContext context) {
    List<Product> products = Provider.of<CartItem>(context).productes;

    return Scaffold(

      appBar: AppBar(
        elevation: 0,
      ),

      body: Column(
        children: <Widget>[

          new Expanded(
              child: ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (context ,int index){
                    int _price  = int.parse(products[index].proPrice);
                    int _quantity  = int.parse(products[index].proQuantity);
                    int _resultPrice  = _price * _quantity;
                    if(products.isEmpty){
                      return Container(
                        height: MediaQuery.of(context).size.height,
                        child: Center(child: Text("Not Item in Cart Page ",style:TextStyle(fontSize: 20),)),
                      );
                    }else{
                      return _buildContainer(products, index, _quantity, context);
                    }
                  }),
          ),

          new Container(
              width: double.infinity,
              child:Column(
                children: <Widget>[


                  Container(
                    height: 75,
                    child: RaisedButton(
                      elevation: 0,
                      onPressed: (){_showCustemDilog(products, context);} ,
                      color: Colors.amber,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("ORDER" , style: TextStyle(fontSize: 20)),
                          SizedBox(width: 10),
                          new Icon(Icons.shopping_cart)
                        ],
                      ),
                    ),
                  ),

                ],
              )
          ),

        ],
      ),
    );
  }
}

Container _buildContainer(List<Product> products, int index, int _quantity,BuildContext context) {
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
