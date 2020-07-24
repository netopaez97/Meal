import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meal/routes/routes.dart';
import 'package:meal/utils/utils.dart';
import 'package:meal/preferences/userpreferences.dart';

class InitialPage extends StatelessWidget {
  static const routeName = 'InitialPage';
  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    final prefs = new UserPreferences();
    return Scaffold(
      appBar: AppBar(elevation: 0),
      backgroundColor: blackColors,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: media.width * 0.16,
              width: media.width * 0.9,
              child: FittedBox(
                fit: BoxFit.fill,
                child: Text(
                  'meal',
                  style: TextStyle(
                    color: orangeColors,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: media.width * 0.05,
              ),
              width: media.width * 0.9,
              child: Text(
                'Thank you for using MEAL! This is a pilot version of the app, which we are working to improve. Please let us know what you think!\nShare your suggestions for ways we can improve! you can participate in a short survey at the end of your order. Enjoy your MEAL!',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.normal,
                ),
                textAlign: TextAlign.justify,
                textScaleFactor: media.width * 0.0045,
              ),
            ),
            CupertinoButton(
              child: Container(
                width: media.width * 0.8,
                child: Text(
                  "Go to Meal",
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
              onPressed: () {
                prefs.date = null;
                  Navigator.pushNamed(context, Routes.hostPhone);
                // if (prefs.date.isEmpty) {
                // if (prefs.uid.isEmpty) {
                //   Navigator.pushNamed(context, Routes.hostPhone);
                // } else {
                //   Navigator.pushNamed(context, Routes.selection);
                // }
                // } else {
                //   final date = DateTime.parse(prefs.date);
                //   final dateTime =
                //       '${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}';
                //   final dateMeal = '${date.year}-${date.month}-${date.day}';
                //   if (dateTime == dateMeal) {
                //     Navigator.pushNamed(context, Routes.home);
                //   } else {
                //     prefs.date = '';
                //     Navigator.pushNamed(context, Routes.selection);
                //   }
                // }
              },
            ),
          ],
        ),
      ),
    );
  }
}
