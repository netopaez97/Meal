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
    final media = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(elevation: 0),
      backgroundColor: backgroundColor,
      body: Row(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
              left: media.width * 0.2,
            ),
            child: Container(
              width: media.width * 0.6,
              height: media.height * 0.4,
              margin: EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'meal',
                    textScaleFactor: media.width * 0.019,
                    style: TextStyle(
                      color: Color(0xffF26722),
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(border: InputBorder.none),
                      cursorColor: primaryColor,
                      cursorWidth: 1.0,
                      style: TextStyle(
                        color: backgroundColor,
                        fontSize: 23,
                      ),
                    ),
                  ),
                  Text(
                    "Your guest's phone",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                    ),
                    textScaleFactor: media.width * 0.005,
                  )
                ],
              ),
            ),
          ),
          Column(
            children: <Widget>[
              SizedBox(height: media.height * 0.24),
              Icon(Icons.add, size: media.width * 0.12, color: orangeColor),
              Text(
                "Add guest",
                style: TextStyle(color: Colors.white),
                textScaleFactor: media.width * 0.002,
              )
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          )
        ],
      ),
    );
  }
}

// class GuestPage extends StatelessWidget {
//   static const routeName = 'GuestPage';
//   @override
//   Widget build(BuildContext context) {
//     final primaryColor = Color(0xffF26722);
//     final backgroundColor = Color(0xff241C24);
//     return Scaffold(
//       appBar: AppBar(elevation: 0),
//       backgroundColor: backgroundColor,
//       body: Container(
//         width: MediaQuery.of(context).size.width,
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
//               width: pageWidthPresentation,
//               child: Row(
//                 children: <Widget>[
//                   Flexible(child: InputText(text: "Your guest's phone"),),
//                   CupertinoButton(
//                     onPressed: (){
//                       Navigator.pushNamed(context, Routes.guestEmail);
//                     },
//                     padding: EdgeInsets.zero,
//                     child: Column(
//                       children: <Widget>[
//                         Icon(Icons.add, size:50, color: orangeColor),
//                         Text("Add guest", style: TextStyle(fontSize: 17, color: Colors.white))
//                       ]
//                     )
//                   ),
//                 ]
//               )
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
