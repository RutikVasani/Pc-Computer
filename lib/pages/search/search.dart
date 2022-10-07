import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pc1/pages/search/searchdata.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String Mobileno = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 16, 121, 174),
          title: Card(
            child: TextField(
              decoration: const InputDecoration(
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                  hintText: 'Search...'),
              onChanged: (value) {
                setState(
                  () {
                    Mobileno = value;
                  },
                );
              },
            ),
          )),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Customers').snapshots(),
        builder: (context, snapshot) {
          if (Mobileno != "") {
            return (snapshot.connectionState == ConnectionState.waiting)
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      if (Mobileno == "") {
                        return const SizedBox(height: 0, width: 0);
                      }
                      var data = snapshot.data!.docs[index].data()
                          as Map<String, dynamic>;
                      if (data['Mobile No']
                          .toString()
                          .contains(Mobileno.toLowerCase())) {
                        return InkWell(
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    SearchDataPage(Mobileno: data['Mobile No'], Name: data['Name'],),
                              ),
                            );
                          },
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 3),
                                child: Container(
                                  // color: Colors.red,
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 3),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              data['Mobile No'],
                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.poppins(
                                                  fontSize: 20,
                                                  color: Colors.black),
                                            ),
                                            const Icon(
                                              Icons.navigate_next,
                                              size: 35,
                                            )
                                          ],
                                        ),
                                        Align(
                                          alignment: Alignment.topLeft,
                                          child: Text(data['Name']),
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
                      }
                      return const SizedBox(height: 0, width: 0);
                    },
                  );
          } else {
            return const Center(child: Text("Search Mobile No.."));
          }
        },
      ),
    );
  }
}
