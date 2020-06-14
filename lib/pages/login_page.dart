import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meal/routes/routes.dart';
import 'package:meal/utils/utils.dart';
import 'package:meal/widgets/widgets.dart';

class LoginPage extends StatelessWidget {
  static const routeName = 'LoginPage';
  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(elevation:0),
      backgroundColor: blackColors,
      body: Padding(
        padding: EdgeInsets.only(
          left: media.width * 0.2,
        ),
        child: Container(
          width: media.width * 0.8,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Meal(),
              Container(
                width: media.width * 0.6,
                height: media.width * 0.14,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: TextField(
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Email',
                      hintStyle: TextStyle(
                        color: blackColors.withOpacity(0.5),
                        fontSize: media.width * 0.06,
                      ),
                    ),
                    cursorColor: orangeColors,
                    cursorWidth: 1.0,
                    style: TextStyle(
                      color: blackColors,
                      fontSize: media.width * 0.07,
                    ),
                    onChanged: (value) => {},
                  ),
                ),
              ),
              SizedBox(height: 10),
              Row(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Container(
                        width: media.width * 0.6,
                        height: media.width * 0.14,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: TextField(
                            obscureText: true,
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Password',
                              hintStyle: TextStyle(
                                color: blackColors.withOpacity(0.5),
                                fontSize: media.width * 0.06,
                              ),
                            ),
                            cursorColor: orangeColors,
                            cursorWidth: 1.0,
                            style: TextStyle(
                              color: blackColors,
                              fontSize: media.width * 0.07,
                            ),
                            onChanged: (value) => {},
                          ),
                        ),
                      ),
                      SizedBox(height: media.width * 0.01)
                    ],
                  ),
                  SizedBox(width: media.width * 0.015),
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    child: Column(
                      children: <Widget>[
                        Icon(Icons.add,
                            size: media.width * 0.15, color: orangeColor),
                      ],
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, Routes.phone);
                    },
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
