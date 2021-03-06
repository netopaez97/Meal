import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meal/utils/utils.dart';

class Meal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    return Container(
      height: media.width * 0.2,
      width: media.width * 0.8,
      child: FittedBox(
        fit: BoxFit.fill,
        child: Text(
          'meal',
          style: TextStyle(
            color: orangeColors,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class InputPhone extends StatelessWidget {
  final onChanged;
  final String initialValue;

  const InputPhone({
    @required this.onChanged,
    this.initialValue = '',
  });

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    return Container(
      width: media.width * 0.8,
      height: media.width * 0.14,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: TextFormField(
          initialValue: initialValue,
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(border: InputBorder.none),
          cursorColor: orangeColors,
          cursorWidth: 1.0,
          style: TextStyle(
            color: blackColors,
            fontSize: media.width * 0.07,
          ),
          onChanged: onChanged,
          validator: (value) {
            if (value != null && value != '') {
              if (double.tryParse(value) == null) {
                return 'Solo numeros';
              } else {
                return null;
              }
            } else {
              return null;
            }
          },
        ),
      ),
    );
  }
}

class InputText extends StatelessWidget {
  final String text;
  final double scale;
  const InputText({
    @required this.text,
    this.scale = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.normal,
        ),
        textScaleFactor: scale,
      ),
    );
  }
}

class IconAdd extends StatelessWidget {
  final onPressed;
  const IconAdd({
    @required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    return CupertinoButton(
      padding: EdgeInsets.zero,
      child: Column(
        children: <Widget>[
          Icon(Icons.add, size: media.width * 0.14, color: orangeColor),
          Text(
            "Add guest",
            style: TextStyle(color: Colors.white),
            textScaleFactor: media.width * 0.002,
          )
        ],
      ),
      onPressed: onPressed,
    );
  }
}
