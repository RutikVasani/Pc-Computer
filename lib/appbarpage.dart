import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pc1/pages/daily_data/details.dart';
import 'package:pc1/pages/homepage.dart';
import 'package:pc1/pages/homepage/engineerpage/engineerpage.dart';
import 'package:pc1/pages/new_cust/newcust.dart';
import 'package:velocity_x/velocity_x.dart';

class AppBarPage extends StatefulWidget {
  const AppBarPage({Key? key}) : super(key: key);

  @override
  State<AppBarPage> createState() => _AppBarPageState();
}

class _AppBarPageState extends State<AppBarPage> {
  int pageIndex = 0;

  final pages = [const HomePage(), ProgressPage()];

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
          IconButton(
            icon: const Icon(
              Icons.search,
              size: 30,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(
              Icons.add,
              size: 30,
            ),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => const NewCust()));
            },
          ),
          IconButton(
            icon: const Icon(Icons.engineering),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const EngineerPage()));
            },
          ),
        ],
        leading: Padding(
          padding: const EdgeInsets.only(left: 10, top: 12, bottom: 12),
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePage(),
                ),
              );
            },
            child: Image.asset("assets/images/home.png"),
          ),
        ),
      ),
      body: pages[pageIndex],
      bottomNavigationBar: buildMyNavBar(context),
    );
  }

  Container buildMyNavBar(BuildContext context) {
    return Container(
      height: 50,
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 16, 121, 174),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          TextButton(
            onPressed: () {
              setState(() {
                pageIndex = 0;
              });
            },
            child: pageIndex == 0
                ? Row(
                    children: [
                      Image.asset("assets/images/home.png", height: 25),
                      SizedBox(width: 7),
                      Text(
                        "Home",
                        style: GoogleFonts.poppins(
                            fontSize: 22, color: Colors.white),
                      ),
                    ],
                  )
                : Image.asset("assets/images/home1.png", height: 25),
          ),
          TextButton(
              onPressed: () {
                setState(() {
                  pageIndex = 1;
                });
              },
              child: pageIndex == 1
                  ? Row(
                      children: [
                        Image.asset("assets/images/menu.png", height: 25),
                        SizedBox(width: 7),
                        Text("Menu",
                            style: GoogleFonts.poppins(
                                fontSize: 22, color: Colors.white))
                      ],
                    )
                  : Image.asset("assets/images/menu1.png", height: 25)),
        ],
      ),
    );
  }
}
