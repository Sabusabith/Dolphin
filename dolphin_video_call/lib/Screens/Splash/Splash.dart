import 'package:dolphin_video_call/Helper/Colors..dart';
import 'package:dolphin_video_call/Screens/Home/Home.dart';
import 'package:dolphin_video_call/Screens/Login/Login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashState();
}

class _SplashState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    statusCheck();
  }

  statusCheck() async {
    try {
      if (FirebaseAuth.instance.currentUser != null) {
        Future.delayed(const Duration(seconds: 2), () {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => Home(),
              ),
              (route) => false);
        });
      } else {
        Future.delayed(const Duration(seconds: 3), () {
          Get.to(Login());
        });
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Sizer(
      builder: (context, orientation, deviceType) => Scaffold(
        backgroundColor: Color.fromARGB(255, 214, 233, 196),
        body: SizedBox(
          width: size.width,
          height: size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 300,
                height: 300,
                child: Image(
                  image: AssetImage("Assets/Images/logo.png"),
                  fit: BoxFit.contain,
                ),
              ),
              Container(
                width: 50,
                height: 50,
                child: Image(
                  image: AssetImage("Assets/Images/call3.png"),
                  fit: BoxFit.contain,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
