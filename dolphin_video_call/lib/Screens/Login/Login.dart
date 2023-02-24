import 'package:dolphin_video_call/Helper/Colors..dart';
import 'package:dolphin_video_call/Helper/CustomTextfield.dart';
import 'package:dolphin_video_call/Helper/Shared.dart';
import 'package:dolphin_video_call/Screens/Home/Home.dart';
import 'package:dolphin_video_call/Screens/Register/Register.dart';
import 'package:dolphin_video_call/Screens/ResetPass/ResetPass.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/widgets.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';

class Login extends StatefulWidget {
  Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  TextEditingController emailcontroller = TextEditingController();

  TextEditingController passwordcontroller = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  firebaseLogin() async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(
            email: emailcontroller.text.trim(),
            password: passwordcontroller.text.trim())
        .then((value) {
      if (value != null) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Login Succes")));
        Get.to(Home());
      }
    }).onError((error, stackTrace) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Invalid email or password!")));
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailcontroller.dispose();
    passwordcontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Sizer(
        builder: (context, orientation, deviceType) => Scaffold(
          backgroundColor: bgcolor,
          body: SafeArea(
            child: Form(
              key: _formKey,
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
                        "Welcome back you've been missed!",
                        style: TextStyle(
                            color: Colors.grey.shade700,
                            fontSize: 16,
                            wordSpacing: 1),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      CustomTextField(
                        hinttext: "Email",
                        controller: emailcontroller,
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
                        controller: passwordcontroller,
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
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: GestureDetector(
                          onTap: () {
                            Get.to(ResetPass());
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                "Forgot Password?",
                                style: TextStyle(
                                    color: Colors.grey.shade700, fontSize: 15),
                              ),
                            ],
                          ),
                        ),
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
                            if (_formKey.currentState!.validate()) {
                              firebaseLogin();
                            } else {
                              return null;
                            }
                          },
                          child: Text(
                            "Sign In",
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
                            "Not a member?",
                            style: TextStyle(color: Colors.grey.shade700),
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.to(Register());
                            },
                            child: Text(" Register now",
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
      ),
    );
  }
}
