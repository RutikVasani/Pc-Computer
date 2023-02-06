import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pc1/pages/invoice/pdf/pdfdata.dart';
import 'package:pc1/pages/itemdata.dart';
import 'package:pc1/services/writedata.dart';
import 'package:url_launcher/url_launcher.dart';

class SearchDeliveredPage extends StatefulWidget {
  const SearchDeliveredPage({super.key});

  @override
  State<SearchDeliveredPage> createState() => _SearchDeliveredPageState();
}

class _SearchDeliveredPageState extends State<SearchDeliveredPage> {
  String Mobileno = "";
  String SearchValue = "";
  bool _search = true;
  bool _pcno = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 16, 121, 174),
        title: TextField(
          autofocus: true,
          onChanged: (value) {
            setState(
              () {
                SearchValue = value;
                if (value == "") {
                  _search = true;
                } else {
                  _search = false;
                }
                if (value.length < 6) {
                  _pcno = true;
                } else {
                  _pcno = false;
                }
              },
            );
          },
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: "Search",
            hintStyle: TextStyle(color: Colors.white),
          ),
        ),
      ),
      body: _search
          ? const SizedBox(
              height: 0,
              width: 0,
            )
          : _pcno
              ? SingleChildScrollView(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('TodayData')
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (SearchValue != "") {
                          return (snapshot.connectionState ==
                                  ConnectionState.waiting)
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : ListView.builder(
                                  itemCount: snapshot.data!.docs.length,
                                  itemBuilder: (contest, index) {
                                    var docTodayData =
                                        snapshot.data!.docs[index].data()
                                            as Map<String, dynamic>;
                                    String uid = snapshot.data!.docs[index].id;

                                    if (docTodayData["Progress"] ==
                                            "Delivered" &&
                                        docTodayData['Pc No']
                                            .toString()
                                            .toLowerCase()
                                            .contains(
                                                SearchValue.toLowerCase())) {
                                      String dropdownValue = 'Delivered';
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15, vertical: 10),
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    ItemDataPage(
                                                  uid: uid,
                                                ),
                                              ),
                                            );
                                          },
                                          child: Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15)),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  Container(
                                                    decoration: const BoxDecoration(
                                                        color: Colors.purple,
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                topRight: Radius
                                                                    .circular(
                                                                        10),
                                                                topLeft: Radius
                                                                    .circular(
                                                                        10))),
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 15),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          SizedBox(
                                                            height: 25,
                                                            width: 200,
                                                            child: Align(
                                                              alignment: Alignment
                                                                  .bottomLeft,
                                                              child: Text(
                                                                'Pc No: ${docTodayData["Pc No"]}',
                                                                style: GoogleFonts.ubuntu(
                                                                    fontSize:
                                                                        20,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    color: Colors
                                                                        .white),
                                                              ),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    vertical:
                                                                        10),
                                                            child: Container(
                                                              width: 100,
                                                              height: 40,
                                                              decoration: BoxDecoration(
                                                                  color: Colors
                                                                      .purple
                                                                      .shade200,
                                                                  borderRadius: const BorderRadius
                                                                          .only(
                                                                      topRight:
                                                                          Radius.circular(
                                                                              10),
                                                                      bottomLeft:
                                                                          Radius.circular(
                                                                              10))),
                                                              child: Center(
                                                                child:
                                                                    DropdownButton<
                                                                        String>(
                                                                  value:
                                                                      dropdownValue,
                                                                  dropdownColor:
                                                                      const Color
                                                                              .fromARGB(
                                                                          255,
                                                                          16,
                                                                          121,
                                                                          174),
                                                                  style: GoogleFonts
                                                                      .poppins(
                                                                          color:
                                                                              Colors.white),
                                                                  underline:
                                                                      const SizedBox(),
                                                                  iconSize: 0,
                                                                  onChanged:
                                                                      (String?
                                                                          newValue) {
                                                                    setState(
                                                                        () {
                                                                      dropdownValue =
                                                                          newValue!;
                                                                    });
                                                                    docTodayData[
                                                                            "Progress"] ==
                                                                        dropdownValue;
                                                                    try {
                                                                      FirebaseFirestore
                                                                          .instance
                                                                          .collection(
                                                                              "TodayData")
                                                                          .doc(docTodayData[
                                                                              "Pc No"])
                                                                          .update({
                                                                        "Progress":
                                                                            dropdownValue,
                                                                        "Uid":
                                                                            uid
                                                                      }).then((_) {
                                                                        print("success!" +
                                                                            dropdownValue);
                                                                        print(
                                                                            uid);
                                                                      });
                                                                      WriteData().addprogress(
                                                                          docTodayData[
                                                                              "Pc No"],
                                                                          dropdownValue,
                                                                          context);
                                                                      WriteData().removeprogress(
                                                                          docTodayData[
                                                                              "Pc No"],
                                                                          "Pending",
                                                                          context);
                                                                      FirebaseFirestore
                                                                          .instance
                                                                          .collection(
                                                                              "Customers")
                                                                          .doc(docTodayData[
                                                                              "Mobile No"])
                                                                          .collection(
                                                                              "PcNumber")
                                                                          .doc(docTodayData[
                                                                              "Pc No"])
                                                                          .collection(
                                                                              "Data")
                                                                          .doc(
                                                                              uid)
                                                                          .set(
                                                                              docTodayData);
                                                                    } on FirebaseException catch (e) {
                                                                      ScaffoldMessenger.of(
                                                                              context)
                                                                          .showSnackBar(
                                                                        SnackBar(
                                                                          content: Text(e
                                                                              .message
                                                                              .toString()),
                                                                          backgroundColor:
                                                                              Colors.red,
                                                                        ),
                                                                      );
                                                                    }
                                                                  },
                                                                  items: <
                                                                      String>[
                                                                    'Pending',
                                                                    'On Going',
                                                                    'Repaired',
                                                                    'Delivered',
                                                                  ].map<
                                                                      DropdownMenuItem<
                                                                          String>>((String
                                                                      value) {
                                                                    return DropdownMenuItem<
                                                                        String>(
                                                                      value:
                                                                          value,
                                                                      child: Text(
                                                                          value),
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
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 15),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                          "Name: ",
                                                          style: GoogleFonts
                                                              .poppins(
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: Colors
                                                                      .black),
                                                        ),
                                                        Container(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width /
                                                              1.7,
                                                          child: Text(
                                                            docTodayData[
                                                                "Name"],
                                                            style: GoogleFonts
                                                                .poppins(
                                                                    fontSize:
                                                                        18,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    color: Colors
                                                                        .grey),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 15),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                          "Mobile No: ",
                                                          style: GoogleFonts
                                                              .poppins(
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: Colors
                                                                      .black),
                                                        ),
                                                        Container(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width /
                                                              2,
                                                          child: Text(
                                                            docTodayData[
                                                                "Mobile No"],
                                                            style: GoogleFonts
                                                                .poppins(
                                                                    fontSize:
                                                                        18,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    color: Colors
                                                                        .grey),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Row(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal: 15,
                                                                vertical: 5),
                                                        child: Text(
                                                          docTodayData["Item"],
                                                          style: GoogleFonts
                                                              .poppins(
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: Colors
                                                                      .black),
                                                        ),
                                                      ),
                                                      const Spacer(),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                right: 15),
                                                        child: Text(
                                                          docTodayData["Cost"],
                                                          style: GoogleFonts
                                                              .poppins(
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: Colors
                                                                      .black),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      SizedBox(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            1.3,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 10),
                                                          child: Text(
                                                            docTodayData[
                                                                "Problem"],
                                                            style: GoogleFonts
                                                                .poppins(
                                                                    fontSize:
                                                                        13,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    color: Colors
                                                                        .grey),
                                                          ),
                                                        ),
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
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 15),
                                                    child: Column(
                                                      children: [
                                                        Align(
                                                          alignment:
                                                              Alignment.topLeft,
                                                          child: const Text(
                                                            "Delivered:",
                                                            style: TextStyle(
                                                                fontSize: 20,
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ),
                                                        Row(
                                                          children: [
                                                            Text(
                                                              docTodayData[
                                                                      "Delivered Time"] +
                                                                  ", " as String,
                                                              style: GoogleFonts.poppins(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: Colors
                                                                      .grey),
                                                            ),
                                                            Text(
                                                              docTodayData[
                                                                      "Delivered Date"]
                                                                  as String,
                                                              style: GoogleFonts.poppins(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: Colors
                                                                      .grey),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(height: 10),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      10),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              InkWell(
                                                                onTap:
                                                                    () async {
                                                                  String
                                                                      mobileno =
                                                                      docTodayData[
                                                                          "Mobile No"];
                                                                  String message = "Dear Customer, " +
                                                                      docTodayData[
                                                                          "Name"] +
                                                                      ',\n your ' +
                                                                      docTodayData[
                                                                          "Item"] +
                                                                      ", Pc No " +
                                                                      docTodayData[
                                                                          "Pc No"] +
                                                                      " has Delivered and charge of it is " +
                                                                      docTodayData[
                                                                          "Cost"] +
                                                                      ", Thank you for contect us,\n Pc Computer.";
                                                                  final Uri
                                                                      whatsapp =
                                                                      Uri.parse(
                                                                          'whatsapp://send/?phone=$mobileno&text=$message');

                                                                  // ignore: deprecated_member_use
                                                                  await launchUrl(
                                                                      whatsapp);
                                                                },
                                                                child:
                                                                    Container(
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width /
                                                                      4,
                                                                  height: 40,
                                                                  decoration: BoxDecoration(
                                                                      color: Colors
                                                                          .green
                                                                          .shade900,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10)),
                                                                  child: Center(
                                                                    child: Text(
                                                                      "Whatsapp",
                                                                      style: TextStyle(
                                                                          color:
                                                                              Colors.white),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              InkWell(
                                                                onTap:
                                                                    () async {
                                                                  String
                                                                      mobileno =
                                                                      docTodayData[
                                                                          "Mobile No"];
                                                                  final Uri call = Uri(
                                                                      scheme:
                                                                          'tel',
                                                                      path:
                                                                          mobileno);
                                                                  // ignore: deprecated_member_use
                                                                  if (await canLaunch(
                                                                      call.toString())) {
                                                                    // ignore: deprecated_member_use
                                                                    await launch(
                                                                        call.toString());
                                                                  } else {
                                                                    print(
                                                                        "no action");
                                                                  }
                                                                },
                                                                child:
                                                                    Container(
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width /
                                                                      4,
                                                                  height: 40,
                                                                  decoration: BoxDecoration(
                                                                      color: Colors
                                                                          .green,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10)),
                                                                  child: Center(
                                                                    child: Text(
                                                                      "Call",
                                                                      style: TextStyle(
                                                                          color:
                                                                              Colors.white),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              InkWell(
                                                                onTap:
                                                                    () async {
                                                                  String
                                                                      mobileno =
                                                                      docTodayData[
                                                                          "Mobile No"];
                                                                  String message = "Dear Customer, " +
                                                                      docTodayData[
                                                                          "Name"] +
                                                                      ',\n your ' +
                                                                      docTodayData[
                                                                          "Item"] +
                                                                      ", Pc No " +
                                                                      docTodayData[
                                                                          "Pc No"] +
                                                                      " has Delivered and charge of it is " +
                                                                      docTodayData[
                                                                          "Cost"] +
                                                                      ", Thank you for contect us,\n Pc Computer.";
                                                                  // final Uri sms = Uri.parse(
                                                                  //     'sms:$mobileno?body=$message');
                                                                  final String
                                                                      smsandroid =
                                                                      'sms:$mobileno?body=$message';
                                                                  // ignore: deprecated_member_use
                                                                  if (await canLaunch(
                                                                      smsandroid)) {
                                                                    // ignore: deprecated_member_use
                                                                    await launch(
                                                                        smsandroid);
                                                                  } else {
                                                                    throw 'Could not launch';
                                                                  }
                                                                },
                                                                child:
                                                                    Container(
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width /
                                                                      4,
                                                                  height: 40,
                                                                  decoration: BoxDecoration(
                                                                      color: Colors
                                                                          .blue,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10)),
                                                                  child: Center(
                                                                    child: Text(
                                                                      "Sms",
                                                                      style: TextStyle(
                                                                          color:
                                                                              Colors.white),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
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
                                      return const SizedBox(
                                          width: 0, height: 0);
                                    }
                                  },
                                );
                        } else {
                          return const Center(child: Text("Search Pc No.."));
                        }
                      },
                    ),
                  ),
                )
              : SingleChildScrollView(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('TodayData')
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (SearchValue != "") {
                          return (snapshot.connectionState ==
                                  ConnectionState.waiting)
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : ListView.builder(
                                  itemCount: snapshot.data!.docs.length,
                                  itemBuilder: (contest, index) {
                                    var docTodayData =
                                        snapshot.data!.docs[index].data()
                                            as Map<String, dynamic>;
                                    String uid = snapshot.data!.docs[index].id;

                                    if (docTodayData["Progress"] ==
                                            "Delivered" &&
                                        docTodayData['Mobile No']
                                            .toString()
                                            .toLowerCase()
                                            .contains(
                                                SearchValue.toLowerCase())) {
                                      String dropdownValue = 'Delivered';
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15, vertical: 10),
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    ItemDataPage(
                                                  uid: uid,
                                                ),
                                              ),
                                            );
                                          },
                                          child: Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15)),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  Container(
                                                    decoration: const BoxDecoration(
                                                        color: Colors.purple,
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                topRight: Radius
                                                                    .circular(
                                                                        10),
                                                                topLeft: Radius
                                                                    .circular(
                                                                        10))),
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 15),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          SizedBox(
                                                            height: 25,
                                                            width: 200,
                                                            child: Align(
                                                              alignment: Alignment
                                                                  .bottomLeft,
                                                              child: Text(
                                                                'Pc No: ${docTodayData["Pc No"]}',
                                                                style: GoogleFonts.ubuntu(
                                                                    fontSize:
                                                                        20,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    color: Colors
                                                                        .white),
                                                              ),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    vertical:
                                                                        10),
                                                            child: Container(
                                                              width: 100,
                                                              height: 40,
                                                              decoration: BoxDecoration(
                                                                  color: Colors
                                                                      .purple
                                                                      .shade200,
                                                                  borderRadius: const BorderRadius
                                                                          .only(
                                                                      topRight:
                                                                          Radius.circular(
                                                                              10),
                                                                      bottomLeft:
                                                                          Radius.circular(
                                                                              10))),
                                                              child: Center(
                                                                child:
                                                                    DropdownButton<
                                                                        String>(
                                                                  value:
                                                                      dropdownValue,
                                                                  dropdownColor:
                                                                      const Color
                                                                              .fromARGB(
                                                                          255,
                                                                          16,
                                                                          121,
                                                                          174),
                                                                  style: GoogleFonts
                                                                      .poppins(
                                                                          color:
                                                                              Colors.white),
                                                                  underline:
                                                                      const SizedBox(),
                                                                  iconSize: 0,
                                                                  onChanged:
                                                                      (String?
                                                                          newValue) {
                                                                    setState(
                                                                        () {
                                                                      dropdownValue =
                                                                          newValue!;
                                                                    });
                                                                    docTodayData[
                                                                            "Progress"] ==
                                                                        dropdownValue;
                                                                    try {
                                                                      FirebaseFirestore
                                                                          .instance
                                                                          .collection(
                                                                              "TodayData")
                                                                          .doc(docTodayData[
                                                                              "Pc No"])
                                                                          .update({
                                                                        "Progress":
                                                                            dropdownValue,
                                                                        "Uid":
                                                                            uid
                                                                      }).then((_) {
                                                                        print("success!" +
                                                                            dropdownValue);
                                                                        print(
                                                                            uid);
                                                                      });
                                                                      WriteData().addprogress(
                                                                          docTodayData[
                                                                              "Pc No"],
                                                                          dropdownValue,
                                                                          context);
                                                                      WriteData().removeprogress(
                                                                          docTodayData[
                                                                              "Pc No"],
                                                                          "Pending",
                                                                          context);
                                                                      FirebaseFirestore
                                                                          .instance
                                                                          .collection(
                                                                              "Customers")
                                                                          .doc(docTodayData[
                                                                              "Mobile No"])
                                                                          .collection(
                                                                              "PcNumber")
                                                                          .doc(docTodayData[
                                                                              "Pc No"])
                                                                          .collection(
                                                                              "Data")
                                                                          .doc(
                                                                              uid)
                                                                          .set(
                                                                              docTodayData);
                                                                    } on FirebaseException catch (e) {
                                                                      ScaffoldMessenger.of(
                                                                              context)
                                                                          .showSnackBar(
                                                                        SnackBar(
                                                                          content: Text(e
                                                                              .message
                                                                              .toString()),
                                                                          backgroundColor:
                                                                              Colors.red,
                                                                        ),
                                                                      );
                                                                    }
                                                                  },
                                                                  items: <
                                                                      String>[
                                                                    'Pending',
                                                                    'On Going',
                                                                    'Repaired',
                                                                    'Delivered',
                                                                  ].map<
                                                                      DropdownMenuItem<
                                                                          String>>((String
                                                                      value) {
                                                                    return DropdownMenuItem<
                                                                        String>(
                                                                      value:
                                                                          value,
                                                                      child: Text(
                                                                          value),
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
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 15),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                          "Name: ",
                                                          style: GoogleFonts
                                                              .poppins(
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: Colors
                                                                      .black),
                                                        ),
                                                        Container(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width /
                                                              1.7,
                                                          child: Text(
                                                            docTodayData[
                                                                "Name"],
                                                            style: GoogleFonts
                                                                .poppins(
                                                                    fontSize:
                                                                        18,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    color: Colors
                                                                        .grey),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 15),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                          "Mobile No: ",
                                                          style: GoogleFonts
                                                              .poppins(
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: Colors
                                                                      .black),
                                                        ),
                                                        Container(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width /
                                                              2,
                                                          child: Text(
                                                            docTodayData[
                                                                "Mobile No"],
                                                            style: GoogleFonts
                                                                .poppins(
                                                                    fontSize:
                                                                        18,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    color: Colors
                                                                        .grey),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Row(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal: 15,
                                                                vertical: 5),
                                                        child: Text(
                                                          docTodayData["Item"],
                                                          style: GoogleFonts
                                                              .poppins(
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: Colors
                                                                      .black),
                                                        ),
                                                      ),
                                                      const Spacer(),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                right: 15),
                                                        child: Text(
                                                          docTodayData["Cost"],
                                                          style: GoogleFonts
                                                              .poppins(
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: Colors
                                                                      .black),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      SizedBox(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            1.3,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 10),
                                                          child: Text(
                                                            docTodayData[
                                                                "Problem"],
                                                            style: GoogleFonts
                                                                .poppins(
                                                                    fontSize:
                                                                        13,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    color: Colors
                                                                        .grey),
                                                          ),
                                                        ),
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
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 15),
                                                    child: Column(
                                                      children: [
                                                        Align(
                                                          alignment:
                                                              Alignment.topLeft,
                                                          child: const Text(
                                                            "Delivered:",
                                                            style: TextStyle(
                                                                fontSize: 20,
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ),
                                                        Row(
                                                          children: [
                                                            Text(
                                                              docTodayData[
                                                                      "Delivered Time"] +
                                                                  ", " as String,
                                                              style: GoogleFonts.poppins(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: Colors
                                                                      .grey),
                                                            ),
                                                            Text(
                                                              docTodayData[
                                                                      "Delivered Date"]
                                                                  as String,
                                                              style: GoogleFonts.poppins(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: Colors
                                                                      .grey),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(height: 10),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      10),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              InkWell(
                                                                onTap:
                                                                    () async {
                                                                  String
                                                                      mobileno =
                                                                      docTodayData[
                                                                          "Mobile No"];
                                                                  String message = "Dear Customer, " +
                                                                      docTodayData[
                                                                          "Name"] +
                                                                      ',\n your ' +
                                                                      docTodayData[
                                                                          "Item"] +
                                                                      ", Pc No " +
                                                                      docTodayData[
                                                                          "Pc No"] +
                                                                      " has Delivered and charge of it is " +
                                                                      docTodayData[
                                                                          "Cost"] +
                                                                      ", Thank you for contect us,\n Pc Computer.";
                                                                  final Uri
                                                                      whatsapp =
                                                                      Uri.parse(
                                                                          'whatsapp://send/?phone=$mobileno&text=$message');

                                                                  // ignore: deprecated_member_use
                                                                  await launchUrl(
                                                                      whatsapp);
                                                                },
                                                                child:
                                                                    Container(
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width /
                                                                      4,
                                                                  height: 40,
                                                                  decoration: BoxDecoration(
                                                                      color: Colors
                                                                          .green
                                                                          .shade900,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10)),
                                                                  child: Center(
                                                                    child: Text(
                                                                      "Whatsapp",
                                                                      style: TextStyle(
                                                                          color:
                                                                              Colors.white),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              InkWell(
                                                                onTap:
                                                                    () async {
                                                                  String
                                                                      mobileno =
                                                                      docTodayData[
                                                                          "Mobile No"];
                                                                  final Uri call = Uri(
                                                                      scheme:
                                                                          'tel',
                                                                      path:
                                                                          mobileno);
                                                                  // ignore: deprecated_member_use
                                                                  if (await canLaunch(
                                                                      call.toString())) {
                                                                    // ignore: deprecated_member_use
                                                                    await launch(
                                                                        call.toString());
                                                                  } else {
                                                                    print(
                                                                        "no action");
                                                                  }
                                                                },
                                                                child:
                                                                    Container(
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width /
                                                                      4,
                                                                  height: 40,
                                                                  decoration: BoxDecoration(
                                                                      color: Colors
                                                                          .green,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10)),
                                                                  child: Center(
                                                                    child: Text(
                                                                      "Call",
                                                                      style: TextStyle(
                                                                          color:
                                                                              Colors.white),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              InkWell(
                                                                onTap:
                                                                    () async {
                                                                  String
                                                                      mobileno =
                                                                      docTodayData[
                                                                          "Mobile No"];
                                                                  String message = "Dear Customer, " +
                                                                      docTodayData[
                                                                          "Name"] +
                                                                      ',\n your ' +
                                                                      docTodayData[
                                                                          "Item"] +
                                                                      ", Pc No " +
                                                                      docTodayData[
                                                                          "Pc No"] +
                                                                      " has Delivered and charge of it is " +
                                                                      docTodayData[
                                                                          "Cost"] +
                                                                      ", Thank you for contect us,\n Pc Computer.";
                                                                  // final Uri sms = Uri.parse(
                                                                  //     'sms:$mobileno?body=$message');
                                                                  final String
                                                                      smsandroid =
                                                                      'sms:$mobileno?body=$message';
                                                                  // ignore: deprecated_member_use
                                                                  if (await canLaunch(
                                                                      smsandroid)) {
                                                                    // ignore: deprecated_member_use
                                                                    await launch(
                                                                        smsandroid);
                                                                  } else {
                                                                    throw 'Could not launch';
                                                                  }
                                                                },
                                                                child:
                                                                    Container(
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width /
                                                                      4,
                                                                  height: 40,
                                                                  decoration: BoxDecoration(
                                                                      color: Colors
                                                                          .blue,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10)),
                                                                  child: Center(
                                                                    child: Text(
                                                                      "Sms",
                                                                      style: TextStyle(
                                                                          color:
                                                                              Colors.white),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
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
                                      return const SizedBox(
                                          width: 0, height: 0);
                                    }
                                  },
                                );
                        } else {
                          return const Center(
                              child: Text("Search Mobile No.."));
                        }
                      },
                    ),
                  ),
                ),
    );
  }
}
