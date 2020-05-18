import 'package:flutter/cupertino.dart';

class adminModel extends ChangeNotifier{

  bool isAdmin = true;

  changeIsAdmin(bool value){
    isAdmin = value;
    notifyListeners();
  }

}