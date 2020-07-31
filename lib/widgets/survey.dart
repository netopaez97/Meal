import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:meal/models/order_model.dart';
import 'package:meal/models/survey_model.dart';
import 'package:meal/providers/order_provider.dart';
import 'package:meal/providers/survey_provider.dart';

class SurveyDialog extends StatefulWidget {

  final OrderModel _order;
  SurveyDialog(this._order, {Key key}) : super(key:key);

  @override
  _SurveyDialogState createState() => _SurveyDialogState();
}

class _SurveyDialogState extends State<SurveyDialog> {

  SurveyProvider _surveyProvider = SurveyProvider();
  OrderProvider _orderProvider = OrderProvider();
  bool _loadingWidget = false;
  bool view = false;
  List<SurveyModel> _survey = [];
  List<int> _answers = [];
  bool _lockAnswers=false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      title: _dialogTitle(),
      content: _questions(),
      actions: _buttons(),
    );
  }

  Widget _dialogTitle(){
    return Text("Help us");
  }

  Widget _questions(){

    if(!view)
      return Text("Welcome to our survey.\nYour opinion is absolutely important for us and will help us to improve.\nHava a good meal!", style: TextStyle(fontSize: 20),);
    else
      return StreamBuilder<QuerySnapshot>(
        stream: _surveyProvider.getSurvey(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
          if(!snapshot.hasData)
            return Center(child: CircularProgressIndicator());
          if(snapshot.data == null)
            return Text("This functions has not been implemented.");
          if(_lockAnswers == false){
            _lockAnswers = true;
            snapshot.data.documents.forEach((question){
              _answers.add(0);
              _survey.add(SurveyModel.fromJson(question.data));
            });
          }
          print(_survey[0].toJson());

          return ListView.builder(

            itemCount: snapshot.data.documents.length,
            itemBuilder: (context,question){

              return Column(
                children: <Widget>[
                  ListTile(
                    title: Text(_survey[question].question),
                    subtitle: Column(
                      children:<Widget>[
                        _tileForAnswers(question, "Very Agree",5),
                        _tileForAnswers(question, "Agree",4),
                        _tileForAnswers(question, "Impartial",3),
                        _tileForAnswers(question, "Diasgree",2),
                        _tileForAnswers(question, "Very disagree", 1),
                      ]
                    ),
                  ),
                  Divider(),
                ],
              );
            },
          );
        },
      );
  }

  List<Widget> _buttons(){
    if(!view)
      return [
        FlatButton(
          child: Text("Next"),
          onPressed: (){
            setState(() {
              view=true;
            });
          },
        )
      ];
    else
      return [
        FlatButton(
          child: Text("Back"),
          onPressed: () async {
            setState(() {
              view=false;
            });
          },
        ),
        _loadingWidget == true
        ? CircularProgressIndicator()
        :FlatButton(
          child: Text("Send"),
          onPressed: () async {

            //Check if an answer has been selected
            bool _isValidToSend = true;
            _answers.forEach(
              (_ans){
                if(_ans==0)
                  _isValidToSend = false;
              }
            );

            if(_isValidToSend == false)
              return showDialog(context:context,builder: (BuildContext context)=>AlertDialog(title:Text("Please, answer the ${_answers.length} questions.")));

            
            setState(()=>_loadingWidget = true);

            //Don't allow user to vote twice or more.
            await _orderProvider.setOrderWithSurveyDone(widget._order);
            //Update the votes
            await _surveyProvider.updateQuestions(_survey, _answers);
            setState(() {
              view=true;
              _loadingWidget = false;
            });
            Navigator.pop(context);
          },
        )
      ];
  }

  Widget _tileForAnswers(int question, String _answerText, int answerNumber){
    return CheckboxListTile(
      value: _answers[question] == answerNumber ? true : false,
      onChanged: (val){
        if(_answers[question] == answerNumber)
          setState(()=>_answers[question] = 0);
        else
          setState(()=>_answers[question] = answerNumber);
        print(_answers);
      },
      title: Text(_answerText),
    );
  }
}