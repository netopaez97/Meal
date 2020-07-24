import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meal/preferences/userpreferences.dart';
import 'package:meal/providers/user_provider.dart';
import 'package:meal/routes/routes.dart';
import 'package:meal/utils/utils.dart';
import 'package:meal/widgets/widgets.dart';

class PhonePage extends StatelessWidget {
  static const routeName = 'PhonePage';
  @override
  Widget build(BuildContext context) {
    final prefs = new UserPreferences();
    final userProvider = UserProvider();
    final media = MediaQuery.of(context).size;
    var container = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(height: media.width * 0.45),
        Meal(),
        SizedBox(height: 5),
        InputPhone(
          initialValue: prefs.phone,
          onChanged: (value) {
            prefs.phone = value;
          },
        ),
        SizedBox(height: 5),
        InputText(
          text: "Your phone number?",
          scale: media.width * 0.006,
        ),
        SizedBox(height: media.width * 0.45),
        CupertinoButton(
          child: Container(
            width: media.width * 0.8,
            child: Text(
              "Next",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.normal,
              ),
              textAlign: TextAlign.center,
              textScaleFactor: media.width * 0.006,
            ),
            decoration: BoxDecoration(
              color: orangeColors,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onPressed: () async {
            if (prefs.phone != '') {
              prefs.host = 'Host - ${prefs.phone}';
              if (prefs.uid.isEmpty) {
                prefs.uid = DateTime.now().toString();
                await userProvider.insertUser();
              }
              Navigator.pushNamed(context, Routes.selection);
            }
          },
        ),
      ],
    );
    return Scaffold(
      appBar: AppBar(elevation: 0),
      backgroundColor: blackColors,
      body: SingleChildScrollView(child: container),
    );
  }
}
