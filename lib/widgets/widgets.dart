import 'package:flutter/material.dart';

class Meal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      'meal',
      style: TextStyle(
          color: Color(0xffF26722),
          fontWeight: FontWeight.bold,
          fontSize: 100.0,
          height: 0.5),
    );
  }
}

class Input extends StatelessWidget {
  const Input({
    @required this.typeInput,
    @required this.primaryColor,
    @required this.backgroundColor,
  });

  final TextInputType typeInput;
  final Color primaryColor;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      width: 210,
      child: TextField(
        textAlign: TextAlign.center,
        keyboardType: typeInput,
        decoration: InputDecoration(border: InputBorder.none),
        cursorColor: primaryColor,
        cursorWidth: 1.0,
        style: TextStyle(
          color: backgroundColor,
          fontSize: 23,
        ),
      ),
    );
  }
}

class InputText extends StatelessWidget {
  const InputText({
    @required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.normal,
        fontSize: 23,
      ),
    );
  }
}

class IconAdd extends StatelessWidget {
  const IconAdd({
    @required this.onTap,
    @required this.primaryColor,
  });

  final Null Function() onTap;
  final Color primaryColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Icon(
        Icons.add,
        color: primaryColor,
        size: 50,
      ),
    );
  }
}

class TextAdd extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      'add guest',
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.normal,
        fontSize: 15,
      ),
    );
  }
}
