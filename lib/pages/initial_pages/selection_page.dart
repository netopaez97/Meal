import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meal/preferences/userpreferences.dart';
import 'package:meal/routes/routes.dart';
import 'package:meal/utils/utils.dart';
import 'package:meal/widgets/widgets.dart';

class SelectionPage extends StatelessWidget {
  static const routeName = 'SelectionPage';
  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> _scaffolKey = GlobalKey<ScaffoldState>();
    final media = MediaQuery.of(context).size;
    final prefs = new UserPreferences();

    return Scaffold(
      key: _scaffolKey,
      appBar: AppBar(elevation: 0),
      backgroundColor: blackColors,
      body: Padding(
        padding: EdgeInsets.only(
          left: media.width * 0.1,
        ),
        child: Container(
          width: media.width * 0.8,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Meal(),
              SizedBox(height: media.width * 0.2),
              CupertinoButton(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    width: media.width * 0.8,
                    child: Text(
                      "Add guests",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.normal,
                      ),
                      textAlign: TextAlign.center,
                      textScaleFactor: media.width * 0.005,
                    ),
                    decoration: BoxDecoration(
                      color: orangeColors,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    prefs.rol = host;
                    Navigator.pushNamed(context, Routes.guestPhone);
                  }),
              CupertinoButton(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  width: media.width * 0.8,
                  child: Text(
                    "Go to menu",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                    ),
                    textAlign: TextAlign.center,
                    textScaleFactor: media.width * 0.005,
                  ),
                  decoration: BoxDecoration(
                    color: orangeColors,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  prefs.rol = noguests;
                  prefs.menu = noguests;
                  prefs.pickup = noguests;
                  prefs.payment = noguests;
                  prefs.guest1 = '';
                  prefs.guest2 = '';
                  prefs.guest3 = '';
                  prefs.uidguest1 = '';
                  prefs.uidguest2 = '';
                  prefs.uidguest3 = '';
                  prefs.host = '';
                  prefs.guest = '';
                  Navigator.pushNamed(context, Routes.date);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
