import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meal/routes/routes.dart';
import 'package:meal/utils/utils.dart';
import 'package:meal/widgets/widgets.dart';

class SelectionPage extends StatelessWidget {
  static const routeName = 'SelectionPage';
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
              Row(
                children: <Widget>[
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    child: Column(
                      children: <Widget>[
                        Icon(Icons.add,
                            size: media.width * 0.15, color: orangeColor),
                      ],
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, Routes.guestPhone);
                    },
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InputText(
                    text: "Add more guests",
                    scale: media.width * 0.0055,
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    child: Column(
                      children: <Widget>[
                        Icon(Icons.add,
                            size: media.width * 0.15, color: orangeColor),
                      ],
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, Routes.date);
                    },
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InputText(
                    text: "Go to menu",
                    scale: media.width * 0.0055,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
