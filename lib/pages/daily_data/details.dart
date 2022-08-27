import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Scaffold ProgressPage() {
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
      device: 'Printer',
      problem:
          'Contrary to popular belief, Lorem Ipsum is not simply random text.',
      progress: 'Repaired',
      charge: '₹ 400'),
  Choice(
      pcNumber: '5050',
      device: 'Computer',
      problem:
          'Contrary to popular belief, Lorem Ipsum is not simply random text.',
      progress: 'On Going',
      charge: '₹ 500'),
  Choice(
      pcNumber: '5050',
      device: 'Scanner',
      problem:
          'Contrary to popular belief, Lorem Ipsum is not simply random text.',
      progress: 'Pendind',
      charge: '₹ 300'),
  Choice(
      pcNumber: '5050',
      device: 'Laptop',
      problem:
          'Contrary to popular belief, Lorem Ipsum is not simply random text.',
      progress: 'Pending',
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
                  Spacer(),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width / 1.65,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          widget.choice.problem,
                          style: GoogleFonts.poppins(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: Color.fromARGB(255, 101, 85, 85)),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Container(
                      width: 100,
                      height: 40,
                      decoration: BoxDecoration(
                          color: Colors.red.shade200,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10))),
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
                  )
                ],
              ),
            ],
          )),
    );
  }
}
