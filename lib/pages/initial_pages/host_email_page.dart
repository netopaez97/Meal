import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meal/preferences/userpreferences.dart';
import 'package:meal/routes/routes.dart';
import 'package:meal/utils/utils.dart';
import 'package:meal/widgets/widgets.dart';

class HostEmailPage extends StatefulWidget {
  
  static const routeName = 'HostEmailPage';

  @override
  _HostEmailPageState createState() => _HostEmailPageState();
}

class _HostEmailPageState extends State<HostEmailPage> {
  final prefs = new UserPreferences();

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(elevation: 0),
      backgroundColor: blackColors,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
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
              child: _fieldForEmail(media),
            ),
          ),
          CupertinoButton(
            padding: EdgeInsets.zero,
            child: InputText(
              text: "Your email address?",
              scale: media.width * 0.004,
            ),
            onPressed: (){
              Navigator.pushNamed(context, Routes.guestPhone);
            },
          ),
        ],
      ),
    );
  }

  Widget _fieldForEmail(Size media){
    return TextField(
      textAlign: TextAlign.center,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(border: InputBorder.none),
      cursorColor: orangeColors,
      cursorWidth: 1.0,
      style: TextStyle(
        color: blackColors,
        fontSize: media.width * 0.07,
      ),
      onChanged: (value){
        prefs.email = value;
      },
    );
  }

}