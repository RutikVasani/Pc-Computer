import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Crud {
  // add user
  Future<void> adduser(
    userid,
    custdata,
    BuildContext context,
  ) async {
    try {
      FirebaseFirestore.instance
          .collection('Customers')
          .doc(userid)
          .set(custdata);
    } on FirebaseException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message.toString()),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  // // add pc Number
  // Future<void> addPc(
  //   PcNumber,
  //   BuildContext context,
  // ) async {
  //   try {
  //     FirebaseFirestore.instance
  //         .collection('Customers')
  //         .doc(FirebaseAuth.instance.currentUser!.uid)
  //         .collection('PcNumber')
  //         .add(PcNumber);
  //   } on FirebaseException catch (e) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text(e.message.toString()),
  //         backgroundColor: Colors.red,
  //       ),
  //     );
  //   }
  // }
}
