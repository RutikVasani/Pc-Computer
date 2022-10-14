import 'package:cloud_firestore/cloud_firestore.dart';

class addCustModel {
  String Name;
  String MobileNo;
  Timestamp Date;

  addCustModel({
    required this.Name,
    required this.MobileNo,
    required this.Date,
  });

  factory addCustModel.fromjson(DocumentSnapshot snapshot) {
    return addCustModel(
        Name: snapshot['Name'],
        MobileNo: snapshot['Mobile No'],
        Date: snapshot['Date']);
  }
}

class addPcNoModel {
  String PcNo;
  Timestamp Date;

  addPcNoModel({
    required this.PcNo,
    required this.Date,
  });

  factory addPcNoModel.fromjson(DocumentSnapshot snapshot) {
    return addPcNoModel(PcNo: snapshot['Pc No'], Date: snapshot['Date']);
  }
}

class addItemDataModel {
  String PcNo;
  String Item;
  String BringItem;
  String Cost;
  String Remark;
  String ItemId;
  String Progress;
  Timestamp Date;

  addItemDataModel({
    required this.PcNo,
    required this.Item,
    required this.BringItem,
    required this.Cost,
    required this.Remark,
    required this.ItemId,
    required this.Progress,
    required this.Date,
  });

  factory addItemDataModel.fromjson(DocumentSnapshot snapshot) {
    return addItemDataModel(
        PcNo: snapshot['Pc No'],
        Date: snapshot['Date'],
        BringItem: snapshot['Bring Item'],
        Cost: snapshot['Cost'],
        Item: snapshot['Item'],
        ItemId: snapshot['Item Id'],
        Progress: snapshot['Progress'],
        Remark: snapshot['Remarks']);
  }
}