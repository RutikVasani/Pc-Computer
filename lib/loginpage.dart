import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pc1/appbarpage.dart';
import 'package:pc1/services/auth_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController useridcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  late String _userid;
  late String _password;
  bool _loading = false;
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return _loading
        ? Scaffold(
            backgroundColor: Colors.white,
            body: Center(child: Image.asset("assets/images/computer1.webp")),
          )
        : Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    stops: const [
                  0.2,
                  0.5,
                  0.8,
                  0.7
                ],
                    colors: [
                  Colors.blue.shade50,
                  Colors.blue.shade100,
                  Colors.blue.shade300,
                  const Color.fromARGB(255, 16, 121, 174),
                ])),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Login Page",
                    style: GoogleFonts.ubuntu(
                        fontSize: 35,
                        color: const Color.fromARGB(255, 16, 121, 174),
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 50),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 320,
                      decoration: BoxDecoration(
                          color: Colors.white,
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
                                labelStyle: TextStyle(
                                    color: Color.fromARGB(255, 16, 121, 174)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color:
                                            Color.fromARGB(255, 16, 121, 174)),
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
                            TextFormField(
                              controller: passwordcontroller,
                              obscureText: _isObscure,
                              decoration: InputDecoration(
                                labelText: 'Password',
                                labelStyle: const TextStyle(
                                    color: Color.fromARGB(255, 16, 121, 174)),
                                focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color.fromARGB(255, 30, 63, 90)),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15))),
                                border: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15))),
                                prefixIcon: const Icon(
                                  Icons.lock,
                                  color: Color.fromARGB(255, 16, 121, 174),
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _isObscure
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color:
                                        const Color.fromARGB(255, 16, 121, 174),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _isObscure = !_isObscure;
                                    });
                                  },
                                ),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  _password = value;
                                });
                              },
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    print('Forgotted Password!');
                                  },
                                  child: Text(
                                    'Forgot Password?',
                                    style: TextStyle(
                                      color: Colors.black.withOpacity(0.4),
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              width: double.infinity,
                              height: 60,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: MaterialButton(
                                // ignore: avoid_print
                                onPressed: () async {
                                  setState(() {
                                    _loading = true;
                                  });
                                  if (useridcontroller.text == "" ||
                                      passwordcontroller == "") {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                      content: Text("All fields are required"),
                                      backgroundColor: Colors.red,
                                    ));
                                  } else {
                                    User? result = await AuthService().login(
                                        useridcontroller.text,
                                        passwordcontroller.text,
                                        context);
                                    if (result != null) {
                                      // ignore: use_build_context_synchronously
                                      Navigator.pop(context);
                                      // ignore: use_build_context_synchronously
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const AppBarPage(),
                                        ),
                                      );
                                    }
                                  }
                                  setState(() {
                                    _loading = false;
                                  });
                                },
                                color: const Color.fromARGB(255, 16, 121, 174),
                                child: const Text(
                                  'LOGIN',
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
            ),
          );
  }
}
