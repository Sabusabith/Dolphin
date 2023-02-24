// ignore_for_file: unnecessary_null_comparison

import 'package:dolphin_video_call/Helper/Colors..dart';
import 'package:dolphin_video_call/Helper/CustomTextfield.dart';
import 'package:dolphin_video_call/Helper/Shared.dart';
import 'package:dolphin_video_call/Screens/InternetCheck/InternetCheck.dart';
import 'package:dolphin_video_call/Screens/Login/Login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Register extends StatefulWidget {
  Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final formKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();

  TextEditingController password = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    checkConnection();
    super.initState();
  }

  bool? network;
  String name = "";
  checkConnection() async {
    network = await internetCheck();
    setState(() {});
    if (network!) {
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("No internet connection!")));
    }
  }

  firebaseRegister() async {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: email.text.trim(), password: password.text.trim())
        .then((value) {
      if (value != null) {
        saveObject("login", true);
        saveName("name", name.trim());
        saveName("email", email.text.trim());
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Account created succesfull")));
        Get.to(Login());
      }
    }).onError((error, stackTrace) {
      network!
          ? ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Something wrong try again")))
          : ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("No internet connection!")));
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Sizer(
      builder: (context, orientation, deviceType) => Scaffold(
        backgroundColor: bgcolor,
        body: SafeArea(
          child: Form(
            key: formKey,
            child: SizedBox(
              width: size.width,
              height: size.height,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    Icon(
                      Icons.lock,
                      color: Colors.black,
                      size: 100,
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Text(
                      "Let's create an account for you!",
                      style: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: 16,
                          wordSpacing: 1),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    CustomTextField(
                      hinttext: "FullName",
                      onchanged: (val) {
                        setState(() {
                          name = val;
                        });
                      },
                      validator: (val) {
                        if (val!.isNotEmpty) {
                          return null;
                        } else {
                          return "Name cannot be empty";
                        }
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                      hinttext: "Email",
                      controller: email,
                      validator: (val) {
                        return RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(val!)
                            ? null
                            : "Please enter a valid email";
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                      sufix: true,
                      hinttext: "Password",
                      controller: password,
                      validator: (val) {
                        if (val!.length < 6) {
                          return "Password must be at least 6 characters";
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 55,
                      width: size.width,
                      margin: EdgeInsets.all(25),
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(15)),
                      child: ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            firebaseRegister();
                          } else {
                            return null;
                          }
                        },
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.black)),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account?",
                          style: TextStyle(color: Colors.grey.shade700),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.to(Login());
                          },
                          child: Text(" Login now",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.blue)),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
