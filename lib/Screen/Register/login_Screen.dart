import 'package:flutter/material.dart';
import 'package:ecommerceapp/ToolsApp/WidgetApp.dart';
import 'package:ecommerceapp/ToolsApp/StyleApp.dart';
import 'package:ecommerceapp/Components/myTextField.dart';
import 'package:ecommerceapp/Screen/Register/signUp_Screen.dart';
import 'package:ecommerceapp/Server/auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:ecommerceapp/provider/ModelHud.dart';
import 'package:ecommerceapp/provider/adminModel.dart';
import './funcation_Register.dart';





class LoginScreen extends StatefulWidget {
  static String id = 'LoginScreen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _email;
  String _password;
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  bool showpassword = true;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: anOrange,


      body: ModalProgressHUD(
        inAsyncCall:Provider.of<ModelHud>(context).isLoading,
        child: Form(
          key: _globalKey,
          child: ListView(
            children: <Widget>[
              //====Shoping App and Icons===========================
              SizedBox(height: height * 0.06),
              new Container(
                height: 100, width: 100, child: Image.asset("asset/Imag/shopping.png"),
              ),
              SizedBox(height: height * 0.02),
              Align(alignment: Alignment.center, child: new Text("Shoping App", style: TextStyle(fontSize: 30 ,color: anBlack),)),


              //====Text Login===========================
              SizedBox(height: height * 0.07),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: new Text("Login",style:TextStyle(fontSize: 50,color: anWhite,fontWeight: FontWeight.bold)),
              ),

              //==== TextField Email ===========================
              SizedBox(height: height * 0.02),
              myTextField(
                textInputAction: TextInputAction.next,obscureText: false, hint: "Email",
                prefixIcon: Icons.email,textInputType: TextInputType.emailAddress,
                onClick: (v){_email = v;}, colorfill: anWhite, colorborder: anOrange,
              ),

              //==== TextField Password ===========================
              SizedBox(height: height * 0.01),
              myTextField(
                suffixIcon: showpassword ? Icons.visibility : Icons.visibility_off,
                textInputAction: TextInputAction.done,
                hint: "Password",
                prefixIcon: Icons.lock_open,
                obscureText: showpassword,
                textInputType: TextInputType.text,
                onClick: (v){_password = v;},
                colorfill: anWhite,
                colorborder: anOrange,
                maxLines: 1,
                FunSuffixIcon: (){
                  setState(() {
                    showpassword =! showpassword;
                  });
                },
              ),






              //==== Button Loging ===========================
              SizedBox(height: height * 0.08),
              Builder(
                builder: (context) => my_Button ( colorButton: anBlack, heightButton: 60, horizontal: 50,
                    textButton: "Loging", fontSize: 20, radiusButton: 50, onBtnclicked:(){funcation_Login(context);}),
              ),



              SizedBox(height: height * 0.02),
              new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Text("Dont have an account", style: TextStyle(fontSize: 20, color: anWhite)),
                  SizedBox(width: width * 0.02),

                  InkWell(onTap: (){ Navigator.pushNamed(context, signUp_Screen.id); },
                      child: new Text("sign Up", style: TextStyle(fontSize: 20, color: anBlack))),
                ],
              ),

              SizedBox(height: height*0.04,),
              new Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  InkWell(onTap: (){funcation_Admin(context);},child: new Text("Admin", style: TextStyle(fontSize: 30 ,
                      color: Provider.of<adminModel>(context).isAdmin ? anOrange : anBlack))) ,

                  InkWell(onTap:(){funcation_USer(context);},child: new Text("USer", style: TextStyle(fontSize: 30 ,
                      color: Provider.of<adminModel>(context).isAdmin ? anBlack : anOrange))) ,
                ],
              ),

              SizedBox(height: height*0.08,)

            ],
          ),
        ),
      ),
    );
  }
}


