import 'dart:async';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:meal/pages/video_conference/conference_page.dart';
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
  bool _validateError = false;

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
          child: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Welcome to your personal meeting in Meal. \n\nPlease, type a channel name that you would like to share with your friends.", style: TextStyle(fontSize: 20),),
              ),
              Divider(),
              Row(
                children: <Widget>[
                  Expanded(
                      child: TextField(
                    controller: _channelController,
                    decoration: InputDecoration(
                      errorText:
                          _validateError ? 'Channel name is mandatory' : null,
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(width: 1),
                      ),
                      hintText: 'Channel name',
                    ),
                  ))
                ],
              ),
              Column(
                children: [
                  ListTile(
                    title: Text("Join as diner"),
                    leading: Radio(
                      value: ClientRole.Broadcaster,
                      groupValue: _role,
                      onChanged: (ClientRole value) {
                        setState(() {
                          _role = value;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: Text("Join as viewer"),
                    leading: Radio(
                      value: ClientRole.Audience,
                      groupValue: _role,
                      onChanged: (ClientRole value) {
                        setState(() {
                          _role = value;
                        });
                      },
                    ),
                  )
                ],
              ),
              IconAdd(onPressed: onJoin)
            ],
          ),
        ),
      ),
    );
  }

  Future<void> onJoin() async {
    // update input validation
    setState(() {
      _channelController.text.isEmpty
          ? _validateError = true
          : _validateError = false;
    });
    if (_channelController.text.isNotEmpty) {
      // await for camera and mic permissions before pushing video page
      await _handleCameraAndMic();
      // push video page with given channel name
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ConferencePage(
            channelName: _channelController.text,
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