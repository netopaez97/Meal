import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meal/providers/guest_provider.dart';
import 'package:meal/routes/routes.dart';
import 'package:meal/utils/utils.dart';
import 'package:meal/widgets/widgets.dart';
import 'package:provider/provider.dart';

class SelectionPage extends StatelessWidget {
  static const routeName = 'SelectionPage';
  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> _scaffolKey = GlobalKey<ScaffoldState>();
    final guestProvider = Provider.of<GuestProvider>(context,listen: false);
    final media = MediaQuery.of(context).size;

    return Scaffold(
      key: _scaffolKey,
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
              Meal(),
              SizedBox(height: media.width * 0.2),
              CupertinoButton(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    width: media.width * 0.8,
                    child: Text(
                      "Add more guests",
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
                    if (guestProvider.guestCount < 3) {
                      Navigator.pushNamed(context, Routes.guestPhone);
                    } else {
                      _scaffolKey.currentState.showSnackBar(SnackBar(
                        content: Text('No puedes tener mas de tres invitados'),
                        duration: Duration(seconds: 4),
                      ));
                      print(guestProvider.guests);
                    }
                  }),
              CupertinoButton(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  width: media.width * 0.8,
                  child: Text(
                    "Go to menu",
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
                onPressed: () => Navigator.pushNamed(context, Routes.date),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
