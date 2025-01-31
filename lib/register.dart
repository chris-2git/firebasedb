import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebasedb/login.dart';
import 'package:flutter/material.dart';

class Registerpage extends StatefulWidget {
  const Registerpage({super.key});

  @override
  State<Registerpage> createState() => _RegisterpageState();
}

class _RegisterpageState extends State<Registerpage> {
  String fristname = '';
  String email = '';
  String password = '';
  userreg() async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Loginpage()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            "No User Found for that Email",
            style: TextStyle(fontSize: 18.0, color: Colors.black),
          ),
        ));
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
          "Wrong Password Provided by User",
          style: TextStyle(fontSize: 18.0, color: Colors.black),
        )));
      }
    }
  }

  final _formkey = GlobalKey<FormState>();
  TextEditingController fristcontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Form(
          key: _formkey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: textForm(Icons.person, 'Frist name', fristcontroller,
                    (value) {
                  if (fristcontroller.text.isEmpty) {
                    return 'Please enter your firstname';
                  } else {
                    return null;
                  }
                }),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: textForm(Icons.email, 'Email', emailcontroller, (value) {
                  if (emailcontroller.text.isEmpty) {
                    return 'Please enter Email';
                  } else {
                    return null;
                  }
                }),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child:
                    textForm(Icons.lock, 'Password', passcontroller, (value) {
                  if (passcontroller.text.isEmpty) {
                    return 'Please enter Password';
                  } else {
                    return null;
                  }
                }),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    if (_formkey.currentState!.validate()) {
                      setState(() {
                        fristname = fristcontroller.text;
                        email = emailcontroller.text;
                        password = passcontroller.text;
                      });
                    }
                    userreg();
                  },
                  child: Container(
                    height: size.height * 0.10,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.deepOrange),
                    child: Center(
                        child: Text(
                      'Registration',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                    )),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget textForm(
    IconData icon,
    String hintText,
    TextEditingController controller,
    String? Function(String?) validator,
  ) {
    return TextFormField(
      validator: validator,
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        hintText: hintText,
        prefixIcon: Icon(icon),
      ),
    );
  }
}
