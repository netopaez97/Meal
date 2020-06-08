import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meal/routes/routes.dart';
import 'package:meal/utils/utils.dart';

import 'package:meal/widgets/widgets.dart';

class DatePage extends StatefulWidget {
  static const routeName = 'DatePage';

  @override
  _DatePageState createState() => _DatePageState();
}

class _DatePageState extends State<DatePage> {
  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    DateTime _dateTime = DateTime.now();
    return Scaffold(
      appBar: AppBar(elevation: 0),
      backgroundColor: blackColors,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Padding(
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
                  Row(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          InputText(
                            text: "What is your meal?",
                            scale: media.width * 0.005,
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
                          Navigator.pushNamedAndRemoveUntil(context, Routes.home, (Route routes) => false);
                        },
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: media.width * 0.2),
          Container(
            color: Colors.white,
            height: media.width * 0.7,
            width: media.width,
            child: CupertinoTheme(
              data: CupertinoThemeData(
                textTheme: CupertinoTextThemeData(
                  dateTimePickerTextStyle: TextStyle(
                    fontSize: media.width * 0.07,
                  ),
                ),
              ),
              child: CupertinoDatePicker(
                initialDateTime: _dateTime,
                minimumDate: _dateTime,
                onDateTimeChanged: (dateTime) {
                  setState(() {
                    _dateTime = dateTime;
                  });
                },
              ),
            ),
          ),
          // Container(
          //   decoration: BoxDecoration(
          //     color: Colors.white,
          //     borderRadius: BorderRadius.circular(20),
          //   ),
          //   height: media.width * 0.8,
          //   width: media.width,
          //   child: CupertinoTheme(
          //     data: CupertinoThemeData(
          //       textTheme: CupertinoTextThemeData(
          //         dateTimePickerTextStyle: TextStyle(
          //           fontSize: media.width * 0.07,
          //         ),
          //       ),
          //     ),
          //     child: CupertinoDatePicker(
          //       initialDateTime: _dateTime,
          //       onDateTimeChanged: (dateTime) {
          //         setState(() {
          //           _dateTime = dateTime;
          //         });
          //       },
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}

// class DatePage extends StatefulWidget {
//    static const routeName ='DatePage';
//   @override
//   _DatePageState createState() => _DatePageState();
// }

// class _DatePageState extends State<DatePage> {
//   @override
//   Widget build(BuildContext context) {
//     //final primaryColor = Color(0xffF26722);
//     final backgroundColor = Color(0xff241C24);
//     DateTime _dateTime = DateTime.now();

//     return Scaffold(
//       appBar: AppBar(elevation:0),
//       backgroundColor: backgroundColor,
//       body: Stack(
//         children: <Widget>[
//           Container(
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(10)
//             ),
//             width: MediaQuery.of(context).size.width,
//             alignment: Alignment.center,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 Meal(),
//                 SizedBox(height: 20),
//                 Container(
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   height: 200,
//                   width: pageWidthPresentation,
//                   child: CupertinoTheme(
//                     data: CupertinoThemeData(
//                         textTheme: CupertinoTextThemeData(
//                             dateTimePickerTextStyle: TextStyle(
//                                 fontSize: 50,
//                             ),
//                         ),
//                     ),
//                     child: CupertinoDatePicker(
//                       initialDateTime: _dateTime,
//                       onDateTimeChanged: (dateTime) {
//                         setState(() {
//                           _dateTime = dateTime;
//                         });
//                       },
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 20),
//                 InputText(text: 'What time is your meal?'),
//               ],
//             ),
//           ),
//           // Positioned(
//           //   top: 0,
//           //   bottom: 0,
//           //   right: 0,
//           //   left: pageWidthPresentation+50,
//           //   child: IconAdd(
//           //     primaryColor: primaryColor,
//           //     onTap: () {
//           //       Navigator.pushNamedAndRemoveUntil(context, HomePage.routeName, (Route routes) => false);
//           //     },
//           //   ),
//           // ),
//         ]
//       ),
//     );
//   }
// }
