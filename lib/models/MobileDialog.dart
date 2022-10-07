import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pc1/models/pcnodialog.dart';
import 'package:pc1/services/writedata.dart';

class MobileNoDialogPage extends StatefulWidget {
  const MobileNoDialogPage({Key? key}) : super(key: key);

  @override
  State<MobileNoDialogPage> createState() => _MobileNoDialogPageState();
}

class _MobileNoDialogPageState extends State<MobileNoDialogPage> {
  late String Mobileno;
  late String Name;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 211, 244, 247),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 275,
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
                      "New Customer",
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
                        labelText: 'Name',
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        prefixIcon: Icon(Icons.person),
                      ),
                      onChanged: (value) {
                        setState(() {
                          Name = value;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 7),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: TextField(
                      decoration: const InputDecoration(
                        labelText: 'Mobile No.',
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        prefixIcon: Icon(Icons.call),
                      ),
                      onChanged: (value) {
                        setState(() {
                          Mobileno = value;
                        });
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: ElevatedButton(
                      child: const Text("Submit"),
                      onPressed: () {
                        Navigator.pop(context);
                        Map<String, dynamic> custdata = {
                          'Name': Name,
                          'Mobile No': Mobileno,
                          'Date': DateTime.now(),
                        };
                        WriteData().addCust(Mobileno, custdata, context).then(
                          (result) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Customer added"),
                                backgroundColor: Colors.red,
                              ),
                            );
                          },
                        );
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                PcNoDialogPage(Mobileno: Mobileno, Name: Name),
                          ),
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
