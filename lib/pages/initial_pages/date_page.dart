import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meal/preferences/userpreferences.dart';
import 'package:meal/routes/routes.dart';
import 'package:meal/utils/utils.dart';

import 'package:meal/widgets/widgets.dart';

class DatePage extends StatefulWidget {
  static const routeName = 'DatePage';

  @override
  _DatePageState createState() => _DatePageState();
}

class _DatePageState extends State<DatePage> {
  final prefs = UserPreferences();

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    DateTime _dateTime = DateTime.now();
    return Scaffold(
      appBar: AppBar(elevation: 0),
      backgroundColor: blackColors,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Meal(),
              InputText(
                text: "When is your meal?",
                scale: media.width * 0.006,
              ),
              CupertinoButton(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  width: media.width * 0.8,
                  child: Text(
                    "Next",
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
                // onPressed: () => Navigator.pushNamedAndRemoveUntil(
                //     context, Routes.home, (Route routes) => false),
                onPressed: () {
                  if (prefs.rol != noguests) {
                    prefs.channelName = DateTime.now().toString();
                    Navigator.pushNamed(context, Routes.menu);
                  } else {
                    prefs.channelName = '';
                    Navigator.pushNamedAndRemoveUntil(
                        context, Routes.home, (Route routes) => false);
                  }
                },
              ),
            ],
          ),
          SizedBox(height: media.width * 0.1),
          Container(
            color: Colors.white,
            height: media.width * 0.7,
            width: media.width,
            child: CupertinoTheme(
              data: CupertinoThemeData(
                textTheme: CupertinoTextThemeData(
                  dateTimePickerTextStyle: TextStyle(
                    fontSize: media.width * 0.04,
                  ),
                ),
              ),
              child: CupertinoDatePicker(
                initialDateTime: _dateTime,
                minimumDate: _dateTime,
                onDateTimeChanged: (dateTime) {
                  setState(() {
                    _dateTime = dateTime;
                    prefs.date = _dateTime.toString();
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
