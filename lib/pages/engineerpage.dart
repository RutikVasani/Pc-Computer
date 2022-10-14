import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EngineerPage extends StatefulWidget {
  const EngineerPage({Key? key}) : super(key: key);

  @override
  State<EngineerPage> createState() => _EngineerPageState();
}

class _EngineerPageState extends State<EngineerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.red,
        height: MediaQuery.of(context).size.height / 2,
        child: StreamBuilder(
            stream:
                FirebaseFirestore.instance.collection('Customers').snapshots(),
            builder: (__,
                AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
              if (snapshot.hasData && snapshot.data != null) {
                if (snapshot.data!.docs.isNotEmpty) {
                  return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (___, int index) {
                        Map<String, dynamic> docMobileData =
                            snapshot.data!.docs[index].data();
                        String uid = snapshot.data!.docs[index].id;
                        if (docMobileData.isEmpty) {
                          return const SizedBox(
                            child: Center(
                              child: Text("Document is Empty"),
                            ),
                          );
                        }
                        return SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              color: Colors.white,
                              height: MediaQuery.of(context).size.height / 3,
                              child: StreamBuilder(
                                  stream: FirebaseFirestore.instance
                                      .collection('Customers')
                                      .doc(uid)
                                      .collection('PcNumber')
                                      .snapshots(),
                                  builder: (__,
                                      AsyncSnapshot<
                                              QuerySnapshot<Map<String, dynamic>>>
                                          snapshot) {
                                    if (snapshot.hasData &&
                                        snapshot.data != null) {
                                      if (snapshot.data!.docs.isNotEmpty) {
                                        return ListView.builder(
                                            itemCount: snapshot.data!.docs.length,
                                            itemBuilder: (___, int index1) {
                                              Map<String, dynamic> docPcData =
                                                  snapshot.data!.docs[index1]
                                                      .data();
                                              String PcNoid =
                                                  snapshot.data!.docs[index1].id;
                                              return Text(
                                                docPcData["Pc No"],
                                              );
                                            });
                                      } else {
                                        return const Center(
                                          child:
                                              Text("Document aren't available"),
                                        );
                                      }
                                    } else {
                                      return const Center(
                                        child: Text("Getting Error"),
                                      );
                                    }
                                  }),
                            ),
                          ),
                        );
                      });
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
            }),
      ),
    );
  }
}
