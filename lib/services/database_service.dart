import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/foundation.dart';
import 'package:machine_test_ex/models/userdetails.dart';

class DatabaseService{

  final String uid;
  DatabaseService({this.uid});

  final CollectionReference usercollections = Firestore.instance.collection('userdetails');

  Future updateuserdata(UserDetails user) async {
      return await usercollections.document(uid).setData({
          "firstname" : user.firstname,
          "lastname" : user.lastname,
          'email' : user.email,
          'age': user.age,
          'mobileno': user.mobileno,
          'address' : user.address,
      });
    }

  List<UserDetails> _profiledetails(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return UserDetails(
        uid: doc.documentID,
        firstname: doc.data['firstname'] ?? '',
        lastname: doc.data['lastname'] ?? '',
        email: doc.data['email'] ?? '',
        address: doc.data['address'] ?? '',
        age: doc.data['age'] ?? '',
        mobileno: doc.data['mobileno'] ?? '',
      );
    }).toList();
  } 

  //   UserDetails _profiledetails(DocumentSnapshot doc){
  //   // return snapshot.documents.map((doc){
  //     return UserDetails(
  //       firstname: doc.data['firstname'] ?? '',
  //       lastname: doc.data['lastname'] ?? '',
  //       email: doc.data['email'] ?? '',
  //       address: doc.data['address'] ?? '',
  //       age: doc.data['age'] ?? '',
  //       mobileno: doc.data['mobileno'] ?? '',
  //     );
  //   // }).toList();
  // } 

  UserData _userDataFromSnapshot(DocumentSnapshot snapshot){
    return UserData (
      uid: uid,
      firstname:snapshot.data['firstname'],
      lastname: snapshot.data['lastname'],
      email: snapshot.data['email'],
      address: snapshot.data['address'],
      age: snapshot.data['age'],
      mobileno: snapshot.data['mobileno'],
    );
  }


  Stream<List<UserDetails>> get userdetails {
    return usercollections.snapshots()
    .map(_profiledetails);
  }

  // Stream<UserDetails> get userdetails {

  //   return usercollections.document(uid).snapshots()
  //   .map(_profiledetails);
  // }
  

  Stream<UserData> get userData {

    return usercollections.document(uid).snapshots()
    .map(_userDataFromSnapshot);
  }
  
  }
  
