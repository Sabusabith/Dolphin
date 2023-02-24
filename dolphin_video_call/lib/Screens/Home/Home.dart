import 'dart:async';
import 'dart:io';

import 'package:dolphin_video_call/Helper/Colors..dart';
import 'package:dolphin_video_call/Helper/Shared.dart';
import 'package:dolphin_video_call/Screens/Account/Account.dart';
import 'package:dolphin_video_call/Screens/InternetCheck/InternetCheck.dart';
import 'package:dolphin_video_call/Screens/InternetCheck/NoConnection.dart';
import 'package:dolphin_video_call/Screens/Login/Login.dart';
import 'package:dolphin_video_call/Screens/Splash/Splash.dart';
import 'package:dolphin_video_call/Screens/VideoChatScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:sizer/sizer.dart';

class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final formKey1 = GlobalKey<FormState>();
  TextEditingController namecontroller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    checkConnection();
    getUserData();

    super.initState();
  }

  bool? network;
  checkConnection() async {
    network = await internetCheck();
    setState(() {});
    if (network!) {
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("No internet connection!")));
      Timer(Duration(seconds: 3), () {
        Get.to(NoConnection());
      });
    }
  }

  bool ontap = false;
  dynamic name;

  dynamic email;
  dynamic userid = "1";
  dynamic callId = "";

  getUserData() async {
    name = await getSavedName("name");
    email = await getSavedName("email");
    namecontroller.text = name.toString();
    setState(() {});

    print(name);
  }

  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut().then((value) {
      name = getSavedName("");
      email = getSavedName("");
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => Login(),
          ),
          (route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Exit"),
            content: Text("do you want to exit?"),
            actions: [
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.green)),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "No",
                    style: TextStyle(color: Colors.white),
                  )),
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.red)),
                  onPressed: () {
                    exit(0);
                  },
                  child: Text(
                    "Yes",
                    style: TextStyle(color: Colors.white),
                  )),
            ],
          ),
        );

        return true;
      },
      child: Sizer(
        builder: (context, orientation, deviceType) => Scaffold(
          drawer: Drawer(
            backgroundColor: Colors.grey.shade300,
            child: ListView(
              children: [
                Container(
                  width: size.width,
                  height: 75,
                  color: Color.fromARGB(255, 184, 178, 178),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "dolphin",
                        style: TextStyle(
                            fontFamily: "abnes",
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      ),
                      Container(
                          margin: EdgeInsets.only(top: 10),
                          width: 25,
                          height: 25,
                          child: Image.asset("Assets/Images/call3.png")),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Icon(
                  CupertinoIcons.person_alt_circle,
                  color: Colors.grey,
                  size: 120,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  name.toString(),
                  style: TextStyle(
                      fontSize: 17,
                      color: Colors.grey.shade800,
                      fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  email.toString(),
                  style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey.shade800,
                      fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 10,
                ),
                Divider(
                  color: Colors.grey.shade400,
                  thickness: 1,
                ),
                SizedBox(
                  height: 10,
                ),
                ListTile(
                  onTap: () {
                    Get.to(Account());
                  },
                  contentPadding: EdgeInsets.only(),
                  leading: Transform(
                    transform: Matrix4.translationValues(15, 0, 0),
                    child: Icon(
                      Icons.person,
                      color: Colors.grey,
                    ),
                  ),
                  title: Text(
                    "Profile",
                    style: TextStyle(color: Colors.grey.shade700, fontSize: 16),
                  ),
                ),
                ListTile(
                  onTap: () {
                    showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text("LogOut"),
                        content: Text("Are you sure you want to logout?"),
                        actions: [
                          IconButton(
                            icon: Icon(
                              Icons.cancel,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            color: Colors.red,
                          ),
                          IconButton(
                            icon: Icon(Icons.done),
                            onPressed: () {
                              _signOut();
                            },
                            color: Colors.green,
                          )
                        ],
                      ),
                    );
                  },
                  contentPadding: EdgeInsets.only(),
                  leading: Transform(
                    transform: Matrix4.translationValues(15, 0, 0),
                    child: Icon(
                      Icons.power_settings_new_rounded,
                      color: Colors.grey,
                    ),
                  ),
                  title: Text(
                    "Logout",
                    style: TextStyle(color: Colors.grey.shade700, fontSize: 16),
                  ),
                )
              ],
            ),
          ),
          appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.black),
            toolbarHeight: 70,
            backgroundColor: Color.fromARGB(255, 196, 191, 191),
            centerTitle: true,
            title: Container(
                width: 100,
                height: 70,
                child: Image(image: AssetImage("Assets/Images/logo.png"))),
          ),
          backgroundColor: bgcolor,
          body: SafeArea(
            child: ontap
                ? SizedBox(
                    width: size.width,
                    height: size.height,
                    child: Form(
                      key: formKey1,
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 140,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: TextField(
                                readOnly: true,
                                style: TextStyle(
                                  color: Colors.grey.shade800,
                                  fontWeight: FontWeight.w500,
                                ),
                                controller: namecontroller,
                                decoration: InputDecoration(
                                  labelText: "UserName",
                                  labelStyle: TextStyle(
                                      color: Colors.grey.shade500,
                                      fontSize: 17),
                                  fillColor: Colors.grey.shade200,
                                  filled: true,
                                  border: InputBorder.none,
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide(
                                          color: Colors.grey.shade400,
                                          width: 1)),
                                  errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide(
                                          color: Colors.grey.shade400,
                                          width: 1)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide(
                                          color: Colors.grey.shade400,
                                          width: 1)),
                                  disabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide(
                                          color: Colors.grey.shade400,
                                          width: 1)),
                                  focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide(
                                          color: Colors.grey.shade400,
                                          width: 1)),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: TextFormField(
                                validator: (val) {
                                  if (val!.isNotEmpty) {
                                    return null;
                                  } else {
                                    return "Please enter user id";
                                  }
                                },
                                onChanged: (val) {
                                  setState(() {
                                    callId = val;
                                  });
                                },
                                decoration: InputDecoration(
                                  labelText: "call Id",
                                  labelStyle:
                                      TextStyle(color: Colors.grey.shade500),
                                  fillColor: Colors.grey.shade200,
                                  filled: true,
                                  border: InputBorder.none,
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide(
                                          color: Colors.grey.shade400,
                                          width: 1)),
                                  errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide(
                                          color: Colors.red, width: 1)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide(
                                          color: Colors.grey.shade400,
                                          width: 1)),
                                  disabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide(
                                          color: Colors.grey.shade400,
                                          width: 1)),
                                  focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide(
                                          color: Colors.red, width: 1)),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Container(
                              width: 150,
                              height: 50,
                              child: ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Color.fromARGB(
                                                  255, 196, 191, 191))),
                                  onPressed: () {
                                    if (formKey1.currentState!.validate()) {
                                      Get.to(VideoChatScreen(
                                        userId: userid,
                                        userName: name,
                                        callid: callId,
                                      ));
                                    } else {}
                                  },
                                  child: Text(
                                    "START",
                                    style: TextStyle(
                                        color: Colors.grey.shade900,
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold),
                                  )),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                : SizedBox(
                    width: size.width,
                    height: size.height,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            network!
                                ? setState(() {
                                    ontap = true;
                                  })
                                : ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content:
                                            Text("No internet connection!")));
                          },
                          child: Container(
                              width: 200,
                              height: 200,
                              child: Image(
                                  image:
                                      AssetImage("Assets/Images/video.png"))),
                        ),
                      ],
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  errorWidget() {
    Size size = MediaQuery.of(context).size;
    return Sizer(
        builder: (context, orientation, deviceType) => Scaffold(
              backgroundColor: bgcolor,
              body: SizedBox(
                width: size.width,
                height: size.height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "ooops!",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "NoConnection!",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {});
                      },
                      child: Container(
                        width: 100,
                        height: 100,
                        color: Colors.black,
                        child: Center(
                            child: Text(
                          "Retry",
                          style: TextStyle(color: Colors.white),
                        )),
                      ),
                    )
                  ],
                ),
              ),
            ));
  }
}
