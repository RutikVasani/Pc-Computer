import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class WriteData {
  // add user
  Future<void> addCust(
    CustId,
    custdata,
    BuildContext context,
  ) async {
    try {
      FirebaseFirestore.instance
          .collection('Customers')
          .doc(CustId)
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

  // add pc Number
  Future<void> addPc(
    MobileNo,
    PcNo,
    PcNumData,
    BuildContext context,
  ) async {
    try {
      FirebaseFirestore.instance
          .collection('Customers')
          .doc(MobileNo)
          .collection('PcNumber')
          .doc(PcNo)
          .set(PcNumData);
    } on FirebaseException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message.toString()),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> addPcData(
    MobileNo,
    PcNo,
    ItemId,
    ItemData,
    BuildContext context,
  ) async {
    try {
      FirebaseFirestore.instance
          .collection('Customers')
          .doc(MobileNo)
          .collection('PcNumber')
          .doc(PcNo)
          .collection('Item Data')
          .doc(ItemId)
          .set(ItemData);
    } on FirebaseException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message.toString()),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
