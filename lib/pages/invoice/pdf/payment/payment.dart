import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pc1/appbarpage.dart';
import 'upi.dart';
import 'upi_qrcode.dart';

class PaymentModePage extends StatefulWidget {
  String cost;
  String uid;
  String MobileNo;
  String PcNo;
  Map<String, dynamic> docData;
  PaymentModePage(
      {Key? key,
      required this.cost,
      required this.uid,
      required this.MobileNo,
      required this.PcNo,
      required this.docData})
      : super(key: key);

  @override
  State<PaymentModePage> createState() => _PaymentModePageState();
}

class _PaymentModePageState extends State<PaymentModePage> {
  String? payment;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 234, 246, 255),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 16, 121, 174),
        title: Text(
          "Payment",
          style: GoogleFonts.poppins(fontSize: 25, color: Colors.white),
        ),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(15),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 70,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15)),
                child: Row(
                  children: <Widget>[
                    Radio<String>(
                        value: "Cod",
                        groupValue: payment,
                        onChanged: (value) {
                          payment = value.toString();
                          setState(() {});
                        }),
                    const Text('Cash on Delivery',
                        style: TextStyle(fontSize: 20))
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15)),
                child: Column(
                  children: [
                    Row(
                      children: <Widget>[
                        Radio<String>(
                            value: "UPI",
                            groupValue: payment,
                            onChanged: (value) {
                              payment = value.toString();
                              setState(() {});
                            }),
                        const Text(
                          'UPI',
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("UPI Payment QRCode with Amount",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          const SizedBox(height: 5),
                          UPIPaymentQRCode(
                            upiDetails: UPIDetails(
                                upiID: "9327197604@paytm",
                                payeeName: "Payee Name Here",
                                amount: widget.cost,
                                transactionNote: "Hello..!"),
                            size: 200,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text("UPI Payment QRCode without Amount",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          const SizedBox(height: 5),
                          UPIPaymentQRCode(
                            upiDetails: UPIDetails(
                                upiID: "9327197604@paytm",
                                payeeName: "Payee Name Here",
                                transactionNote: "Hello..!"),
                            size: 200,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10)
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                FirebaseFirestore.instance
                    .collection("TodayData")
                    .doc(widget.uid)
                    .update({"Payment": payment});
                FirebaseFirestore.instance
                    .collection("Customers")
                    .doc(widget.MobileNo)
                    .collection("PcNumber")
                    .doc(widget.PcNo)
                    .collection("Data")
                    .doc(widget.uid)
                    .set(widget.docData);
                FirebaseFirestore.instance
                    .collection("Customers")
                    .doc(widget.MobileNo)
                    .collection("PcNumber")
                    .doc(widget.PcNo)
                    .collection("Data")
                    .doc(widget.uid)
                    .update({"Payment": payment, "Progress": "Delivered"});
                if (payment != null) {
                  Navigator.pop(context);
                }
                print("Payment type is: " + payment!);
              },
              child: Padding(
                padding: const EdgeInsets.all(15),
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
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: Padding(
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
    );
  }
}
