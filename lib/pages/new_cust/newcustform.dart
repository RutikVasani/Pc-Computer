import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pc1/pages/Daily%20Progress/Today%20All/todayallpc.dart';

class NewCustFormPage extends StatefulWidget {

  NewCustFormPage({Key? key}) : super(key: key);

  @override
  State<NewCustFormPage> createState() => _NewCustFormPageState();
}

class _NewCustFormPageState extends State<NewCustFormPage> {
  TextEditingController pcNumberController = TextEditingController();
  TextEditingController itemController = TextEditingController();
  TextEditingController bringWithItemController = TextEditingController();
  TextEditingController problemController = TextEditingController();
  TextEditingController costController = TextEditingController();
  TextEditingController remarksController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 234, 246, 255),
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
            SizedBox(height: 30),
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
                            "widget.Name",
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
                            "widget.MobileNo",
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
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextFormField(
                        controller: pcNumberController,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.design_services),
                          labelText: 'Enter Pc Number',
                          hintText: '5050',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextFormField(
                        controller: itemController,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.devices),
                          labelText: 'Enter item',
                          hintText: 'laptop/pc',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        controller: bringWithItemController,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.list),
                          labelText: 'Enter list of item which bring with them',
                          hintText: 'Charger / Bug / printer cable / Ram-Rom',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        controller: problemController,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.report),
                          labelText: 'Write problem of item',
                          hintText: 'problem:',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        controller: costController,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.attach_money),
                          labelText: 'Enter Estimate cost',
                          hintText: '2000',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: TextField(
                        controller: remarksController,
                        keyboardType: TextInputType.multiline,
                        maxLines: 4,
                        decoration: InputDecoration(
                          hintText: "Enter Remarks",
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TodayAllPcPage(),
                            ),
                          );
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 16, 121, 174),
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                            child: Text(
                              "Submit",
                              style: GoogleFonts.poppins(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 15)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
