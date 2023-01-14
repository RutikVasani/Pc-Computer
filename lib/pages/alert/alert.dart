import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ShowAlertDataPage extends StatefulWidget {
  const ShowAlertDataPage({super.key});

  @override
  State<ShowAlertDataPage> createState() => _ShowAlertDataPageState();
}

class _ShowAlertDataPageState extends State<ShowAlertDataPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 211, 244, 247),
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: const Color.fromARGB(255, 16, 121, 174),
        title: Text('Changes ',
            style:
                GoogleFonts.ubuntu(fontSize: 25, fontWeight: FontWeight.bold)),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("Alert").snapshots(),
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
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width,
                              decoration: const BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(10),
                                      topLeft: Radius.circular(10))),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      child: Align(
                                        alignment: Alignment.bottomLeft,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            'Pc No: ${docTodayData["Pc No"]}',
                                            style: GoogleFonts.ubuntu(
                                                fontSize: 23,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: Align(
                                          alignment: Alignment.bottomLeft,
                                          child: Row(
                                            children: [
                                              IconButton(
                                                onPressed: () {
                                                  FirebaseFirestore.instance
                                                      .collection("TodayData")
                                                      .doc(
                                                          docTodayData["Pc No"])
                                                      .update({
                                                    "Progress": docTodayData[
                                                        "Progress"],
                                                    "Problem":
                                                        docTodayData["Problem"],
                                                    "Cost":
                                                        docTodayData["Cost"],
                                                    "Remarks":
                                                        docTodayData["Remarks"],
                                                  });
                                                  FirebaseFirestore.instance
                                                      .collection("Alert")
                                                      .doc(
                                                          docTodayData["Pc No"])
                                                      .delete();
                                                  Navigator.pop(context);
                                                },
                                                icon: Container(
                                                  width: 40,
                                                  height: 40,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    color: Colors.blue.shade200,
                                                  ),
                                                  child: const Icon(
                                                    Icons.done,
                                                    size: 30,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                              IconButton(
                                                onPressed: () {
                                                  FirebaseFirestore.instance
                                                      .collection("TodayData")
                                                      .doc(
                                                          docTodayData["Pc No"])
                                                      .update({
                                                    "Progress":
                                                        docTodayData["Progress"]
                                                  });
                                                  FirebaseFirestore.instance
                                                      .collection("Alert")
                                                      .doc(
                                                          docTodayData["Pc No"])
                                                      .delete();
                                                  Navigator.pop(context);
                                                },
                                                icon: Container(
                                                  width: 40,
                                                  height: 40,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    color: Colors.blue.shade200,
                                                  ),
                                                  child: const Icon(
                                                    Icons.close,
                                                    size: 30,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 5),
                            // Padding(
                            //   padding:
                            //       const EdgeInsets.symmetric(horizontal: 15),
                            //   child: Row(
                            //     children: [
                            //       Text(
                            //         "Name: ",
                            //         style: GoogleFonts.poppins(
                            //             fontSize: 20,
                            //             fontWeight: FontWeight.w600,
                            //             color: Colors.black),
                            //       ),
                            //       Container(
                            //         width:
                            //             MediaQuery.of(context).size.width / 1.5,
                            //         child: Text(
                            //           docTodayData["Name"],
                            //           style: GoogleFonts.poppins(
                            //               fontSize: 18,
                            //               fontWeight: FontWeight.w600,
                            //               color: Colors.grey),
                            //         ),
                            //       ),
                            //     ],
                            //   ),
                            // ),
                            SizedBox(height: 5),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: Row(
                                children: [
                                  Text(
                                    "Device: ",
                                    style: GoogleFonts.poppins(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black),
                                  ),
                                  Text(
                                    docTodayData["Item"],
                                    style: GoogleFonts.poppins(
                                        fontSize: 18, color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              child: Divider(
                                thickness: 2,
                                height: 2,
                                color: Colors.grey,
                              ),
                            ),
                            const Align(
                              alignment: Alignment.topLeft,
                              child: Padding(
                                padding: EdgeInsets.only(left: 15, top: 7),
                                child: Text(
                                  "Problem",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 1.1,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: Text(
                                  docTodayData["Problem"],
                                  style: GoogleFonts.poppins(
                                      fontSize: 18, color: Colors.grey),
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              child: Divider(
                                thickness: 2,
                                height: 2,
                                color: Colors.grey,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 7),
                              child: Row(
                                children: [
                                  Text(
                                    "Cost: ",
                                    style: GoogleFonts.poppins(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black),
                                  ),
                                  Text(
                                    docTodayData["Cost"],
                                    style: GoogleFonts.poppins(
                                        fontSize: 18, color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              child: Divider(
                                thickness: 2,
                                height: 2,
                                color: Colors.grey,
                              ),
                            ),
                            const Align(
                              alignment: Alignment.topLeft,
                              child: Padding(
                                padding: EdgeInsets.only(left: 15, top: 7),
                                child: Text(
                                  "Remarks: ",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 1.1,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 15, top: 3),
                                child: Text(
                                  docTodayData["Remarks"],
                                  style: GoogleFonts.poppins(
                                      fontSize: 18, color: Colors.grey),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                          ],
                        )),
                  );
                },
              );
            } else {
              return const Center(
                child: Text("Document aren't available"),
              );
            }
          } else {
            return const Center(
              child: Text("Getting Error"),
            );
          }
        },
      ),
    );
  }
}
