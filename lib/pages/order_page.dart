import 'package:flutter/material.dart';
import 'package:meal/utils/utils.dart';

class OrderPage extends StatefulWidget {
  @override
  _OrderState createState() => _OrderState();
}

class _OrderState extends State<OrderPage> {
  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: media.width * 0.4),
      child: AlertDialog(
        contentPadding: EdgeInsets.symmetric(
          vertical: media.width * 0.1,
          horizontal: media.width * 0.05,
        ),
        elevation: 20,
        backgroundColor: blackColors,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        content: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: Text(
                'Order',
                style: TextStyle(
                  color: orangeColors,
                  fontSize: media.width * 0.08,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 5),
            TextField(
              textAlign: TextAlign.center,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'contactNumber',
                hintStyle: TextStyle(
                  color: blackColors.withOpacity(0.5),
                  fontSize: media.width * 0.06,
                ),
              ),
              cursorColor: orangeColors,
              cursorWidth: 1.0,
              style: TextStyle(
                color: blackColors,
                fontSize: media.width * 0.07,
              ),
              onChanged: (value) => {},
            ),
            SizedBox(height: 5),
            TextField(
              textAlign: TextAlign.center,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'typeDelivery',
                hintStyle: TextStyle(
                  color: blackColors.withOpacity(0.5),
                  fontSize: media.width * 0.06,
                ),
              ),
              cursorColor: orangeColors,
              cursorWidth: 1.0,
              style: TextStyle(
                color: blackColors,
                fontSize: media.width * 0.07,
              ),
              onChanged: (value) => {},
            ),
          ],
        ),
        actions: <Widget>[
          FlatButton(
            child: Text(
              "Cancel",
              style: TextStyle(color: orangeColors, fontSize: 12),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          FlatButton(
            child: Text(
              "Ok",
              style: TextStyle(color: orangeColors, fontSize: 12),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
