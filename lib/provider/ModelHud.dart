import 'package:flutter/cupertino.dart';

class ModelHud extends ChangeNotifier{

  bool isLoading = false;

  changIsLoding(bool value){
    isLoading = value;
    notifyListeners();
  }

}