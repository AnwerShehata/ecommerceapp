import 'package:flutter/material.dart';
import 'package:ecommerceapp/Model/Producer.dart';
import 'package:ecommerceapp/ToolsApp/StyleApp.dart';

class stackItemsOne extends StatelessWidget {
  final List<Product> product;
  final int index;
  final BuildContext context;
  const stackItemsOne({Key key, this.product, this.index, this.context}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[

        Positioned.fill(
            child:Image( fit: BoxFit.cover,
                image: NetworkImage(product[index].proLocation))
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
                    new Text("${product[index].proName}",style: TextStyle(fontSize: 15,color: anWhite)),
                    new Text("\$${product[index].proPrice}",style: TextStyle(fontSize: 15,color: anOrange,fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            )
        ),
      ],
    );
  }
}


