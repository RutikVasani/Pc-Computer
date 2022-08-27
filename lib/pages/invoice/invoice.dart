import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InvoicePage extends StatelessWidget {
  const InvoicePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: const Color.fromARGB(255, 16, 121, 174),
        title: Text("Invoice", style: GoogleFonts.poppins(fontSize: 25, color: Colors.white),),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: IconButton(
            icon: const Icon(
              Icons.picture_as_pdf,
              size: 30,
            ),
            onPressed: () {},
          ),
          ),
        ],
      ),
    );
  }
}
