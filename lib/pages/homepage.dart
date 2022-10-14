import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:pc1/models/MobileDialog.dart';
import 'package:pc1/models/pcnodialog.dart';
import 'package:pc1/pages/Daily%20Progress/Delivered%20Pc/deliveredpc.dart';
import 'package:pc1/pages/Daily%20Progress/Ongoing%20Pc/ongoingpc.dart';
import 'package:pc1/pages/Daily%20Progress/Repaired%20Pc/repairedpc.dart';
import 'package:pc1/pages/Daily%20Progress/Today%20All/todayallpc.dart';
import 'package:pc1/pages/search/viewPcData.dart';

import 'search/searchdata.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String Mobileno = "";
  String SearchValue = "";
  bool _digit = false;
  bool _search = true;
  bool _pcno = true;

  @override
  Widget build(BuildContext context) {
    var date = DateFormat.yMMMEd().format(DateTime.now());

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 211, 244, 247),
      body: OrientationBuilder(builder: (context, orientation) {
        return SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.all(15),
                child: Container(
                  decoration: const BoxDecoration(
                      gradient: RadialGradient(
                        radius: 2,
                        colors: [
                          Color.fromARGB(255, 16, 121, 174),
                          Color.fromARGB(255, 169, 219, 238),
                          Color.fromARGB(255, 16, 121, 174),
                        ],
                        center: Alignment(1.0, -1.0),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white,
                          offset: Offset(-2, 2),
                          blurRadius: 5.0,
                          spreadRadius: 0.0,
                        ),
                      ],
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10, left: 15),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            date,
                            style: GoogleFonts.ubuntu(
                                fontSize: 22, color: Colors.white),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Divider(
                          height: 10,
                          thickness: 2,
                          color: Colors.white,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, left: 20),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text("Search Number",
                              style: GoogleFonts.ubuntu(
                                  color: Colors.black,
                                  fontSize: 23,
                                  fontWeight: FontWeight.w800)),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: 10, left: 15, right: 15),
                        child: TextField(
                          onChanged: (value) {
                            setState(
                              () {
                                SearchValue = value;
                                if (value == "") {
                                  _search = true;
                                } else {
                                  _search = false;
                                }
                                if (value.length == 10) {
                                  _digit = true;
                                } else {
                                  _digit = false;
                                }
                                if (value.length < 5) {
                                  _pcno = true;
                                } else {
                                  _pcno = false;
                                }
                              },
                            );
                          },
                          decoration: InputDecoration(
                            labelText: "Search",
                            hintText: "Search",
                            fillColor: Colors.white,
                            labelStyle: TextStyle(color: Colors.white),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.white, width: 2.0),
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            prefixIcon: const Icon(
                              Icons.search,
                              color: Colors.white,
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MobileNoDialogPage(
                                      MobileNo: SearchValue,
                                    ),
                                  ),
                                );
                              },
                              icon: Icon(
                                _digit ? Icons.add : null,
                                color: Colors.white,
                              ),
                            ),
                            border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                                borderSide: BorderSide(
                                  color: Colors.white,
                                  width: 3,
                                )),
                          ),
                        ),
                      ),
                      _search
                          ? const SizedBox(
                              height: 0,
                              width: 0,
                            )
                          : _pcno
                              ? SingleChildScrollView(
                                  child: SizedBox(
                                    height:
                                        MediaQuery.of(context).size.height / 3,
                                    child: StreamBuilder<QuerySnapshot>(
                                      stream: FirebaseFirestore.instance
                                          .collection('Customers')
                                          .snapshots(),
                                      builder: (context, snapshot) {
                                        if (SearchValue != "") {
                                          return (snapshot.connectionState ==
                                                  ConnectionState.waiting)
                                              ? const Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                )
                                              : ListView.builder(
                                                  itemCount: snapshot
                                                      .data!.docs.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    var docMobile = snapshot
                                                            .data!.docs[index]
                                                            .data()
                                                        as Map<String, dynamic>;
                                                    String uid = snapshot
                                                        .data!.docs[index].id;
                                                    print("Search Value: ");
                                                    print(docMobile['All Pc']
                                                        .toString()
                                                        .contains(SearchValue
                                                            .toLowerCase()));
                                                    if (docMobile['All Pc']
                                                        .toString()
                                                        .contains(SearchValue
                                                            .toLowerCase())) {
                                                      return SingleChildScrollView(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: SizedBox(
                                                            height: 50,
                                                            child:
                                                                StreamBuilder(
                                                                    stream: FirebaseFirestore
                                                                        .instance
                                                                        .collection(
                                                                            'Customers')
                                                                        .doc(
                                                                            uid)
                                                                        .collection(
                                                                            'PcNumber')
                                                                        .snapshots(),
                                                                    builder: (__,
                                                                        AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                                                                            snapshot) {
                                                                      if (snapshot
                                                                              .hasData &&
                                                                          snapshot.data !=
                                                                              null) {
                                                                        if (snapshot
                                                                            .data!
                                                                            .docs
                                                                            .isNotEmpty) {
                                                                          return ListView.builder(
                                                                              itemCount: snapshot.data!.docs.length,
                                                                              itemBuilder: (___, int index1) {
                                                                                Map<String, dynamic> docPcData = snapshot.data!.docs[index1].data();
                                                                                String PcNoid = snapshot.data!.docs[index1].id;
                                                                                if (docPcData["Pc No"].toString().contains(SearchValue.toLowerCase())) {
                                                                                  return InkWell(
                                                                                    onTap: () {
                                                                                      Navigator.push(
                                                                                        context,
                                                                                        MaterialPageRoute(
                                                                                          builder: (context) => ViewPcDataPage(Mobileno: docMobile["Mobile No"], Name: docMobile["Name"], Pcno: docPcData["Pc No"]),
                                                                                        ),
                                                                                      );
                                                                                    },
                                                                                    child: Container(
                                                                                      height: 45,
                                                                                      color: Colors.amber,
                                                                                      child: Padding(
                                                                                        padding: const EdgeInsets.symmetric(horizontal: 15),
                                                                                        child: Row(
                                                                                          children: [
                                                                                            Text(
                                                                                              "Pc No: ",
                                                                                              style: TextStyle(fontSize: 23, color: Colors.black, fontWeight: FontWeight.w600),
                                                                                            ),
                                                                                            Text(
                                                                                              docPcData["Pc No"],
                                                                                              style: TextStyle(fontSize: 23, color: Colors.blue.shade800, fontWeight: FontWeight.w600),
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  );
                                                                                } else {
                                                                                  return const SizedBox(
                                                                                    height: 0,
                                                                                    width: 0,
                                                                                  );
                                                                                }
                                                                              });
                                                                        } else {
                                                                          return const Center(
                                                                            child:
                                                                                Text("Document aren't available"),
                                                                          );
                                                                        }
                                                                      } else {
                                                                        return const Center(
                                                                          child:
                                                                              Text("Getting Error"),
                                                                        );
                                                                      }
                                                                    }),
                                                          ),
                                                        ),
                                                      );
                                                    } else {
                                                      return const SizedBox(
                                                          height: 0, width: 0);
                                                    }
                                                  },
                                                );
                                        } else {
                                          return const Center(
                                              child: Text("Search Pc No.."));
                                        }
                                      },
                                    ),
                                  ),
                                )
                              : SingleChildScrollView(
                                  child: SizedBox(
                                    height:
                                        MediaQuery.of(context).size.height / 3,
                                    child: StreamBuilder<QuerySnapshot>(
                                      stream: FirebaseFirestore.instance
                                          .collection('Customers')
                                          .snapshots(),
                                      builder: (context, snapshot) {
                                        if (SearchValue != "") {
                                          return (snapshot.connectionState ==
                                                  ConnectionState.waiting)
                                              ? const Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                )
                                              : ListView.builder(
                                                  itemCount: snapshot
                                                      .data!.docs.length,
                                                  itemBuilder:
                                                      (context, index1) {
                                                    var data = snapshot
                                                            .data!.docs[index1]
                                                            .data()
                                                        as Map<String, dynamic>;
                                                    if (data['Mobile No']
                                                        .toString()
                                                        .contains(SearchValue
                                                            .toLowerCase())) {
                                                      return InkWell(
                                                        onTap: () {
                                                          Navigator.pop(
                                                              context);
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (context) =>
                                                                  SearchDataPage(
                                                                Mobileno: data[
                                                                    'Mobile No'],
                                                                Name: data[
                                                                    'Name'],
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                        child: Column(
                                                          children: [
                                                            Padding(
                                                              padding: const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      15,
                                                                  vertical: 3),
                                                              child: Container(
                                                                // color: Colors.red,
                                                                child: Padding(
                                                                  padding: const EdgeInsets
                                                                          .symmetric(
                                                                      vertical:
                                                                          3),
                                                                  child: Column(
                                                                    children: [
                                                                      Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          Text(
                                                                            data['Mobile No'],
                                                                            overflow:
                                                                                TextOverflow.ellipsis,
                                                                            style:
                                                                                GoogleFonts.poppins(fontSize: 20, color: Colors.black),
                                                                          ),
                                                                          const Icon(
                                                                            Icons.navigate_next,
                                                                            size:
                                                                                35,
                                                                          )
                                                                        ],
                                                                      ),
                                                                      Align(
                                                                        alignment:
                                                                            Alignment.topLeft,
                                                                        child: Text(
                                                                            data['Name']),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            const Divider(
                                                              color:
                                                                  Colors.black,
                                                            )
                                                          ],
                                                        ),
                                                      );
                                                    } else if (SearchValue
                                                                .length ==
                                                            10 &&
                                                        SearchValue !=
                                                            data['Mobile No']) {
                                                      print(SearchValue.length);
                                                    }
                                                    return const SizedBox(
                                                        height: 0, width: 0);
                                                  },
                                                );
                                        } else {
                                          return const Center(
                                              child:
                                                  Text("Search Mobile No.."));
                                        }
                                      },
                                    ),
                                  ),
                                ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Daily Progress",
                    style: GoogleFonts.poppins(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const TodayAllPcPage()));
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width / 2.3,
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Color.fromARGB(255, 169, 219, 238),
                                  Color.fromARGB(255, 16, 121, 174)
                                ],
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(15),
                              ),
                            ),
                            child: Column(children: [
                              const SizedBox(height: 10),
                              Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Image.asset("assets/images/computer.png",
                                    height: MediaQuery.of(context).size.height *
                                        .15),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 10, left: 15, right: 15),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "Today All",
                                    style: GoogleFonts.ubuntu(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "Pc",
                                    style: GoogleFonts.ubuntu(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                            ]),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const OngoingPcPage()));
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width / 2.3,
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Color.fromARGB(255, 223, 175, 171),
                                  Color.fromARGB(255, 160, 13, 2)
                                ],
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(15),
                              ),
                            ),
                            child: Column(children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10, top: 8, right: 10),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Image.asset(
                                      "assets/images/ongoing.png",
                                      height:
                                          MediaQuery.of(context).size.height *
                                              .1),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 15, left: 15, right: 15, bottom: 5),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "Ongoing Pc",
                                    style: GoogleFonts.ubuntu(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 15),
                            ]),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 15),
                    Column(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const RepairedPcPage()));
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width / 2.3,
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Color.fromARGB(255, 185, 236, 187),
                                  Color.fromARGB(255, 2, 118, 6)
                                ],
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(15),
                              ),
                            ),
                            child: Column(children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10, top: 8, right: 10),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Image.asset("assets/images/tick.png",
                                      height:
                                          MediaQuery.of(context).size.height *
                                              .1),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 10, left: 15, right: 10, bottom: 5),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "Repaired Pc",
                                    style: GoogleFonts.ubuntu(
                                      fontSize: 23,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 15),
                            ]),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const DeliveredPcPage()));
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width / 2.3,
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Color.fromARGB(255, 213, 180, 223),
                                  Color.fromARGB(255, 87, 2, 118)
                                ],
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(15),
                              ),
                            ),
                            child: Column(children: [
                              const SizedBox(height: 15),
                              Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Image.asset(
                                    "assets/images/delivered.png",
                                    height: MediaQuery.of(context).size.height *
                                        .15),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 10, left: 15, right: 15),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "Delivered Pc",
                                    style: GoogleFonts.ubuntu(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                            ]),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
