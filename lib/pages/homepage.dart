import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var date = DateFormat.yMMMEd().format(DateTime.now());

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 234, 246, 247),
      body: OrientationBuilder(builder: (context, orientation) {
        var TotalAmount = 3450;
        var Pc = 40;
        var delivered = 20;
        var ongoing = 3;
        var repaired = 30;
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 200,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/payment_background.jpg'),
                      fit: BoxFit.fill,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromARGB(255, 1, 68, 74),
                        offset: Offset(2, 2),
                        blurRadius: 5.0,
                        spreadRadius: 0.0,
                      ),
                    ],
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8, left: 15),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          date,
                          style: GoogleFonts.ubuntu(
                              fontSize: 25,
                              color: const Color.fromARGB(255, 20, 11, 143)),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Divider(
                        height: 10,
                        thickness: 2,
                        color: Color.fromARGB(255, 20, 11, 143),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15, left: 20),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text("Total Collection",
                            style: GoogleFonts.ubuntu(
                                color: const Color.fromARGB(255, 0, 0, 0),
                                fontSize: 17,
                                fontWeight: FontWeight.w800)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromARGB(255, 215, 204, 204),
                              offset: Offset(2, 2),
                              blurRadius: 5.0,
                              spreadRadius: 0.0,
                            ),
                          ],
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
                                    color:
                                        const Color.fromARGB(255, 16, 121, 174),
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
                                    color:
                                        const Color.fromARGB(255, 16, 121, 174),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 250,
                      width: 180,
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
                            height: 115,
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
                          padding: const EdgeInsets.symmetric(horizontal: 15),
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
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      height: 150,
                      width: 180,
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
                          padding: const EdgeInsets.only(left: 10, top: 8, right: 10),
                          child: Row(
                            children: [
                              Image.asset(
                                "assets/images/ongoing.png",
                                height: 75,
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
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ]),
                    ),
                  ],
                ),
                const SizedBox(width: 30),
                Column(
                  children: [
                    Container(
                      height: 150,
                      width: 180,
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
                          padding: const EdgeInsets.only(left: 10, top: 8, right: 10),
                          child: Row(
                            children: [
                              Image.asset(
                                "assets/images/tick.png",
                                height: 70,
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
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      height: 250,
                      width: 180,
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
                            height: 115,
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
                    )
                  ],
                ),
              ],
            )
          ],
        );
      }),
    );
  }
}
