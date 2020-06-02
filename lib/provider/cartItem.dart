import 'package:ecommerceapp/Model/Producer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class CartItem extends ChangeNotifier{

  List<Product> productes = [];

  addItem(Product product){
    productes.add(product);
    notifyListeners();
  }

  removeItem(Product product){
    productes.remove(product);
    notifyListeners();
  }
}