import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meal/routes/routes.dart';
import 'package:meal/utils/utils.dart';

class InitialPage extends StatelessWidget {
  static const routeName = 'InitialPage';
  @override
  Widget build(BuildContext context) {

    final media = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(elevation: 0),
      backgroundColor: blackColors,
      body: Padding(
        padding: EdgeInsets.only(
          left: media.width * 0.1,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: media.width * 0.16,
              width: media.width * 0.8,
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
              height: media.width * 0.7,
              width: media.width * 0.8,
              child: Text(
                'Thank you for using MEAL! This is a pilot version of the app, which we are working to improve. Please let us know what you think!\nShare your suggestions for ways we can improve! you can participate in a short survey at the end of your order. Enjoy your MEAL!',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.normal,
                ),
                textScaleFactor: media.width * 0.004,
              ),
            ),
            CupertinoButton(
              padding: EdgeInsets.zero,
              child: Row(
                children: <Widget>[
                  Icon(Icons.add,
                      size: media.width * 0.15, color: orangeColor),
                  SizedBox(
                    width: 5,
                  ),
                  Container(
                    height: media.width * 0.1,
                    width: media.width * 0.6,
                    child: FittedBox(
                      fit: BoxFit.fill,
                      child: Text(
                        "Go to meal",
                        style: TextStyle(
                          color: orangeColor,
                          fontWeight: FontWeight.normal,
                        ),
                        textScaleFactor: media.width * 0.0055,
                      ),
                    ),
                  ),
                ],
              ),
              onPressed: (){
                Navigator.pushNamed(context, Routes.hostPhone);
              },
            ),
          ],
        ),
      ),
    );
  }
}