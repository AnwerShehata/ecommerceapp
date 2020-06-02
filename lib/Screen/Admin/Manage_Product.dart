import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ecommerceapp/Server/Store.dart';
import 'package:ecommerceapp/Model/Producer.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:ecommerceapp/provider/adminModel.dart';
import 'package:provider/provider.dart';
import 'package:ecommerceapp/provider/ModelHud.dart';
import 'package:ecommerceapp/provider/adminModel.dart';
import 'package:ecommerceapp/ToolsApp/StyleApp.dart';
import 'package:ecommerceapp/Screen/Admin/Edite_Products.dart';
import 'package:ecommerceapp/ToolsApp/WidgetApp.dart';
import 'package:ecommerceapp/Screen/Admin/Add_Products.dart';
import 'package:ecommerceapp/Screen/User/HomePage.dart';




class Manage_Product extends StatefulWidget {
  static String id = 'ManageProduct';
  @override
  _Manage_ProductState createState() => _Manage_ProductState();
}

class _Manage_ProductState extends State<Manage_Product> {

  final _store = Store();
  final Firestore _firestore = Firestore.instance;
  int crossAxisCount = 2;

  //=== Editing Product  =============================
  void _FunEdite(String choice, List<Product> _product, int index) {
    Navigator.push(context, MaterialPageRoute(builder: (context) =>EditeProducts(
      name: _product[index].proName,
      price: _product[index].proPrice,
      descraption: _product[index].proDescription,
      category: _product[index].proCategory,
      locationImage: _product[index].proLocation,
      proID: _product[index].proID,
    )),);
  }

  //=== Deleting Product  =============================
  void _FunDelete(String choice, List<Product> _product, int index) {
      showDialog(context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Column(
            children: <Widget>[
              CircleAvatar(backgroundColor: Colors.red,minRadius: 60,child: new Icon(Icons.delete_sweep ,size: 80, color: Colors.white,)),
              SizedBox(height: 10),
              new Text('Are you sure to delete the product?'),
            ],
          ),
          content: Container(
            height: 100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Text("product Name : ${_product[index].proName}",style: TextStyle(fontWeight: FontWeight.w500),),
                new Text("product Price : ${_product[index].proPrice} \$",style: TextStyle(fontWeight: FontWeight.w500),),
                SizedBox(height: 10),
                new Row(
                  children: <Widget>[
                    Expanded(
                        child: my_Button(textButton: "Yes" , fontSize: 20,radiusButton: 10 ,
                        horizontal: 5,colorButton: Colors.red ,
                        onBtnclicked: (){
                        _store.deleteProducte(_product[index].proID);
                        Navigator.pop(context);
                        })),

                    Expanded(
                        child: my_Button(textButton: "No" , fontSize: 20, radiusButton: 10 ,
                        horizontal: 5,colorButton: Colors.blue ,
                        onBtnclicked: (){Navigator.pop(context);})),
                  ],
                )
              ],
            ),
          )
        );
      },
    );
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(

      //===AppBar==============================
      appBar: AppBar(
        elevation: 0,
        title: Text(" Manage_Product "),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.home), onPressed: (){ Navigator.pushNamed(context, HomePage.id); })
        ],
      ),

      floatingActionButton: FloatingActionButton.extended(
          elevation: 5,
          icon: Icon(Icons.add),
          label: Text("Add Items"),
          onPressed: (){
          Navigator.pushNamed(context, Add_Products.id);
          }
          ),



      //===Body==============================
      body: StreamBuilder<QuerySnapshot>(
          stream: _store.loadeProducer(),
          builder: (context,snapshot){

            if(snapshot.hasData){
              List<Product> _product = [];

              for(var doc in snapshot.data.documents){
                var data = doc.data;
                  _product.add(Product(
                  proID: doc.documentID,
                  proName: data[KeyProdectName],
                  proPrice: data[KeyProdectPrice],
                  proDescription: data[KeyProdectDescription],
                  proCategory: data[KeyProdectCategory],
                  proLocation: data[KeyProdectLocation],
                ));
              }
              return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount:crossAxisCount,
                  childAspectRatio:0.7 ,
                  crossAxisSpacing: 10,mainAxisSpacing: 11
                  ),
                  itemCount: _product.length,
                  scrollDirection: Axis.vertical,
                  physics: BouncingScrollPhysics(),
                  addSemanticIndexes: false,
                  addAutomaticKeepAlives: true,
                  semanticChildCount: 10,
                  itemBuilder:(context , index){
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal:2,vertical: 2),
                      child: buildStack(_product, index, context),
                    );
                  }
              );
            }else{
               return Center(
                 child: CircularProgressIndicator(),
               );
            }
          }
      ),
    );
  }




  //=====Widget Stack Product Items===================================
  Widget buildStack(List<Product> _product, int index, BuildContext context) {
    return Stack(
                      children: <Widget>[
                        Positioned.fill(
                          child:Image( fit: BoxFit.cover,
                          image: NetworkImage(_product[index].proLocation))
                        ),

                        Positioned(
                          bottom: 0,
                          child: Container(
                            height: 60,
                            width: MediaQuery.of(context).size.width,
                            color: anBlack.withAlpha(900),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  new Text("${_product[index].proName}",style: TextStyle(fontSize: 15,color: anWhite)),
                                  new Text("\$${_product[index].proPrice}",style: TextStyle(fontSize: 15,color: anOrange,fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                          )
                        ),

                        Positioned(
                          top: 10, left: 10,
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                              child:PopupMenuButton<String>(
                                onSelected: (choice){
                                 switch(choice){
                                   case Constants.Edite : _FunEdite(choice, _product, index);
                                   break;
                                   case Constants.Delete : _FunDelete(choice, _product, index);
                                   break;
                                 }
                                },
                                child: Icon(Icons.more_vert ,color: Colors.black,),
                                itemBuilder: (context){
                                  return Constants.choices.map((String choice){
                                    return PopupMenuItem<String>(
                                      value: choice,
                                      child: Align(alignment: Alignment.centerRight,child: Text(choice)),
                                    );
                                  }).toList();
                                },
                              )
                          )),

                      ],
                    );
  }
}



//=====class Constants===================================
class Constants{
  static const String Edite = "Edite" ;
  static const String Delete = "Delete" ;
  static const List<String> choices =<String>[
    Edite ,
    Delete ,
  ];
}





