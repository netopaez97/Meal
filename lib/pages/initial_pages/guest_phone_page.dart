import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meal/providers/guest_provider.dart';
import 'package:meal/routes/routes.dart';
import 'package:meal/utils/utils.dart';
import 'package:meal/widgets/widgets.dart';
import 'package:provider/provider.dart';

class GuestPage extends StatelessWidget {
  static const routeName = 'GuestPage';
  @override
  Widget build(BuildContext context) {
    final guestProvider = Provider.of<GuestProvider>(context);
    final media = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(elevation: 0),
      backgroundColor: blackColors,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: media.width * 0.5),
            Meal(),
            SizedBox(height: 5),
            Input(
              typeInput: TextInputType.number,
              onChanged: (value) => guestProvider.phone = int.parse(value),
            ),
            SizedBox(height: 5),
            InputText(
              text: "Your guest's phone?",
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
                guestProvider.guestCount++;
                print(guestProvider.phone);
                guestProvider.setGuests(guestProvider.phone);
                print(guestProvider.guests);
                Navigator.pushNamed(context, Routes.selection);
              },
            ),
          ],
        ),
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
