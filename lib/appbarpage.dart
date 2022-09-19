import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pc1/loginpage.dart';
import 'package:pc1/pages/daily_data/details.dart';
import 'package:pc1/pages/engineerpage.dart';
import 'package:pc1/pages/homepage.dart';
import 'package:pc1/pages/new_cust/newcustform.dart';
import 'package:pc1/pages/search.dart';
import 'package:pc1/services/auth_service.dart';
import 'package:pc1/services/crud.dart';

class AppBarPage extends StatefulWidget {
  const AppBarPage({Key? key}) : super(key: key);

  @override
  State<AppBarPage> createState() => _AppBarPageState();
}

class _AppBarPageState extends State<AppBarPage> {
  int pageIndex = 0;

  final pages = [const HomePage(), ProgressPage()];
  late String mobileno;
  late String name;

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
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SearchPage(),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.add,
              size: 30,
            ),
            onPressed: () {
              showDialog(
                  barrierColor: Color.fromARGB(130, 144, 202, 249),
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      scrollable: true,
                      title: Text('New Customer'),
                      content: Column(
                        children: <Widget>[
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: TextField(
                              decoration: const InputDecoration(
                                labelText: 'Name',
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15))),
                                prefixIcon: Icon(Icons.person),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  name = value;
                                });
                              },
                            ),
                          ),
                          SizedBox(height: 14),
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: TextField(
                              decoration: const InputDecoration(
                                labelText: 'Mobile No.',
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15))),
                                prefixIcon: Icon(Icons.call),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  mobileno = value;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      actions: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                              child: Text("Submit"),
                              onPressed: () {
                                Navigator.pop(context);
                                var userid = FirebaseFirestore.instance
                                    .collection("Customers")
                                    .doc()
                                    .id;
                                Map<String, dynamic> custdata = {
                                  'Name': name,
                                  'Mobile no': mobileno,
                                  'User id': userid,
                                };
                                Crud().adduser(userid, custdata, context).then(
                                  (result) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text("Customer added"),
                                        backgroundColor: Colors.red,
                                      ),
                                    );
                                  },
                                );
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => NewCustFormPage(),
                                  ),
                                );
                              }),
                        )
                      ],
                    );
                  });
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
          padding: const EdgeInsets.only(left: 10, top: 5, bottom: 12),
          child: IconButton(
            icon: const Icon(
              Icons.logout,
              color: Colors.white,
              size: 30,
            ),
            onPressed: () {
              FirebaseAuth.instance.signOut();
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginPage(),
                ),
              );
            },
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
