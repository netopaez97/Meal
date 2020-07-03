import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meal/preferences/userpreferences.dart';
import 'package:meal/routes/routes.dart';
import 'package:meal/utils/utils.dart';
import 'package:meal/widgets/widgets.dart';

class HostEmailPage extends StatefulWidget {
  static const routeName = 'HostEmailPage';

  @override
  _HostEmailPageState createState() => _HostEmailPageState();
}

class _HostEmailPageState extends State<HostEmailPage> {
  final prefs = new UserPreferences();

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(elevation: 0),
      backgroundColor: blackColors,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: media.width * 0.5),
            Meal(),
            SizedBox(height: 5),
            Container(
              width: media.width * 0.8,
              height: media.width * 0.14,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: _fieldForEmail(media),
              ),
            ),
            SizedBox(height: 5),
            CupertinoButton(
              padding: EdgeInsets.zero,
              child: InputText(
                text: "Your email address?",
                scale: media.width * 0.0055,
              ),
              onPressed: () {
                Navigator.pushNamed(context, Routes.guestPhone);
              },
            ),
            SizedBox(height: media.width * 0.5),
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
              onPressed: () {
                if (prefs.phone != '') {
                  Navigator.pushNamed(context, Routes.guestPhone);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _fieldForEmail(Size media) {
    return TextFormField(
      initialValue: prefs.email,
      textAlign: TextAlign.center,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(border: InputBorder.none),
      cursorColor: orangeColors,
      cursorWidth: 1.0,
      style: TextStyle(
        color: blackColors,
        fontSize: media.width * 0.07,
      ),
      onChanged: (value) {
        prefs.email = value;
      },
    );
  }
}
