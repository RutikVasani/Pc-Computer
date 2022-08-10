import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:pc1/pages/Daily%20Progress/Delivered%20Pc/deliveredpc.dart';
import 'package:pc1/pages/Daily%20Progress/Ongoing%20Pc/ongoingpc.dart';
import 'package:pc1/pages/Daily%20Progress/Repaired%20Pc/repairedpc.dart';
import 'package:pc1/pages/Daily%20Progress/Today%20All/todayallpc.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var date = DateFormat.yMMMEd().format(DateTime.now());

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 234, 246, 255),
      body: OrientationBuilder(builder: (context, orientation) {
        var TotalAmount = 3450;
        var Pc = 40;
        var delivered = 20;
        var ongoing = 3;
        var repaired = 30;
        return SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.all(15),
                child: Container(
                  decoration: const BoxDecoration(
                      gradient: RadialGradient(
                        radius: 2,
                        colors: [
                          Color.fromARGB(255, 16, 121, 174),
                          Color.fromARGB(255, 169, 219, 238),
                          Color.fromARGB(255, 16, 121, 174),
                        ],
                        center: Alignment(1.0, -1.0),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white,
                          offset: Offset(-2, 2),
                          blurRadius: 5.0,
                          spreadRadius: 0.0,
                        ),
                      ],
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10, left: 15),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            date,
                            style: GoogleFonts.ubuntu(
                                fontSize: 25, color: Colors.white),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Divider(
                          height: 10,
                          thickness: 2,
                          color: Colors.white,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15, left: 20),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text("Total Collection",
                              style: GoogleFonts.ubuntu(
                                  color: Colors.black,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w800)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(5),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const SizedBox(width: 10),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "₹ ",
                                      style: GoogleFonts.ubuntu(
                                        fontSize: 30,
                                        color: const Color.fromARGB(
                                            255, 16, 121, 174),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "3550",
                                    style: GoogleFonts.ubuntu(
                                      fontSize: 30,
                                      color: const Color.fromARGB(
                                          255, 16, 121, 174),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: InkWell(
                                  child: Text(
                                    "View all",
                                    style: GoogleFonts.ubuntu(
                                      fontSize: 15,
                                      color: const Color.fromARGB(
                                          255, 16, 121, 174),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Daily Progress",
                    style: GoogleFonts.poppins(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const TodayAllPcPage()));
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width/2.3,
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Color.fromARGB(255, 169, 219, 238),
                                  Color.fromARGB(255, 16, 121, 174)
                                ],
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(15),
                              ),
                            ),
                            child: Column(children: [
                              const SizedBox(height: 15),
                              Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Image.asset(
                                  "assets/images/computer.png",
                                  height: MediaQuery.of(context).size.height*.15
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 10, left: 15, right: 15),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "Today All",
                                    style: GoogleFonts.ubuntu(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "Pc",
                                    style: GoogleFonts.ubuntu(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 5),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "Task: $Pc",
                                    style: GoogleFonts.ubuntu(
                                      fontSize: 15,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ]),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const OngoingPcPage()));
                          },
                          child: Container(
                            height: 150,
                            width: MediaQuery.of(context).size.width/2.3,
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Color.fromARGB(255, 223, 175, 171),
                                  Color.fromARGB(255, 160, 13, 2)
                                ],
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(15),
                              ),
                            ),
                            child: Column(children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10, top: 8, right: 10),
                                child: Row(
                                  children: [
                                    Image.asset(
                                      "assets/images/ongoing.png",
                                      height: MediaQuery.of(context).size.height*.075
                                    ),
                                    Column(
                                      children: [
                                        const SizedBox(height: 40),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 15, horizontal: 10),
                                          child: Align(
                                            alignment: Alignment.bottomRight,
                                            child: Text(
                                              "Task: $ongoing",
                                              style: GoogleFonts.ubuntu(
                                                fontSize: 18,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 15, right: 15, bottom: 5),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "Ongoing Pc",
                                    style: GoogleFonts.ubuntu(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ]),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 15),
                    Column(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const RepairedPcPage()));
                          },
                          child: Container(
                            height: 150,
                            width: MediaQuery.of(context).size.width/2.3,
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Color.fromARGB(255, 185, 236, 187),
                                  Color.fromARGB(255, 2, 118, 6)
                                ],
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(15),
                              ),
                            ),
                            child: Column(children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10, top: 8, right: 10),
                                child: Row(
                                  children: [
                                    Image.asset(
                                      "assets/images/tick.png",
                                      height: MediaQuery.of(context).size.height*.07
                                    ),
                                    Column(
                                      children: [
                                        const SizedBox(height: 40),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 15, horizontal: 8),
                                          child: Align(
                                            alignment: Alignment.bottomRight,
                                            child: Text(
                                              "Task: $repaired",
                                              style: GoogleFonts.ubuntu(
                                                fontSize: 15,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 15, right: 10, bottom: 5),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "Repaired Pc",
                                    style: GoogleFonts.ubuntu(
                                      fontSize: 23,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ]),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const DeliveredPcPage(
                            )));
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width/2.3,
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Color.fromARGB(255, 213, 180, 223),
                                  Color.fromARGB(255, 87, 2, 118)
                                ],
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(15),
                              ),
                            ),
                            child: Column(children: [
                              const SizedBox(height: 15),
                              Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Image.asset(
                                  "assets/images/delivered.png",
                                  height: MediaQuery.of(context).size.height*.15
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 10, left: 15, right: 15),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "Delivered Pc",
                                    style: GoogleFonts.ubuntu(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 5),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "Task: $delivered",
                                    style: GoogleFonts.ubuntu(
                                      fontSize: 15,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ]),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}
