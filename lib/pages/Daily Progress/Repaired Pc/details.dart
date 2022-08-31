import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Scaffold RepairedPcDatails() {
  return Scaffold(
    backgroundColor: const Color.fromARGB(255, 234, 246, 247),
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
    required this.billNo,
    required this.pcNumber,
    required this.charge,
    required this.device,
    required this.problem,
  });
  final String billNo;
  final String pcNumber;
  final String device;
  final String problem;
  final String charge;
}

List<Choice> choices = const <Choice>[
  Choice(
      billNo: '543',
      pcNumber: '5050',
      device: 'Laptop',
      problem:
          'Contrary to popular belief, Lorem Ipsum is not simply random text.',
      charge: '₹ 3000'),
  Choice(
      billNo: '544',
      pcNumber: '5050',
      device: 'Scanner',
      problem:
          'Contrary to popular belief, Lorem Ipsum is not simply random text.',
      charge: '₹ 300'),
  Choice(
      billNo: '545',
      pcNumber: '5050',
      device: 'Laptop',
      problem:
          'Contrary to popular belief, Lorem Ipsum is not simply random text.',
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
    var dropdownvalue = 'Repaired';
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
                    color: Colors.green,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        topLeft: Radius.circular(10))),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 40,
                        width: 200,
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            'Bill No: ${widget.choice.billNo}',
                            style: GoogleFonts.ubuntu(
                                fontSize: 27,
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Container(
                          width: 100,
                          height: 40,
                          decoration: BoxDecoration(
                              color: Colors.green.shade200,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10))),
                          child: Center(
                            child: DropdownButton(
                              value: dropdownvalue,
                              style: GoogleFonts.poppins(color: Colors.white),
                              dropdownColor:
                                  const Color.fromARGB(255, 16, 121, 174),
                              underline: const SizedBox(),
                              iconSize: 0,
                              items: const [
                                DropdownMenuItem(
                                  value: "Repaired",
                                  child: Text("Repaired"),
                                ),
                                DropdownMenuItem(
                                  value: "Delivereed",
                                  child: Text("Delivered"),
                                ),
                              ],
                              onChanged: (value) {
                                setState(() {
                                  dropdownvalue = value.toString();
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: Row(
                      children: [
                        Text(
                          widget.choice.device,
                          style: GoogleFonts.poppins(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                        ),
                        const SizedBox(width: 30),
                        Text(
                          widget.choice.pcNumber,
                          style: GoogleFonts.poppins(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                        ),
                      ],
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
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: Row(
                      children: [
                        Text(
                          widget.choice.device,
                          style: GoogleFonts.poppins(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                        ),
                        const SizedBox(width: 30),
                        Text(
                          widget.choice.pcNumber,
                          style: GoogleFonts.poppins(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                        ),
                      ],
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
              Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: SizedBox(
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
              ),
              const SizedBox(height: 10),
            ],
          )),
    );
  }
}

