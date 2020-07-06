import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meal/routes/routes.dart';
import 'package:meal/utils/utils.dart';
import 'package:meal/widgets/widgets.dart';

class MenuPage extends StatelessWidget {
  static const routeName = 'Menu';
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
                    'Menu',
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
                text: "Host will order for all parties",
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
                onPressed: () => Navigator.pushNamedAndRemoveUntil(
                    context, Routes.home, (Route routes) => false),
              ),
              SizedBox(height: media.width * 0.05),
              InputText(
                text:
                    "Guest and Host will each select their own meal from the menu",
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
                onPressed: () => Navigator.pushNamedAndRemoveUntil(
                    context, Routes.home, (Route routes) => false),
              ),
            ],
          ),
        ),
      ),
    );
  }
}