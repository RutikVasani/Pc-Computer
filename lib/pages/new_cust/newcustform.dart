import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pc1/pages/Daily%20Progress/Today%20All/todayallpc.dart';
import 'package:pc1/services/writedata.dart';

class NewCustFormPage extends StatefulWidget {
  final String mobileno;
  final String name;
  final String pcno;
  NewCustFormPage(
      {Key? key,
      required this.mobileno,
      required this.pcno,
      required this.name})
      : super(key: key);

  @override
  State<NewCustFormPage> createState() => _NewCustFormPageState();
}

class _NewCustFormPageState extends State<NewCustFormPage> {
  late String _pcNumber;
  late String _item;
  late String _bringWithItem;
  late String _problem;
  late String _cost;
  late String _remarks;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 234, 246, 255),
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: const Color.fromARGB(255, 16, 121, 174),
        title: Text('New Customers',
            style:
                GoogleFonts.ubuntu(fontSize: 25, fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Align(
                alignment: Alignment.topLeft,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 90,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: const Border(
                      top: BorderSide(width: 1.5, color: Colors.black),
                      left: BorderSide(width: 1.5, color: Colors.black),
                      right: BorderSide(width: 1.5, color: Colors.black),
                      bottom: BorderSide(width: 1.5, color: Colors.black),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [
                          SizedBox(width: 10),
                          Text(
                            "Name: ",
                            style: GoogleFonts.poppins(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                          ),
                          SizedBox(width: 15),
                          Text(
                            widget.name,
                            style: GoogleFonts.poppins(
                                fontSize: 17, color: Colors.black),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(width: 10),
                          Text(
                            "Mobile No: ",
                            style: GoogleFonts.poppins(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                          ),
                          SizedBox(width: 15),
                          Text(
                            widget.mobileno,
                            style: GoogleFonts.poppins(
                                fontSize: 17, color: Colors.black),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.design_services),
                            labelText: 'Enter Pc Number',
                            hintText: '5050',
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (value) {
                            setState(() {
                              _pcNumber = value;
                            });
                          },
                        ),
                      ),
                      //box styling
                      const SizedBox(height: 10),
                      //text input
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.devices),
                            labelText: 'Enter item',
                            hintText: 'laptop/pc',
                            border: OutlineInputBorder(),
                          ),
                          onFieldSubmitted: (value) {},
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter a Item Name';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            setState(() {
                              _item = value;
                            });
                          },
                        ),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.list),
                            labelText:
                                'Enter list of item which bring with them',
                            hintText: 'Charger / Bug / printer cable / Ram-Rom',
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (value) {
                            setState(() {
                              _bringWithItem = value;
                            });
                          },
                        ),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.report),
                            labelText: 'Write problem of item',
                            hintText: 'problem:',
                            border: OutlineInputBorder(),
                          ),
                          onFieldSubmitted: (value) {},
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter a Problem';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            setState(() {
                              _problem = value;
                            });
                          },
                        ),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            prefixIcon: const Icon(Icons.attach_money),
                            labelText: 'Enter Estimate cost',
                            hintText: '2000',
                            border: const OutlineInputBorder(),
                          ),
                          onFieldSubmitted: (value) {},
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter a Cost';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            setState(() {
                              _cost = value;
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: TextField(
                          keyboardType: TextInputType.multiline,
                          maxLines: 4,
                          decoration: const InputDecoration(
                            hintText: "Enter Remarks",
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (value) {
                            setState(() {
                              _remarks = value;
                            });
                          },
                        ),
                      ),
                      const SizedBox(height: 15),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () async {
                            final isValid = _formKey.currentState!.validate();
                            if (!isValid) {
                              return;
                            }
                            _formKey.currentState!.save();
                            Map<String, dynamic> ItemData = {
                              'Pc No': _pcNumber,
                              'Mobile No' : widget.mobileno,
                              'Name' : widget.name,
                              'Item': _item,
                              'Bring Item': _bringWithItem,
                              'Problem': _problem,
                              'Cost': _cost,
                              'Remarks': _remarks,
                              'Progress': "Pending",
                              'Date': DateTime.now(),
                            };
                            WriteData().addPcData(ItemData, context).then(
                              (result) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Item added"),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              },
                            );
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const TodayAllPcPage()),
                            );
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 50,
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 16, 121, 174),
                                borderRadius: BorderRadius.circular(10)),
                            child: const Center(
                              child: Text(
                                "Submit",
                                style: TextStyle(
                                    fontSize: 30,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
