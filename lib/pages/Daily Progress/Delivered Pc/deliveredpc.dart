import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pc1/pages/Daily%20Progress/Delivered%20Pc/details.dart';
import 'package:pc1/pages/Daily%20Progress/Delivered%20Pc/searchdelivered.dart';

class DeliveredPcPage extends StatelessWidget {
  const DeliveredPcPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: const Color.fromARGB(255, 16, 121, 174),
        title: Text('PC Computer',
            style:
                GoogleFonts.ubuntu(fontSize: 25, fontWeight: FontWeight.bold)),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SearchDeliveredPage(),
                    ),
                  );
                },
                icon: Icon(
                  Icons.search,
                  size: 30,
                )),
          )
        ],
      ),
      body: DeliveredPcDatails(),
    );
  }
}
