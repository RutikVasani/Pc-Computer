import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pc1/appbarpage.dart';
import 'package:pc1/models/pcnodialog.dart';
import 'package:pc1/pages/homepage.dart';
import 'package:pc1/pages/new_cust/newcustform.dart';
import 'package:pc1/pages/search/viewPcData.dart';

class SearchDataPage extends StatefulWidget {
  String Mobileno;
  String Name;
  SearchDataPage({Key? key, required this.Mobileno, required this.Name})
      : super(key: key);

  @override
  State<SearchDataPage> createState() => _SearchDataPageState();
}

class _SearchDataPageState extends State<SearchDataPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 211, 244, 247),
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: const Color.fromARGB(255, 16, 121, 174),
        title: Row(
          children: [
            Text(
              widget.Name,
              style: GoogleFonts.ubuntu(fontSize: 20),
            ),
            SizedBox(width: 5),
            Text(
              "(" + widget.Mobileno + ")",
              style: GoogleFonts.ubuntu(fontSize: 20),
            ),
          ],
        ),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AppBarPage(),
                  ),
                );
              },
              icon: Icon(
                Icons.keyboard_backspace,
                size: 30,
              )),
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("Customers")
            .doc(widget.Mobileno)
            .collection("PcNumber")
            .snapshots(),
        builder:
            (__, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            if (snapshot.data!.docs.isNotEmpty) {
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (___, int index) {
                  Map<String, dynamic> docPcNo =
                      snapshot.data!.docs[index].data();
                  String uid = snapshot.data!.docs[index].id;
                  if (docPcNo.isEmpty) {
                    return const SizedBox(
                      child: Center(
                        child: Text("Document is Empty"),
                      ),
                    );
                  }
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(children: [
                      Container(
                        color: Colors.white,
                        height: 50,
                        child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Pc No: ${docPcNo["Pc No"]}',
                                    style: GoogleFonts.ubuntu(
                                        fontSize: 23,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black),
                                  ),
                                  Row(
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  ViewPcDataPage(
                                                      Mobileno: widget.Mobileno,
                                                      Name: widget.Name,
                                                      Pcno: docPcNo["Pc No"]),
                                            ),
                                          );
                                        },
                                        icon: const Icon(
                                          Icons.remove_red_eye_rounded,
                                          size: 35,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  NewCustFormPage(
                                                      mobileno: widget.Mobileno,
                                                      pcno: docPcNo["Pc No"],
                                                      name: widget.Name),
                                            ),
                                          );
                                        },
                                        icon: const Icon(
                                          Icons.add,
                                          size: 35,
                                          color: Colors.blue,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            )),
                      ),
                      const Divider(
                        color: Colors.black,
                        thickness: 3,
                      )
                    ]),
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
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
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
          Padding(
            padding: const EdgeInsets.only(right: 15, bottom: 15),
            child: FloatingActionButton(
              backgroundColor: const Color.fromARGB(255, 16, 121, 174),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PcNoDialogPage(
                        Mobileno: widget.Mobileno, Name: widget.Name),
                  ),
                );
              },
              child: const Icon(
                Icons.add,
                size: 30,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
