import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pc1/pages/invoice/pdf/pdfdata.dart';

Scaffold DeliveredPcDatails() {
  return Scaffold(
    backgroundColor: const Color.fromARGB(255, 211, 244, 247),
    body: ListView.builder(
      itemCount: choices.length,
      itemBuilder: (context, index) =>
          SelectCard(choice: choices[index], index: index),
      // scrollDirection: Axis.vertical,
      shrinkWrap: true,
      physics: const ScrollPhysics(),
    ),
  );
}

class Choice {
  const Choice({
    required this.pcNumber,
    required this.charge,
    required this.device,
    required this.problem,
    required this.progress,
  });
  final String pcNumber;
  final String device;
  final String problem;
  final String progress;
  final String charge;
}

List<Choice> choices = const <Choice>[
  Choice(
      pcNumber: '5050',
      device: 'Laptop',
      problem:
          'Contrary to popular belief, Lorem Ipsum is not simply random text.',
      progress: 'Delivered',
      charge: '₹ 3000'),
  Choice(
      pcNumber: '5050',
      device: 'Scanner',
      problem:
          'Contrary to popular belief, Lorem Ipsum is not simply random text.',
      progress: 'Delivered',
      charge: '₹ 300'),
  Choice(
      pcNumber: '5050',
      device: 'Laptop',
      problem:
          'Contrary to popular belief, Lorem Ipsum is not simply random text.',
      progress: 'Delivered',
      charge: '₹ 500'),
];

const List<Widget> pages = <Widget>[];

class SelectCard extends StatefulWidget {
  const SelectCard({Key? key, required this.choice, required this.index})
      : super(key: key);
  final Choice choice;
  final int index;
  @override
  State<SelectCard> createState() => _SelectCardState();
}

class _SelectCardState extends State<SelectCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(15)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                decoration: const BoxDecoration(
                    color: Colors.purple,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        topLeft: Radius.circular(10))),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 30,
                        width: 200,
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            'Pc No: ${widget.choice.pcNumber}',
                            style: GoogleFonts.ubuntu(
                                fontSize: 23,
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const PdfDataPage(),
                              ),
                            );
                          },
                          child: Container(
                            width: 100,
                            height: 40,
                            decoration: BoxDecoration(
                                color: Colors.purple.shade200,
                                borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(10))),
                            child: Center(
                              child: Text(
                                widget.choice.progress,
                                style: GoogleFonts.poppins(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: Text(
                      widget.choice.device,
                      style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: Text(
                      widget.choice.charge,
                      style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 1.1,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    widget.choice.problem,
                    style: GoogleFonts.poppins(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey),
                  ),
                ),
              ),
              const SizedBox(height: 10),
            ],
          )),
    );
  }
}
