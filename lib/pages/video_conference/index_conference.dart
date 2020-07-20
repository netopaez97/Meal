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
  /// create a channelController to retrieve text value
  final _channelController = TextEditingController();

  /// if channel textField is validated to have error

  ClientRole _role = ClientRole.Broadcaster;

  @override
  void dispose() {
    // dispose input controller
    _channelController.dispose();
    super.dispose();
  }

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
                  "Welcome to your personal meeting in Meal.",
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Divider(),

              IconAdd(onPressed: onJoin)
              // Row(
              //   children: <Widget>[
              //     Expanded(
              //         child: TextField(
              //       enabled: true,
              //       controller: _channelController,
              //       decoration: InputDecoration(
              //         errorText:
              //             _validateError ? 'Channel name is mandatory' : null,
              //         border: UnderlineInputBorder(
              //           borderSide: BorderSide(width: 1),
              //         ),
              //         hintText: 'Channel name',
              //       ),
              //     ))
              //   ],
              // ),
              // Column(
              //   children: [
              //     ListTile(
              //       title: Text("Join as diner"),
              //       leading: Radio(
              //         value: ClientRole.Broadcaster,
              //         groupValue: _role,
              //         onChanged: (ClientRole value) {
              //           setState(() {
              //             _role = value;
              //           });
              //         },
              //       ),
              //     ),
              //     ListTile(
              //       title: Text("Join as viewer"),
              //       leading: Radio(
              //         value: ClientRole.Audience,
              //         groupValue: _role,
              //         onChanged: (ClientRole value) {
              //           setState(() {
              //             _role = value;
              //           });
              //         },
              //       ),
              //     )
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> onJoin() async {
    // update input validation

    if (_channelController.text.isNotEmpty) {
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
  }

  Future<void> _handleCameraAndMic() async {
    await PermissionHandler().requestPermissions(
      [PermissionGroup.camera, PermissionGroup.microphone],
    );
  }
}
