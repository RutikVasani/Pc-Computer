import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pc1/appbarpage.dart';
import 'package:pc1/pages/invoice/pdf/pdfdata.dart';
import 'package:pc1/pages/itemdata.dart';
import 'package:pc1/services/writedata.dart';
import 'package:url_launcher/url_launcher.dart';

class DeliveredPcDatails extends StatefulWidget {
  const DeliveredPcDatails({Key? key}) : super(key: key);

  @override
  State<DeliveredPcDatails> createState() => _DeliveredPcDatailsState();
}

class _DeliveredPcDatailsState extends State<DeliveredPcDatails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 211, 244, 247),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("TodayData")
            .orderBy('Delivered Now', descending: true)
            // .orderBy('Delivered Time', descending: true)
            .snapshots(),
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
                  if (docTodayData["Progress"] == "Delivered") {
                    String dropdownValue = 'Delivered';
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
                                  decoration: const BoxDecoration(
                                      color: Colors.purple,
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
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10),
                                          child: Container(
                                            width: 100,
                                            height: 40,
                                            decoration: BoxDecoration(
                                                color: Colors.purple.shade200,
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
                                                    FirebaseFirestore.instance
                                                        .collection("TodayData")
                                                        .doc(docTodayData[
                                                            "Pc No"])
                                                        .update({
                                                      "Progress": dropdownValue,
                                                      "Uid": uid
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
                                                        "Pending",
                                                        context);
                                                    FirebaseFirestore.instance
                                                        .collection("Customers")
                                                        .doc(docTodayData[
                                                            "Mobile No"])
                                                        .collection("PcNumber")
                                                        .doc(docTodayData[
                                                            "Pc No"])
                                                        .collection("Data")
                                                        .doc(uid)
                                                        .set(docTodayData);
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
                                Padding(
                                  padding: const EdgeInsets.only(left: 15),
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            const Text(
                                              "Delivered:",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              docTodayData["Delivered Time"] +
                                                  ", " as String,
                                              style: GoogleFonts.poppins(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.grey),
                                            ),
                                            Text(
                                              docTodayData["Delivered Date"]
                                                  as String,
                                              style: GoogleFonts.poppins(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.grey),
                                            ),
                                          ],
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    PdfDataPage(pcno: docTodayData["Pc No"],),
                                              ),
                                            );
                                          },
                                          icon: const Icon(
                                            Icons.picture_as_pdf,
                                            color: Colors.black,
                                            size: 30,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      InkWell(
                                        onTap: () async {
                                          String mobileno =
                                              docTodayData["Mobile No"];
                                          String message = "Dear Customer, " +
                                              docTodayData["Name"] +
                                              ',\n your ' +
                                              docTodayData["Item"] +
                                              ", Pc No " +
                                              docTodayData["Pc No"] +
                                              " has Delivered and charge of it is Rs." +
                                              docTodayData["Cost"] +
                                              "/-, Thank you for contect us,\n Pc Computer.";
                                          final Uri whatsapp = Uri.parse(
                                              'whatsapp://send/?phone=$mobileno&text=$message');

                                          // ignore: deprecated_member_use
                                          await launchUrl(whatsapp);
                                        },
                                        child: Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              4,
                                          height: 40,
                                          decoration: BoxDecoration(
                                              color: Colors.green.shade900,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Center(
                                            child: Text(
                                              "Whatsapp",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () async {
                                          String mobileno =
                                              docTodayData["Mobile No"];
                                          final Uri call = Uri(
                                              scheme: 'tel', path: mobileno);
                                          // ignore: deprecated_member_use
                                          if (await canLaunch(
                                              call.toString())) {
                                            // ignore: deprecated_member_use
                                            await launch(call.toString());
                                          } else {
                                            print("no action");
                                          }
                                        },
                                        child: Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              4,
                                          height: 40,
                                          decoration: BoxDecoration(
                                              color: Colors.green,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Center(
                                            child: Text(
                                              "Call",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () async {
                                          String mobileno =
                                              docTodayData["Mobile No"];
                                          String message = "Dear Customer, " +
                                              docTodayData["Name"] +
                                              ',\n your ' +
                                              docTodayData["Item"] +
                                              ", Pc No " +
                                              docTodayData["Pc No"] +
                                              " has Delivered and charge of it is Rs." +
                                              docTodayData["Cost"] +
                                              "/-, Thank you for contect us,\n Pc Computer.";
                                          final String smsandroid =
                                              'sms:$mobileno?body=$message';
                                          // ignore: deprecated_member_use
                                          if (await canLaunch(smsandroid)) {
                                            // ignore: deprecated_member_use
                                            await launch(smsandroid);
                                          } else {
                                            throw 'Could not launch';
                                          }
                                        },
                                        child: Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              4,
                                          height: 40,
                                          decoration: BoxDecoration(
                                              color: Colors.blue,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Center(
                                            child: Text(
                                              "Sms",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 10),
                              ],
                            )),
                      ),
                    );
                  } else {
                    return const SizedBox(width: 0, height: 0);
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
