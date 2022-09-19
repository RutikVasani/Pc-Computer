import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pc1/loginpage.dart';
import 'services/auth_service.dart';

class ForgotpasswordPage extends StatefulWidget {
  const ForgotpasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotpasswordPage> createState() => _ForgotpasswordPageState();
}

class _ForgotpasswordPageState extends State<ForgotpasswordPage> {
  TextEditingController useridcontroller = TextEditingController();
  late String _userid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 234, 246, 255),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 234, 246, 255),
        leading: IconButton(
          icon: const Icon(
            Icons.close,
            size: 30,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Forgot Password",
                style: GoogleFonts.ubuntu(
                    fontSize: 35,
                    color: const Color.fromARGB(255, 16, 121, 174),
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "Please enter your valid email address for change password",
              style: GoogleFonts.ubuntu(
                fontSize: 15,
                color: Colors.grey,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 220,
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextFormField(
                      controller: useridcontroller,
                      decoration: const InputDecoration(
                        labelText: 'User Id',
                        labelStyle:
                            TextStyle(color: Color.fromARGB(255, 16, 121, 174)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 16, 121, 174)),
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        prefixIcon: Icon(
                          Icons.person,
                          color: Color.fromARGB(255, 16, 121, 174),
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          _userid = value;
                        });
                      },
                    ),
                    Container(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      width: double.infinity,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: MaterialButton(
                        // ignore: avoid_print
                        onPressed: () async {
                          if (useridcontroller.text == "") {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text("All fields are required"),
                              backgroundColor: Colors.red,
                            ));
                          } else {
                            User? result = await AuthService()
                                .resetpassword(useridcontroller.text, context);
                            if (result != null) {
                              // ignore: use_build_context_synchronously
                              Navigator.pop(context);
                              // ignore: use_build_context_synchronously
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoginPage(),
                                ),
                              );
                            }
                          }
                        },
                        color: const Color.fromARGB(255, 16, 121, 174),
                        child: const Text(
                          'Submit',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
