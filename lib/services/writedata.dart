import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class WriteData {
  // add user
  Future<void> addCust(
    MobileNo,
    custdata,
    BuildContext context,
  ) async {
    try {
      FirebaseFirestore.instance
          .collection('Customers')
          .doc(MobileNo)
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
    PcNo,
    ItemData,
    BuildContext context,
  ) async {
    try {
      FirebaseFirestore.instance.collection('TodayData').doc(PcNo).set(ItemData);
    } on FirebaseException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message.toString()),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> addprogress(PcNo, progress, BuildContext context) async {
    try {
      FirebaseFirestore.instance
          .collection(progress)
          .doc(PcNo)
          .set({"progress": progress});
    } on FirebaseException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message.toString()),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> removeprogress(
    PcNo,
    progress,
    BuildContext context,
  ) async {
    try {
      FirebaseFirestore.instance.collection(progress).doc(PcNo).delete();
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
