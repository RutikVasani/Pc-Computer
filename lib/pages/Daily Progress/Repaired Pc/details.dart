import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:pc1/appbarpage.dart';
import 'package:pc1/pages/invoice/pdf/payment/payment.dart';
import 'package:pc1/pages/itemdata.dart';
import 'package:pc1/services/writedata.dart';

class RepairedPcDatails extends StatefulWidget {
  const RepairedPcDatails({Key? key}) : super(key: key);

  @override
  State<RepairedPcDatails> createState() => _RepairedPcDatailsState();
}

class _RepairedPcDatailsState extends State<RepairedPcDatails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 211, 244, 247),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("TodayData")
            .orderBy('Delivered Now', descending: true).snapshots(),
        builder:
            (__, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            if (snapshot.data!.docs.isNotEmpty) {
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (___, int index) {
                  Map<String, dynamic> docTodayData =
                      snapshot.data!.docs[index].data();
                  String uid = snapshot.data!.docs[index].id;
                  if (docTodayData.isEmpty) {
                    return const SizedBox(
                      child: Center(
                        child: Text("Document is Empty"),
                      ),
                    );
                  }
                  if (docTodayData["Progress"] == "Repaired") {
                    String dropdownValue = 'Repaired';
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ItemDataPage(
                                uid: uid,
                              ),
                            ),
                          );
                        },
                        child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.green.shade700,
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(10),
                                          topLeft: Radius.circular(10))),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          height: 25,
                                          width: 200,
                                          child: Align(
                                            alignment: Alignment.bottomLeft,
                                            child: Text(
                                              'Pc No: ${docTodayData["Pc No"]}',
                                              style: GoogleFonts.ubuntu(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            setState(() {
                                              docTodayData["Progress"] =
                                                  "Delivered";
                                            });
                                            try {
                                              FirebaseFirestore.instance
                                                  .collection("TodayData")
                                                  .doc(docTodayData["Pc No"])
                                                  .update({
                                                "Progress":
                                                    docTodayData["Progress"],
                                                "Uid": uid,
                                                "Delivered Time":
                                                    DateFormat.jm()
                                                        .format(DateTime.now()),
                                                "Delivered Now": DateTime.now(),
                                                "Delivered Date":
                                                    DateFormat('dd/MM/yyyy')
                                                        .format(DateTime.now())
                                              }).then((_) {
                                                print("success!" +
                                                    docTodayData["Progress"]);
                                                print(uid);
                                              });
                                              WriteData().addprogress(
                                                  docTodayData["Pc No"],
                                                  "Delivered",
                                                  context);
                                              WriteData().removeprogress(
                                                  docTodayData["Pc No"],
                                                  "Repaired",
                                                  context);
                                              FirebaseFirestore.instance
                                                  .collection("Customers")
                                                  .doc(
                                                      docTodayData["Mobile No"])
                                                  .collection("PcNumber")
                                                  .doc(docTodayData["Pc No"])
                                                  .collection("Data")
                                                  .doc(uid)
                                                  .set(docTodayData);
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
                                          },
                                          icon: Container(
                                            width: 40,
                                            height: 40,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              color: Colors.blue.shade200,
                                            ),
                                            child: const Icon(
                                              Icons.done,
                                              size: 30,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10),
                                          child: Container(
                                            width: 100,
                                            height: 40,
                                            decoration: BoxDecoration(
                                                color: Colors.green.shade200,
                                                borderRadius:
                                                    const BorderRadius.only(
                                                        topRight:
                                                            Radius.circular(10),
                                                        bottomLeft:
                                                            Radius.circular(
                                                                10))),
                                            child: Center(
                                              child: DropdownButton<String>(
                                                value: dropdownValue,
                                                dropdownColor:
                                                    const Color.fromARGB(
                                                        255, 16, 121, 174),
                                                style: GoogleFonts.poppins(
                                                    color: Colors.white),
                                                underline: const SizedBox(),
                                                iconSize: 0,
                                                onChanged: (String? newValue) {
                                                  setState(() {
                                                    dropdownValue = newValue!;
                                                  });
                                                  docTodayData["Progress"] ==
                                                      dropdownValue;
                                                  try {
                                                    // FirebaseFirestore.instance
                                                    //     .collection("TodayData")
                                                    //     .doc(docTodayData[
                                                    //         "Pc No"])
                                                    //     .update({
                                                    //   "Progress": dropdownValue,
                                                    //   "Uid": uid
                                                    // }).then((_) {
                                                    //   print("success!" +
                                                    //       dropdownValue);
                                                    //   print(uid);
                                                    // });
                                                    FirebaseFirestore.instance
                                                        .collection("TodayData")
                                                        .doc(docTodayData[
                                                            "Pc No"])
                                                        .update({
                                                      "Progress": dropdownValue,
                                                      "Uid": uid,
                                                      "Delivered Time":
                                                          DateFormat.jm()
                                                              .format(DateTime
                                                                  .now()),
                                                      "Delivered Now":
                                                          DateTime.now(),
                                                      "Delivered Date":
                                                          DateFormat(
                                                                  'dd/MM/yyyy')
                                                              .format(DateTime
                                                                  .now())
                                                    }).then((_) {
                                                      print("success!" +
                                                          dropdownValue);
                                                      print(uid);
                                                    });
                                                    WriteData().addprogress(
                                                        docTodayData["Pc No"],
                                                        dropdownValue,
                                                        context);
                                                    WriteData().removeprogress(
                                                        docTodayData["Pc No"],
                                                        "Repaired",
                                                        context);
                                                  } on FirebaseException catch (e) {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                      SnackBar(
                                                        content: Text(e.message
                                                            .toString()),
                                                        backgroundColor:
                                                            Colors.red,
                                                      ),
                                                    );
                                                  }
                                                },
                                                items: <String>[
                                                  'Pending',
                                                  'On Going',
                                                  'Repaired',
                                                  'Delivered',
                                                ].map<DropdownMenuItem<String>>(
                                                    (String value) {
                                                  return DropdownMenuItem<
                                                      String>(
                                                    value: value,
                                                    child: Text(value),
                                                  );
                                                }).toList(),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  child: Row(
                                    children: [
                                      Text(
                                        "Name: ",
                                        style: GoogleFonts.poppins(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black),
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                1.7,
                                        child: Text(
                                          docTodayData["Name"],
                                          style: GoogleFonts.poppins(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.grey),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  child: Row(
                                    children: [
                                      Text(
                                        "Mobile No: ",
                                        style: GoogleFonts.poppins(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black),
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2,
                                        child: Text(
                                          docTodayData["Mobile No"],
                                          style: GoogleFonts.poppins(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.grey),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 5),
                                      child: Text(
                                        docTodayData["Item"],
                                        style: GoogleFonts.poppins(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black),
                                      ),
                                    ),
                                    const Spacer(),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 15),
                                      child: Text(
                                        docTodayData["Cost"],
                                        style: GoogleFonts.poppins(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width / 1.1,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 15),
                                    child: Text(
                                      docTodayData["Problem"],
                                      style: GoogleFonts.poppins(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.grey),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                              ],
                            )),
                      ),
                    );
                  } else {
                    return SizedBox(width: 0, height: 0);
                  }
                },
              );
            } else {
              return const Center(
                  child: SizedBox(
                width: 200,
                height: 100,
                child: Center(
                  child: Text(
                    "Work Done",
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                ),
              ));
            }
          } else {
            return const Center(
              child: Text("Getting Error"),
            );
          }
        },
      ),
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
