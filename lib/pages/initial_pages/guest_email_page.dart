import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meal/routes/routes.dart';
import 'package:meal/utils/utils.dart';
import 'package:meal/widgets/widgets.dart';

class EmailPage extends StatelessWidget {
  static const routeName = 'EmailPage';
  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      backgroundColor: blackColors,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: media.width * 0.5),
            Meal(),
            SizedBox(height: 5),
            Input(typeInput: TextInputType.number, onChanged: (value) {}),
            SizedBox(height: 5),
            InputText(
              text: "Your guest's email?",
              scale: media.width * 0.0065,
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
                Navigator.pushNamed(context, Routes.selection);
              },
            ),
          ],
        ),
      ),
    );
  }
}

// class EmailPage extends StatelessWidget {
//    static const routeName ='EmailPage';
//   @override
//   Widget build(BuildContext context) {
//     final primaryColor = Color(0xffF26722);
//     final backgroundColor = Color(0xff241C24);
//     return Scaffold(
//       appBar: AppBar(elevation: 0,),
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
//               typeInput: TextInputType.emailAddress,
//               primaryColor: primaryColor,
//               backgroundColor: backgroundColor,
//             ),
//             SizedBox(height: 10),
//             Container(
//               width: pageWidthPresentation,
//               child: Row(
//                 children: <Widget>[
//                     Flexible(child: InputText(text: "Your guest's email"),),
//                     CupertinoButton(
//                       onPressed: (){
//                         Navigator.pushNamed(context, Routes.date);
//                       },
//                       padding: EdgeInsets.zero,
//                       child: Column(
//                         children: <Widget>[
//                           Icon(Icons.add, size:50, color: orangeColor),
//                           Text("Add guest", style: TextStyle(fontSize: 17, color: Colors.white))
//                         ]
//                       )
//                     ),
//                 ]
//               )
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
