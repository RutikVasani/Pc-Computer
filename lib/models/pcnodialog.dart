import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pc1/pages/new_cust/newcustform.dart';
import 'package:pc1/services/writedata.dart';

class PcNoDialogPage extends StatefulWidget {
  String Mobileno;
  String Name;
  PcNoDialogPage({Key? key, required this.Mobileno, required this.Name})
      : super(key: key);

  @override
  State<PcNoDialogPage> createState() => _PcNoDialogPageState();
}

class _PcNoDialogPageState extends State<PcNoDialogPage> {
  late String Pcno;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 211, 244, 247),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 200,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(15)),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Text(
                      "Pc Number",
                      style: GoogleFonts.ubuntu(
                          fontSize: 28,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: TextField(
                      decoration: const InputDecoration(
                        labelText: 'Pc No',
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        prefixIcon: Icon(Icons.person),
                      ),
                      onChanged: (value) {
                        setState(() {
                          Pcno = value;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 7),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: ElevatedButton(
                      child: const Text("Submit"),
                      onPressed: () {
                        Navigator.pop(context);
                        var PcNumId = FirebaseFirestore.instance
                            .collection("Customers")
                            .doc(widget.Mobileno)
                            .collection('Pc Number')
                            .doc(Pcno);
                        Map<String, dynamic> PcNumData = {
                          'Pc No': Pcno,
                          'Date': DateTime.now(),
                        };
                        FirebaseFirestore.instance
                            .collection('Customers')
                            .doc(widget.Mobileno)
                            .update(
                          {
                            "All Pc": FieldValue.arrayUnion(
                              [
                                {"Pc No": Pcno}
                              ],
                            ),
                          },
                        );
                        WriteData()
                            .addPc(widget.Mobileno, Pcno, PcNumData, context)
                            .then(
                          (result) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Pc added"),
                                backgroundColor: Colors.red,
                              ),
                            );
                          },
                        );
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NewCustFormPage(
                                    mobileno: widget.Mobileno,
                                    name: widget.Name,
                                    pcno: Pcno,
                                  )),
                        );
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
