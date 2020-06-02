  import 'package:flutter/material.dart';
  import 'package:provider/provider.dart';
  import 'package:ecommerceapp/provider/ModelHud.dart';
  import 'package:ecommerceapp/provider/adminModel.dart';
  import 'package:ecommerceapp/Screen/User/HomePage.dart';
  import 'package:ecommerceapp/Screen/Admin/Admin_Home.dart';
  import 'package:ecommerceapp/Server/auth.dart';

  final auth = Auth();
  final passwordAdmin = 'admin123';
  final emaildAdmin = 'admin@gmail.com';
  bool showpassword = true;
  BuildContext context;


  //تسجيل حساب جديد
  // Funcation SigUp ==============================================
  Future funcation_signUP(BuildContext context,String email , password,_globalKeyP)async{
    //ModalProgress
    final modelHud = Provider.of<ModelHud>(context,listen: false);
    modelHud.changIsLoding(true);

    //في حالة التاكد من جميع البيانات مدخلة اعمل حفظ للقيم
    if( _globalKeyP.currentState.validate()){
      _globalKeyP.currentState.save();

      // اذا حدث خطأ في هذا الكود نفذ showSnackBar
      try {
        final autResulte = await auth.signUp(email, password);
        modelHud.changIsLoding(false);
        Navigator.pushNamed(context, HomePage.id);
      }catch(e){
        modelHud.changIsLoding(false);
        Scaffold.of(context).showSnackBar(SnackBar(content: Text(e.message),));
      }
    }
    modelHud.changIsLoding(false);
  }

  // Funcation Login ==============================================
  Future funcation_Login(BuildContext context,String email , password,globalKeyP)async{

    final modelhud = Provider.of<ModelHud>(context,listen: false);
    modelhud.changIsLoding(true);
    if(globalKeyP.currentState.validate()){
      globalKeyP.currentState.save();

      //=============================================================================
      //  اذا كانت قيمة isAdmin تساوي True سوف يذهب الي صفحة الادمن
      if(Provider.of<adminModel>(context,listen: false).isAdmin){
        modelhud.changIsLoding(true);
        //اذا كانت كلمة المرور صحيحة سوف يذهب الي صفحة الادمن
        if(password == passwordAdmin){
          try {
            final autResulte = await auth.login(email.trim().toLowerCase(), password.trim());
            Navigator.pushNamed(context, Admin_Home.id);;
          }catch(e){
            modelhud.changIsLoding(true);
            Scaffold.of(context).showSnackBar(SnackBar(content: Text(e.message),));
          }
        }
        //اذا كانت كلمة المرور خطأ سوف تظهر هذا الرسالة
        else{
          Scaffold.of(context).showSnackBar(SnackBar(content: Text("Something went wrong!"),));
        }
        modelhud.changIsLoding(false);
      }

      //=============================================================================
      // اذا كانت قيمة  isAdmin تساوي false سوف يذهب الي صفحة المستخدم
      else{
        if(password.trim() == passwordAdmin || email.trim() == emaildAdmin){
          Scaffold.of(context).showSnackBar(SnackBar(content: Text("This is an admin account!"),));
        }else{
          try {
            final autResulte = await auth.login(email.trim(), password.trim());
            Navigator.pushNamed(context,HomePage.id);
          }catch(e){
            modelhud.changIsLoding(false);
            Scaffold.of(context).showSnackBar(SnackBar(content: Text(e.message),));
          }
        }
      }
    }
    modelhud.changIsLoding(false);
  }