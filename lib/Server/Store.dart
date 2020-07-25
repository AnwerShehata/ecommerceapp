import 'package:cloud_firestore/cloud_firestore.dart';
import '../Model/Producer.dart';
import '../ToolsApp/StyleApp.dart';
import 'package:ecommerceapp/Model/Producer.dart';
import 'package:firebase_auth/firebase_auth.dart';


  class Store {

  final Firestore _firestore = Firestore.instance;


  addProdect(Product producer){
    _firestore.collection(KeyProdectcollection).add({
      KeyProdectName : producer.proName,
      KeyProdectPrice : producer.proPrice,
      KeyProdectDescription : producer.proDescription,
      KeyProdectCategory : producer.proCategory,
      KeyProdectLocation : producer.proLocation,
    });
  }

  // Load Producer from FireBase===========================
  Stream<QuerySnapshot> loadeProducer(){
  return _firestore.collection(KeyProdectcollection).snapshots();
  }

  // delete Producte from FireBase===========================
  deleteProducte(documentID){
    _firestore.collection(KeyProdectcollection).document(documentID).delete();
  }


  // Editeing Producte from FireBase===========================
  editeProducte(data,documentID){
    _firestore.collection(KeyProdectcollection).document(documentID).updateData(data);
  }

  currentUser(){
    FirebaseAuth.instance.currentUser();
  }


  StoreOrder(data ,List<Product> products){
    var documentRef = _firestore.collection("Order").document();
    documentRef.setData(data);

    for(var product in products){
      documentRef.collection('orderDetails').document().setData({
        KeyProdectName : product.proName ,
        KeyProdectPrice : product.proPrice,
        KeyProdectQuantity : product.proQuantity,
        KeyProdectLocation : product.proLocation,
      });
    }
  }








}


