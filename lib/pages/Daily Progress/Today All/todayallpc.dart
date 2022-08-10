import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pc1/pages/Daily%20Progress/Today%20All/datails.dart';

class TodayAllPcPage extends StatelessWidget {
  const TodayAllPcPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: const Color.fromARGB(255, 16, 121, 174),
        title: Text('PC Computer',
            style:
                GoogleFonts.ubuntu(fontSize: 25, fontWeight: FontWeight.bold)),
      ),
      body: AllPcDatails(),
    );
  }
}
