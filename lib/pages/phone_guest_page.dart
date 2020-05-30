import 'package:flutter/material.dart';
import 'package:meal/pages/email_guest_page.dart';
import 'package:meal/widgets/widgets.dart';

class GuestPage extends StatelessWidget {
  static const routeName = 'GuestPage';
  @override
  Widget build(BuildContext context) {
    final primaryColor = Color(0xffF26722);
    final backgroundColor = Color(0xff241C24);
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Meal(),
          SizedBox(height: 10),
          Input(
            typeInput: TextInputType.number,
            primaryColor: primaryColor,
            backgroundColor: backgroundColor,
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              InputText(text: "Your guest's phone"),
              SizedBox(width: 10),
              IconAdd(
                primaryColor: primaryColor,
                onTap: () {
                  Navigator.pushNamed(context, EmailPage.routeName);
                },
              ),
              SizedBox(width: 50),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              TextAdd(),
              SizedBox(width: 40),
            ],
          )
        ],
      ),
    );
  }
}
