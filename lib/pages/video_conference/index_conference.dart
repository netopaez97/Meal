import 'dart:async';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:meal/pages/video_conference/conference_page.dart';
import 'package:meal/preferences/userpreferences.dart';
import 'package:meal/widgets/widgets.dart';
import 'package:permission_handler/permission_handler.dart';

class IndexPage extends StatefulWidget {
  static const routeName = '/indexConference';

  @override
  State<StatefulWidget> createState() => IndexState();
}

class IndexState extends State<IndexPage> {

  ClientRole _role = ClientRole.Broadcaster;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meal using Agora'),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          height: 400,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  "Are you ready to meet with your friends?\n\nClick on below!",
                  style: TextStyle(fontSize: 20),
                  textAlign: TextAlign.center,
                ),
              ),
              Divider(),

              IconAdd(onPressed: onJoin)
            ],
          ),
        ),
      ),
    );
  }

  Future<void> onJoin() async {

    // await for camera and mic permissions before pushing video page
    await _handleCameraAndMic();
    // push video page with given channel name
    final prefs = new UserPreferences();
    final channelName = prefs.channelName;
    prefs.channelName = '';
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ConferencePage(
          channelName: channelName,
          role: _role,
        ),
      ),
    );
  }

  Future<void> _handleCameraAndMic() async {
    await PermissionHandler().requestPermissions(
      [PermissionGroup.camera, PermissionGroup.microphone],
    );
  }
}
