import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

import 'dart:math' as math;

class VideoChatScreen extends StatelessWidget {
  VideoChatScreen(
      {super.key,
      required this.userId,
      required this.userName,
      required this.callid});
  var userId;
  var userName;
  dynamic callid;
  final String localUserID = math.Random().nextInt(10000).toString();
  @override
  Widget build(BuildContext context) {
    return ZegoUIKitPrebuiltCall(
        appID: 2067825195,
        appSign:
            "6038dfc161e9f1d6340c0324792a2ef4cc178ccebdd139f62bc755f018072cc0",
        callID: callid.toString(),
        userID: localUserID,
        userName: userName,
        config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall());
  }
}
