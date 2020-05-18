import 'package:flutter/material.dart';
import 'package:ecommerceapp/ToolsApp/WidgetApp.dart';
import 'package:ecommerceapp/ToolsApp/StyleApp.dart';
import 'package:ecommerceapp/Components/myTextField.dart';
import 'package:ecommerceapp/Screen/Register/login_Screen.dart';
import 'package:ecommerceapp/Server/auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:ecommerceapp/provider/ModelHud.dart';
import './funcation_Register.dart';

  class signUp_Screen extends StatelessWidget {

    static String id = "signUpScreen";
    String _email ,_password ,  _fullName;
    GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
    GlobalKey<FormState> scaffoldKey = GlobalKey<FormState>();
    final _auth = Auth();


    @override
    Widget build(BuildContext context) {
      double height = MediaQuery.of(context).size.height;
      double width = MediaQuery.of(context).size.width;

      return Scaffold(
        backgroundColor: anOrange,
        body: ModalProgressHUD(
          inAsyncCall: Provider.of<ModelHud>(context).isLoading,
          child: Form(
            key: _globalKey,
            child: ListView(
              physics: BouncingScrollPhysics(),
              children: <Widget>[

                //==Logo App==========================
                SizedBox(height: height * 0.06),
                new Container(height: 100, width: 100, child: Image.asset("asset/Imag/shopping.png")),
                Align(alignment: Alignment.center, child: new Text("Shoping App", style: TextStyle(fontSize: 30 ,color: anBlack),)),



                //====Text Login A===========================
                SizedBox(height: height * 0.07),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: new Text("Sign Up",style:TextStyle(fontSize: 50,color: anWhite,fontWeight: FontWeight.bold)),
                ),



                //====TextField Full Name ===========================
                SizedBox(height: height * 0.02),
                myTextField(obscureText: false,hint: "Full Name",onClick: (v){_fullName = v;},
                prefixIcon: Icons.account_box,textInputType: TextInputType.text,
                colorfill: anWhite, colorborder: anOrange,
                ),


                //====TextField Email ===========================
                SizedBox(height: height * 0.01),
                myTextField(obscureText: false,hint: "Email", prefixIcon: Icons.lock_open,
                textInputType: TextInputType.emailAddress,onClick: (v){_email =v;},
                colorfill: anWhite, colorborder: anOrange,
                ),



                //====TextField Password ===========================
                SizedBox(height: height * 0.01),
                myTextField(
                  maxLines: 1,
                  obscureText: true,hint: "Password", onClick: (v){_password = v;},
                  prefixIcon: Icons.lock_open,textInputType: TextInputType.text,
                  colorfill: anWhite, colorborder: anOrange,
                ),


                //====Button Sgin up ================================
                SizedBox(height: height * 0.08),
                Builder(
                builder:(context)=> my_Button(
                  colorButton: anBlack, heightButton: 60, horizontal: 50,
                  textButton: "sign Up", fontSize: 20, radiusButton: 50,
                  onBtnclicked:(){funcation_signUP(context);}
                  ),
                ),


                //====you have an account================================
                SizedBox(height: height * 0.02),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Text("you have an account", style: TextStyle(fontSize: 20, color: anWhite)),
                    SizedBox(width: width * 0.02),
                    InkWell(onTap: (){ Navigator.pushNamed(context,LoginScreen.id);},
                      child: new Text("Login", style: TextStyle(fontSize: 20, color: anBlack))),
                  ],
                )
              ],
            ),
          ),
        ),

      );
    }


  }
