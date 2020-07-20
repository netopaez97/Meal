import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meal/preferences/userpreferences.dart';
import 'package:meal/routes/routes.dart';
import 'package:meal/utils/utils.dart';
import 'package:meal/widgets/widgets.dart';

class GuestPage extends StatelessWidget {
  static const routeName = 'GuestPage';
  @override
  Widget build(BuildContext context) {
    final prefs = UserPreferences();
    final media = MediaQuery.of(context).size;
    GlobalKey<ScaffoldState> _scaffolKey = GlobalKey<ScaffoldState>();
    var container = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(height: media.width * 0.2),
        Meal(),
        SizedBox(height: 10),
        InputPhone(
          initialValue: prefs.guest1,
          onChanged: (value) => prefs.guest1 = value,
        ),
        SizedBox(height: 5),
        InputText(
          text: "Your first guest's phone?",
          scale: media.width * 0.0045,
        ),
        SizedBox(height: 10),
        InputPhone(
          initialValue: prefs.guest2,
          onChanged: (value) => prefs.guest2 = value,
        ),
        SizedBox(height: 5),
        InputText(
          text: "Your second guest's phone?",
          scale: media.width * 0.0045,
        ),
        SizedBox(height: 10),
        InputPhone(
          initialValue: prefs.guest3,
          onChanged: (value) => prefs.guest3 = value,
        ),
        SizedBox(height: 5),
        InputText(
          text: "Your third guest's phone?",
          scale: media.width * 0.0045,
        ),
        SizedBox(height: media.width * 0.2),
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
            if (prefs.guest1 != null && prefs.guest1 != '') {
              prefs.uidguest1 = 'First guest - ${prefs.guest1}';
              if (prefs.guest2 != null && prefs.guest2 != '') {
                prefs.uidguest2 = 'Second guest - ${prefs.guest2}';
              }
              if (prefs.guest3 != null && prefs.guest3 != '') {
                prefs.uidguest3 = 'Third guest - ${prefs.guest3}';
              }
              Navigator.pushNamed(context, Routes.date);
            } else {
              _scaffolKey.currentState.showSnackBar(SnackBar(
                content: Text('Must have at least one first guest'),
                duration: Duration(seconds: 4),
              ));
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
