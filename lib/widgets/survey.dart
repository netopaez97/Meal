import 'package:flutter/material.dart';

class SurveyDialog extends StatefulWidget {
  @override
  _SurveyDialogState createState() => _SurveyDialogState();
}

class _SurveyDialogState extends State<SurveyDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: _dialogTitle(),
    );
  }

  Widget _dialogTitle(){
    return Text("Neto");
  }
}