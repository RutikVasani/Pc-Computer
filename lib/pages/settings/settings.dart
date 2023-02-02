import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 16, 121, 174),
        title: Text(
          "Settings",
          style: GoogleFonts.ubuntu(
              fontSize: 25, fontWeight: FontWeight.bold, letterSpacing: 2),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      "Pc No : ",
                      style: GoogleFonts.ubuntu(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2),
                    ),
                    Container(
                      width: 150,
                      height: 30,
                      child: StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('Pc No')
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (!snapshot.hasData) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          return ListView(
                            children: snapshot.data!.docs.map((document) {
                              String pc = document["Pc No"].toString();
                              return Align(
                                alignment: Alignment.centerLeft,
                                child: InkWell(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text('Update Pc No'),
                                          content: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: SizedBox(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: TextFormField(
                                                initialValue: pc,
                                                decoration:
                                                    const InputDecoration(
                                                  labelText: 'Pc No.',
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  15))),
                                                  prefixIcon: Icon(
                                                      Icons.computer),
                                                ),
                                                onChanged: (value) {
                                                  // setState(() {
                                                  //   docItemData["Cost"] = value;
                                                  // });
                                                  setState(() {
                                                    pc = value;
                                                  });
                                                },
                                              ),
                                            ),
                                          ),
                                          actions: [
                                            TextButton(
                                              // textColor: Colors.black,
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: Text('CANCEL'),
                                            ),
                                            TextButton(
                                              // textColor: Colors.black,
                                              onPressed: () {
                                                try {
                                                  FirebaseFirestore.instance
                                                      .collection('Pc No')
                                                      .doc("Pc No")
                                                      .update({
                                                    "Pc No": pc
                                                  }).then(
                                                    (result) {
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                        const SnackBar(
                                                          content: Text(
                                                              "Pc No Update"),
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
                                                      backgroundColor:
                                                          Colors.red,
                                                    ),
                                                  );
                                                }
                                                Navigator.pop(context);
                                              },
                                              child: Text('ACCEPT'),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  child: Container(
                                    child: Text(
                                      pc,
                                      style: GoogleFonts.ubuntu(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 2),
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
