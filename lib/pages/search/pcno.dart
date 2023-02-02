import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PcNoSearchPage extends StatefulWidget {
  const PcNoSearchPage({super.key});

  @override
  State<PcNoSearchPage> createState() => _PcNoSearchPageState();
}

class _PcNoSearchPageState extends State<PcNoSearchPage> {
  String Mobileno = "";
  String SearchValue = "";
  bool _digit = false;
  bool _search = true;
  bool _pcno = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 16, 121, 174),
        title: TextField(
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
                                  itemBuilder: (context, index1) {
                                    var data = snapshot.data!.docs[index1]
                                        .data() as Map<String, dynamic>;
                                    if (data['Pc No']
                                        .toString()
                                        .contains(SearchValue.toLowerCase())) {
                                      return InkWell(
                                        onTap: () {},
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 15,
                                                      vertical: 3),
                                              child: Container(
                                                // color: Colors.red,
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 3),
                                                  child: Column(
                                                    children: [
                                                      Align(
                                                        alignment:
                                                            Alignment.topLeft,
                                                        child: Text(
                                                          data['Pc No'],
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: GoogleFonts
                                                              .poppins(
                                                                  fontSize: 20,
                                                                  color: Colors
                                                                      .black),
                                                        ),
                                                      ),
                                                      Align(
                                                        alignment:
                                                            Alignment.topLeft,
                                                        child: Text(
                                                            data['Progress']),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const Divider(
                                              color: Colors.black,
                                            )
                                          ],
                                        ),
                                      );
                                    } else if (SearchValue.length == 10 &&
                                        SearchValue != data['Pc No']) {
                                      print(SearchValue.length);
                                    }
                                    return const SizedBox(height: 0, width: 0);
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
                                  itemBuilder: (context, index1) {
                                    var data = snapshot.data!.docs[index1]
                                        .data() as Map<String, dynamic>;
                                    if (data['Pc No']
                                        .toString()
                                        .contains(SearchValue.toLowerCase())) {
                                      return InkWell(
                                        onTap: () {},
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 15,
                                                      vertical: 3),
                                              child: Container(
                                                // color: Colors.red,
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 3),
                                                  child: Column(
                                                    children: [
                                                      Align(
                                                        alignment:
                                                            Alignment.topLeft,
                                                        child: Text(
                                                          data['Pc No'],
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: GoogleFonts
                                                              .poppins(
                                                                  fontSize: 20,
                                                                  color: Colors
                                                                      .black),
                                                        ),
                                                      ),
                                                      Align(
                                                        alignment:
                                                            Alignment.topLeft,
                                                        child: Text(
                                                            data['Progress']),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const Divider(
                                              color: Colors.black,
                                            )
                                          ],
                                        ),
                                      );
                                    } else if (SearchValue.length == 10 &&
                                        SearchValue != data['Pc No']) {
                                      print(SearchValue.length);
                                    }
                                    return const SizedBox(height: 0, width: 0);
                                  },
                                );
                        } else {
                          return const Center(child: Text("Search Mobile No.."));
                        }
                      },
                    ),
                  ),
                ),
    );
  }
}
