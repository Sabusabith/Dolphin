import 'dart:math';

import 'package:dolphin_video_call/Helper/Colors..dart';
import 'package:dolphin_video_call/Helper/CustomTextfield.dart';
import 'package:dolphin_video_call/Screens/Login/Login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class ResetPass extends StatefulWidget {
  ResetPass({super.key});

  @override
  State<ResetPass> createState() => _ResetPassState();
}

class _ResetPassState extends State<ResetPass> {
  String email = "";
  String password = "";
  String fullName = "";
  final key2 = GlobalKey<FormState>();

  resetData() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: email)
          .then((value) => {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  duration: Duration(seconds: 4),
                  content: Text("Password reset link send!.Check your email"),
                )),
                Get.back()
              });
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState

    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Sizer(
      builder: (context, orientation, deviceType) => Scaffold(
        backgroundColor: bgcolor,
        body: SizedBox(
          width: size.width,
          height: size.height,
          child: Form(
            key: key2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Reset Password",
                  style: TextStyle(
                      color: Colors.grey.shade800,
                      fontSize: 22,
                      fontFamily: "Sf",
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "No worries. we'll send you reset instructions!",
                  style: TextStyle(
                      color: Colors.grey.shade700,
                      fontSize: 15,
                      fontFamily: "Sf",
                      letterSpacing: 1),
                ),
                SizedBox(
                  height: 35,
                ),
                CustomTextField(
                  onchanged: (val) {
                    setState(() {
                      email = val;
                    });
                  },
                  hinttext: "Enter email adrress...",
                  validator: (email) {
                    if (email == null ||
                        email.isEmpty ||
                        !email.contains('@') ||
                        !email.contains('.')) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 20,
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
                      if (key2.currentState!.validate()) {
                        resetData();
                      } else {
                        return null;
                      }
                    },
                    child: Text(
                      "Reset",
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
                  height: 25,
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(Login());
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.arrow_back,
                        color: Colors.grey.shade800,
                        size: 22,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "back to login",
                        style: TextStyle(
                            color: Colors.grey.shade800,
                            fontSize: 15,
                            fontFamily: "Sf",
                            letterSpacing: 1),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
