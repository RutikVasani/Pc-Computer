import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PaymentModePage extends StatefulWidget {
  const PaymentModePage({Key? key}) : super(key: key);

  @override
  State<PaymentModePage> createState() => _PaymentModePageState();
}

class _PaymentModePageState extends State<PaymentModePage> {
  int _counter = 0;

  String? payment;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

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
                    Image.asset(
                      "assets/images/upi.png",
                      width: MediaQuery.of(context).size.width / 1.5,
                    )
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
