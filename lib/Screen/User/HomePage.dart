import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerceapp/Model/Producer.dart';
import 'package:ecommerceapp/Screen/User/Cart_Page.dart';
import 'package:ecommerceapp/Server/Store.dart';
import 'package:flutter/material.dart';
import 'package:ecommerceapp/ToolsApp/StyleApp.dart';
import 'package:ecommerceapp/Components/stackItemsOne.dart';
import '../Register/login_Screen.dart';

class HomePage extends StatefulWidget {
  static String id = 'HomePage';
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int tabBarIndex = 0;
  int  bottomBarIndex = 0;
  int value = 0;
  final _store = Store();
  List<Product> _productsHome;


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[

        DefaultTabController(
          length: 4,

          child: Scaffold(
            //==AppBar=======================
            appBar: AppBar(
              title: Text("data", style:TextStyle(fontSize: 20),),
              backgroundColor: anWhite2,
              elevation: 0,
              bottom: TabBar(
                indicatorColor: anOrange,
                isScrollable: false,
                onTap: (value){
                  setState(() {
                    tabBarIndex = value;
                  });
                },
                tabs: <Widget>[
                  Text(KeyJacket,style: TextStyle(
                      color: tabBarIndex==0 ? anBlack : anUnActiveColors,
                      fontSize: tabBarIndex==0 ? 17 : null ,
                      fontWeight: FontWeight.w400
                  )),

                  Text(KeyTrouser,style: TextStyle(
                      color: tabBarIndex==1 ? anBlack : anUnActiveColors,
                      fontSize: tabBarIndex==1 ? 17 : null ,
                      fontWeight: FontWeight.w400
                  )),

                  Text(KeyTshirts,style: TextStyle(
                      color: tabBarIndex==2 ? anBlack : anUnActiveColors,
                      fontSize: tabBarIndex==2 ? 17 : null ,
                      fontWeight: FontWeight.w400
                  )),

                  Text(KeyShose,style: TextStyle(
                      color: tabBarIndex==3 ? anBlack : anUnActiveColors,
                      fontSize: tabBarIndex==3 ? 17 : null ,
                      fontWeight: FontWeight.w400
                  )),

                ]),
            ),

            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
                fixedColor: anOrange,
                currentIndex: bottomBarIndex,
                selectedFontSize: 15,
                onTap: (value){
                setState(() {
                  bottomBarIndex = value;
                });
                },
                items: [
                  BottomNavigationBarItem(title: Text("Home"),icon: Icon(Icons.home)),
                  BottomNavigationBarItem(title: Text("Home"),icon: Icon(Icons.home)),
                  BottomNavigationBarItem(title: Text("Home"),icon: Icon(Icons.home)),
                  BottomNavigationBarItem(title: Text("Home"),icon: Icon(Icons.home)),
                ]
            ),
            //==Body=======================
            body: TabBarView(children: <Widget>[
              ViewCategory(KeyJacket),
              ViewCategory(KeyTrouser),
              ViewCategory(KeyTshirts),
              ViewCategory(KeyShose),
            ]),



          ),
        ),

        //=== Custem AppBar Discover =====================
        Material(
          child: new Container(
            height:MediaQuery.of(context).size.height * 0.14,
            child: Padding(
              padding: const EdgeInsets.only(top: 30,left: 20 , right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  new Text("discover".toUpperCase(),style: TextStyle(fontSize: 30 , fontWeight: FontWeight.bold)),
                  new IconButton(icon: Icon(Icons.shopping_cart),
                      onPressed: (){ Navigator.pushNamed(context, Cart_Page.id); }),
                ],
              ),
            ),
          ),
        ),

      ],
    );
  }

  ViewCategory(String NameCategory){
    return StreamBuilder<QuerySnapshot>(
      //هنا يتم استدعاء دالة عرض البيانات من كلاس Store
        stream: _store.loadeProducer(),
        builder: (context,snapshot){

          // اذا كانت تحميل snapshot بنانات نفذ الكود
          if(snapshot.hasData){
            List<Product> products = [];

            //هنا عملت التكرار في كل لفة يضيف منتج في الستة
            for(var doc in snapshot.data.documents){
              var data = doc.data;
              products.add(Product(
                proID: doc.documentID,
                proName: data[KeyProdectName],
                proPrice: data[KeyProdectPrice],
                proDescription: data[KeyProdectDescription],
                proCategory: data[KeyProdectCategory],
                proLocation: data[KeyProdectLocation],
                proQuantity: data[KeyProdectQuantity]
              ));
            }

            /*
            هنا كود التحقق من اسم القسم اذا كانNameCategory == Jacket
            سوف تظهر المنتاجات الخاصة بقسم الجاكت فقط
            */
            _productsHome = [...products];
            products.clear();
            for(var valueProduct in _productsHome){
              if(valueProduct.proCategory == NameCategory){
                products.add(valueProduct);
              }
            }

            return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount:2,
                    childAspectRatio:0.7 ,
                    crossAxisSpacing: 10,mainAxisSpacing: 11
                ),
                itemCount: products.length,
                scrollDirection: Axis.vertical,
                physics: BouncingScrollPhysics(),
                addSemanticIndexes: false,
                addAutomaticKeepAlives: true,
                semanticChildCount: 10,
                itemBuilder:(context , index){
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal:2,vertical: 2),
                    child: stackItemsOne(index: index,context: context,product: products,),
                  );
                }
            );
          }
          // اذا كانت snapshot لاتحميل  بنانات اظهر علامة التحميل
          else{
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        }
    );
  }

}


