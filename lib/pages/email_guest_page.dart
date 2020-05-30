import 'package:flutter/material.dart';
import 'package:meal/pages/date_page.dart';
import 'package:meal/widgets/widgets.dart';

class EmailPage extends StatelessWidget {
   static const routeName ='EmailPage';
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
            typeInput: TextInputType.emailAddress,
            primaryColor: primaryColor,
            backgroundColor: backgroundColor,
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              InputText(text: "Your guest's email"),
              SizedBox(width: 15),
              IconAdd(
                primaryColor: primaryColor,
                onTap: () {
                  Navigator.pushNamed(context, DatePage.routeName);
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
