import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pc1/appbarpage.dart';
import 'package:pc1/pages/invoice/pdf/pdfdata.dart';
import 'package:pc1/pages/itemdata.dart';

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
            .orderBy('Delivered Date', descending: true)
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
                                          height: 30,
                                          width: 200,
                                          child: Align(
                                            alignment: Alignment.bottomLeft,
                                            child: Text(
                                              'Pc No: ${docTodayData["Pc No"]}',
                                              style: GoogleFonts.ubuntu(
                                                  fontSize: 23,
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
                                                child: Text(
                                              "Delivered",
                                              style: GoogleFonts.poppins(
                                                  color: Colors.white),
                                            )),
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
                                                1.5,
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
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width /
                                          1.3,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Text(
                                          docTodayData["Problem"],
                                          style: GoogleFonts.poppins(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.grey),
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const PdfDataPage(),
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
                                  padding: const EdgeInsets.only(left: 15),
                                  child: Column(
                                    children: [
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: const Text(
                                          "Delivered:",
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Row(
                                        children: [
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
