import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meal/preferences/userpreferences.dart';
import 'package:meal/providers/shopping_cart_provider.dart';
import 'package:meal/providers/user_provider.dart';
import 'package:meal/routes/routes.dart';
import 'package:meal/utils/utils.dart';
import 'package:meal/widgets/widgets.dart';

class PhonePage extends StatefulWidget {
  static const routeName = 'PhonePage';

  @override
  _PhonePageState createState() => _PhonePageState();
}

class _PhonePageState extends State<PhonePage> {

  bool _loadingWidget = false;

  @override
  Widget build(BuildContext context) {
    final ShoppingCartProvider _shoppingCartProvider = ShoppingCartProvider();

    final prefs = new UserPreferences();
    final userProvider = UserProvider();
    final media = MediaQuery.of(context).size;
    var container = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(height: media.width * 0.45),
        Meal(),
        SizedBox(height: 5),
        InputPhone(
          initialValue: prefs.phone,
          onChanged: (value) {
            prefs.phone = value;
          },
        ),
        SizedBox(height: 5),
        InputText(
          text: "Your phone number?",
          scale: media.width * 0.006,
        ),
        SizedBox(height: media.width * 0.45),
        _loadingWidget == true
        ? Padding(
          padding: const EdgeInsets.all(5.0),
          child: Center(child: CircularProgressIndicator()),
        )
        : CupertinoButton(
          child: Container(
            width: media.width * 0.8,
            child: Text(
              "Next",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.normal,
              ),
              textAlign: TextAlign.center,
              textScaleFactor: media.width * 0.006,
            ),
            decoration: BoxDecoration(
              color: orangeColors,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onPressed: () async {

            setState(()=>_loadingWidget=true);

            ///Verify if there is a phone registered for the user
            if (prefs.phone != '') {
              prefs.host = 'Host - ${prefs.phone}';

              ///Verify if there is a uid in the database for this user.
              ///At this moment, we give the uid for the user as a DateTime.now() because we don't have a AUTH system.
              if (prefs.uid.isEmpty) {
                prefs.uid = DateTime.now().toString();
                await userProvider.insertUser();
              }
              ///If the user exist, we should update it with the new number
              else{
                await userProvider.insertUser();
              }

              await _shoppingCartProvider.deleteAll().then(
                (res)=>setState(()=>_loadingWidget=true)
              ).catchError(
                (err){
                  showDialog(context: context, builder: (BuildContext context)=>AlertDialog(title: Text("Please, verify your internet connection.")));
                  return ;
                }
              );
              setState(()=>_loadingWidget=false);
              Navigator.pushNamed(context, Routes.selection);
            }
            else{
              await showDialog(context: context, builder:(BuildContext context)=>AlertDialog(title:Text("Please, enter your phone number")));
              setState(()=>_loadingWidget=false);
            }
          },
        ),
      ],
    );
    return Scaffold(
      appBar: AppBar(elevation: 0),
      backgroundColor: blackColors,
      body: SingleChildScrollView(child: container),
    );
  }
}
