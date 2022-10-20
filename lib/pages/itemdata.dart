// ignore_for_file: deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pc1/appbarpage.dart';

class ItemDataPage extends StatefulWidget {
  String uid;
  ItemDataPage({Key? key, required this.uid}) : super(key: key);

  @override
  State<ItemDataPage> createState() => _ItemDataPageState();
}

class _ItemDataPageState extends State<ItemDataPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 211, 244, 247),
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: const Color.fromARGB(255, 16, 121, 174),
        title: Text('Item Data',
            style:
                GoogleFonts.ubuntu(fontSize: 25, fontWeight: FontWeight.bold)),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("TodayData")
              .doc(widget.uid)
              .snapshots(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            Map<String, dynamic> docItemData = snapshot.data!.data();
            return Padding(
              padding: const EdgeInsets.all(15),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15)),
                child: Column(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 11, 126, 180),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15))),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Pc No : ",
                                  style: GoogleFonts.poppins(
                                      color: Colors.black,
                                      fontSize: 23,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  docItemData["Pc No"],
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              docItemData["Progress"],
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            docItemData["Item"],
                            style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w600),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: InkWell(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Expanded(
                                      child: AlertDialog(
                                        title: Text('Update Cost'),
                                        content: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: SizedBox(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: TextFormField(
                                              initialValue: docItemData["Cost"],
                                              decoration: const InputDecoration(
                                                labelText: 'Cost.',
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                15))),
                                                prefixIcon:
                                                    Icon(Icons.currency_rupee),
                                              ),
                                              onChanged: (value) {
                                                setState(() {
                                                  docItemData["Cost"] = value;
                                                });
                                              },
                                            ),
                                          ),
                                        ),
                                        actions: [
                                          FlatButton(
                                            textColor: Colors.black,
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text('CANCEL'),
                                          ),
                                          FlatButton(
                                            textColor: Colors.black,
                                            onPressed: () {
                                              try {
                                                FirebaseFirestore.instance
                                                    .collection('TodayData')
                                                    .doc(docItemData["Uid"])
                                                    .update({
                                                  "Cost": docItemData["Cost"]
                                                }).then(
                                                  (result) {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                      const SnackBar(
                                                        content:
                                                            Text("Cost Update"),
                                                        backgroundColor:
                                                            Colors.red,
                                                      ),
                                                    );
                                                  },
                                                );
                                              } on FirebaseException catch (e) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                    content: Text(
                                                        e.message.toString()),
                                                    backgroundColor: Colors.red,
                                                  ),
                                                );
                                              }
                                              Navigator.pop(context);
                                            },
                                            child: Text('ACCEPT'),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                              child: Container(
                                height: 40,
                                decoration: BoxDecoration(
                                    color: Colors.amber,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                    child: Row(
                                      children: [
                                        Text(
                                          "Cost: ",
                                          style: GoogleFonts.poppins(
                                              color: Colors.black,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          docItemData["Cost"],
                                          style: GoogleFonts.poppins(
                                            color: Colors.grey,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Text(
                            docItemData["Bring Item"],
                            style: GoogleFonts.poppins(
                              color: Colors.grey,
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          "Problem: ",
                          style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 23,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return Expanded(
                                  child: AlertDialog(
                                    title: Text('Update Problem'),
                                    content: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: TextFormField(
                                          initialValue: docItemData["Problem"],
                                          decoration: const InputDecoration(
                                            labelText: 'Problem.',
                                            border: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(15))),
                                            prefixIcon:
                                                Icon(Icons.currency_rupee),
                                          ),
                                          onChanged: (value) {
                                            setState(() {
                                              docItemData["Problem"] = value;
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                    actions: [
                                      FlatButton(
                                        textColor: Colors.black,
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text('CANCEL'),
                                      ),
                                      FlatButton(
                                        textColor: Colors.black,
                                        onPressed: () {
                                          try {
                                            FirebaseFirestore.instance
                                                .collection('TodayData')
                                                .doc(docItemData["Uid"])
                                                .update({
                                              "Problem": docItemData["Problem"]
                                            }).then(
                                              (result) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  const SnackBar(
                                                    content:
                                                        Text("Problem Update"),
                                                    backgroundColor: Colors.red,
                                                  ),
                                                );
                                              },
                                            );
                                          } on FirebaseException catch (e) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content:
                                                    Text(e.message.toString()),
                                                backgroundColor: Colors.red,
                                              ),
                                            );
                                          }
                                          Navigator.pop(context);
                                        },
                                        child: Text('ACCEPT'),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Text(
                              docItemData["Problem"],
                              style: GoogleFonts.poppins(
                                color: Colors.grey,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Remark: ",
                          style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 23,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return Expanded(
                                  child: AlertDialog(
                                    title: Text('Update Remarks'),
                                    content: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: TextFormField(
                                          initialValue: docItemData["Remarks"],
                                          decoration: const InputDecoration(
                                            labelText: 'Remarks.',
                                            border: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(15))),
                                            prefixIcon:
                                                Icon(Icons.currency_rupee),
                                          ),
                                          onChanged: (value) {
                                            setState(() {
                                              docItemData["Remarks"] = value;
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                    actions: [
                                      FlatButton(
                                        textColor: Colors.black,
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text('CANCEL'),
                                      ),
                                      FlatButton(
                                        textColor: Colors.black,
                                        onPressed: () {
                                          try {
                                            FirebaseFirestore.instance
                                                .collection('TodayData')
                                                .doc(docItemData["Uid"])
                                                .update({
                                              "Remarks": docItemData["Remarks"]
                                            }).then(
                                              (result) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  const SnackBar(
                                                    content:
                                                        Text("Remarks Update"),
                                                    backgroundColor: Colors.red,
                                                  ),
                                                );
                                              },
                                            );
                                          } on FirebaseException catch (e) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content:
                                                    Text(e.message.toString()),
                                                backgroundColor: Colors.red,
                                              ),
                                            );
                                          }
                                          Navigator.pop(context);
                                        },
                                        child: Text('ACCEPT'),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Text(
                              docItemData["Remarks"] == ""
                                  ? 00
                                  : docItemData["Remarks"],
                              textAlign: TextAlign.start,
                              style: GoogleFonts.poppins(
                                color: Colors.grey,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(right: 15, bottom: 15),
        child: FloatingActionButton(
          backgroundColor: const Color.fromARGB(255, 16, 121, 174),
          onPressed: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AppBarPage(),
              ),
            );
          },
          child: const Icon(
            Icons.arrow_forward_outlined,
            size: 30,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
