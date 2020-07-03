import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meal/preferences/userpreferences.dart';
import 'package:meal/routes/routes.dart';
import 'package:meal/utils/utils.dart';
import 'package:meal/widgets/widgets.dart';

class PhonePage extends StatelessWidget {
  static const routeName = 'PhonePage';
  final prefs = new UserPreferences();
  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    var container = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(height: media.width * 0.5),
        Meal(),
        SizedBox(height: 5),
        Input(
          initialValue: prefs.phone,
          typeInput: TextInputType.number,
          onChanged: (value) {
            prefs.phone = value;
          },
        ),
        SizedBox(height: 5),
        InputText(
          text: "Your phone number?",
          scale: media.width * 0.006,
        ),
        SizedBox(height: media.width * 0.5),
        CupertinoButton(
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
          onPressed: () {
            if (prefs.phone != '') {
              Navigator.pushNamed(context, Routes.guestPhone);
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

// class PhonePage extends StatefulWidget {
//   static const routeName = 'PhonePage';

//   @override
//   _PhonePageState createState() => _PhonePageState();
// }

// class _PhonePageState extends State<PhonePage> {

//   @override
//   void initState(){
//     super.initState();
//     SystemChrome.setPreferredOrientations([
//         DeviceOrientation.portraitUp,
//         DeviceOrientation.portraitDown,
//     ]);
//   }

//   @override
//   dispose(){
//     SystemChrome.setPreferredOrientations([
//       DeviceOrientation.landscapeRight,
//       DeviceOrientation.landscapeLeft,
//       DeviceOrientation.portraitUp,
//       DeviceOrientation.portraitDown,
//     ]);
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final primaryColor = Color(0xffF26722);
//     final backgroundColor = Color(0xff241C24);

//     // return _bodyPage();
//     return Scaffold(
//       backgroundColor: backgroundColor,
//       body: Container(
//         width: MediaQuery.of(context).size.width,
//         alignment: Alignment.center,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Meal(),
//             SizedBox(height: 10),
//             Input(
//               typeInput: TextInputType.number,
//               primaryColor: primaryColor,
//               backgroundColor: backgroundColor,
//             ),
//             SizedBox(height: 10),
//             Container(
//               width: 221,
//               child:CupertinoButton(
//                 onPressed: (){
//                   Navigator.pushNamed(context, Routes.guestPhone);
//                 },
//                 padding: EdgeInsets.zero,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: <Widget>[
//                     Text('Your phone number', style: TextStyle(color:Colors.white, fontSize: 20)),
//                     Icon(Icons.add, size:50, color: orangeColor),
//                   ]
//                 )
//               )
//             )
//           ],
//         ),
//       ),
//     );

//   }

//   Widget _bodyPage(){
//     return Scaffold(
//       backgroundColor: blackColor,
//       body: Center(
//         child: Container(
//           alignment: Alignment.center,
//           width: pageWidthPresentation,
//           height: MediaQuery.of(context).size.height,
//           child: Container(
//             height: 400,
//             child: ListView(
//               children:<Widget>[
//                 Center(child: Meal(),),
//                 SizedBox(height:10),
//                 Input(typeInput: TextInputType.phone, primaryColor: orangeColor, backgroundColor: blackColor),
//                 SizedBox(height:10),
//                 CupertinoButton(
//                   onPressed: (){
//                     Navigator.pushNamed(context, Routes.guestPhone);
//                   },
//                   padding: EdgeInsets.zero,
//                   child: Row(
//                     children: <Widget>[
//                       Text('Your phone number', style: TextStyle(color:Colors.white, fontSize: 21)),
//                       Icon(Icons.add, size:50, color: orangeColor),
//                     ]
//                   )
//                 )
//               ]
//             ),
//           )
//         ),
//       ),
//     );
//   }

//   Widget _phoneField(){
//     return Container(

//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: TextField(
//         decoration: InputDecoration(
//           border: InputBorder.none,
//         ),
//       ),
//     );
//   }
// }
