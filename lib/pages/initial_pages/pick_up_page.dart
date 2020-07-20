import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meal/preferences/userpreferences.dart';
import 'package:meal/routes/routes.dart';
import 'package:meal/utils/utils.dart';
import 'package:meal/widgets/widgets.dart';

class PickUpPage extends StatelessWidget {
  static const routeName = 'PickUpPage';

  final prefs = new UserPreferences();
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
        child: Container(
          width: media.width * 0.8,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: media.width * 0.15,
                width: media.width * 0.8,
                child: FittedBox(
                  fit: BoxFit.fill,
                  child: Text(
                    'Pick Up',
                    style: TextStyle(
                      color: orangeColors,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(height: media.width * 0.1),
              InputText(
                text: "Host will pick up both orders",
                scale: media.width * 0.004,
              ),
              SizedBox(height: 2),
              CupertinoButton(
                padding: EdgeInsets.zero,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  width: media.width * 0.8,
                  child: Text(
                    "Host Only",
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
                  prefs.pickup = host;
                  Navigator.pushNamed(context, Routes.payment);
                },
              ),
              SizedBox(height: media.width * 0.05),
              InputText(
                text: "Guest and Host will pick up their own orders",
                scale: media.width * 0.004,
              ),
              SizedBox(height: 2),
              CupertinoButton(
                padding: EdgeInsets.zero,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  width: media.width * 0.8,
                  child: Text(
                    "Guest + Host",
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
                  prefs.pickup = guest;
                  Navigator.pushNamed(context, Routes.payment);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
