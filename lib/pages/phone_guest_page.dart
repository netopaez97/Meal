import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meal/pages/email_guest_page.dart';
import 'package:meal/routes/routes.dart';
import 'package:meal/utils/utils.dart';
import 'package:meal/widgets/widgets.dart';

class GuestPage extends StatelessWidget {
  static const routeName = 'GuestPage';
  @override
  Widget build(BuildContext context) {
    final primaryColor = Color(0xffF26722);
    final backgroundColor = Color(0xff241C24);
    return Scaffold(
      appBar: AppBar(elevation: 0),
      backgroundColor: backgroundColor,
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
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
            
            Container(
              width: pageWidthPresentation,
              child: Row(
                children: <Widget>[
                  Flexible(child: InputText(text: "Your guest's phone"),),
                  CupertinoButton(
                    onPressed: (){
                      Navigator.pushNamed(context, Routes.guestEmail);
                    },
                    padding: EdgeInsets.zero,
                    child: Column(
                      children: <Widget>[
                        Icon(Icons.add, size:50, color: orangeColor),
                        Text("Add guest", style: TextStyle(fontSize: 17, color: Colors.white))
                      ]
                    )
                  ),
                ]
              )
            )
          ],
        ),
      ),
    );
  }
}
