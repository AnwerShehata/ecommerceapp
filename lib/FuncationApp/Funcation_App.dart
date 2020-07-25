  import 'package:ecommerceapp/Model/Producer.dart';
  import 'package:ecommerceapp/provider/cartItem.dart';
  import 'package:flutter/material.dart';
  import 'package:provider/provider.dart';
  import 'package:ecommerceapp/provider/ModelHud.dart';
  import 'package:ecommerceapp/provider/adminModel.dart';
  import 'package:ecommerceapp/Screen/User/HomePage.dart';
  import 'package:ecommerceapp/Screen/Admin/Admin_Home.dart';
  import 'package:ecommerceapp/Server/auth.dart';




  // Funaction Add Item To Cart Page ============================
  void funAddToCart(Product product ,BuildContext context,int _quantity){
    CartItem cartItem =Provider.of<CartItem>(context,listen: false);
    product.proQuantity = _quantity.toString();
    bool exist = false;
    var productsInCart = cartItem.productes;
    // هنا نقول اذا كانت هذا المنتج موجود في صفحة السلة غير قيمة exist= True
    for(var productCart in productsInCart){

      if(productCart.proName == product.proName){
        exist = true;
      }

    }

    if(exist){
      //اذا كانت قيمةexist= True فهذا المنتج موجود في صفحة السلة اظهر هذا الرسالة للمستخدم
      Scaffold.of(context).showSnackBar(SnackBar(content: Text("This product is ready cart page ")));
    }else{
      // اما اذا كان المنتج غير موجود بصفحة السلة اضف المنتج للسلة
      cartItem.addItem(product);
      Scaffold.of(context).showSnackBar(SnackBar(content: Text("Add Item To Cart")));
    }

  }
