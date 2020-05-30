import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meal/pages/home.dart';

import 'package:meal/widgets/widgets.dart';

class DatePage extends StatefulWidget {
   static const routeName ='DatePage';
  @override
  _DatePageState createState() => _DatePageState();
}

class _DatePageState extends State<DatePage> {
  @override
  Widget build(BuildContext context) {
    final primaryColor = Color(0xffF26722);
    final backgroundColor = Color(0xff241C24);
    DateTime _dateTime = DateTime.now();

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Meal(),
            SizedBox(height: 10),
            SizedBox(height: 10),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    height: 200,
                    width: 300,
                    child: CupertinoDatePicker(
                      initialDateTime: _dateTime,
                      onDateTimeChanged: (dateTime) {
                        setState(() {
                          _dateTime = dateTime;
                        });
                      },
                    ),
                  ),
                  SizedBox(width: 10),
                  IconAdd(
                    primaryColor: primaryColor,
                    onTap: () {
                      Navigator.pushNamed(context, HomePage.routeName);
                    },
                  ),
                  SizedBox(width: 10),
                ],
              ),
            ),
            SizedBox(height: 10),
            InputText(text: 'What time is your meal?'),
          ],
        ),
      ),
    );
  }
}
