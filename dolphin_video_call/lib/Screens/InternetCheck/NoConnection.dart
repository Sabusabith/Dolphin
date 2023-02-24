import 'package:dolphin_video_call/Helper/Colors..dart';
import 'package:dolphin_video_call/Screens/Home/Home.dart';
import 'package:dolphin_video_call/Screens/InternetCheck/InternetCheck.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class NoConnection extends StatefulWidget {
  const NoConnection({super.key});

  @override
  State<NoConnection> createState() => _NoConnectionState();
}

class _NoConnectionState extends State<NoConnection> {
  checkConnection() async {
    bool network = await internetCheck();

    if (network) {
      Get.to(Home());
    } else {
      Get.to(NoConnection());
    }
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "ooops!",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "NoConnection!",
                      style: TextStyle(
                        fontSize: 25,
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    GestureDetector(
                      onTap: () {
                        checkConnection();
                      },
                      child: Container(
                        width: 100,
                        height: 50,
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
