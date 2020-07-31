import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meal/models/survey_model.dart';

class SurveyProvider {

  CollectionReference _dbAdmin = Firestore.instance.collection("surveys");

  Stream<QuerySnapshot> getSurvey() {
    return  _dbAdmin.snapshots();
  }

  Future updateQuestions(List<SurveyModel> _survey, List<int> _answers) async {

    for(int question = 0; question<_survey.length;question++){
      if(_answers[question] == 1)
        _survey[question].answer1++;
      else if(_answers[question] == 2)
        _survey[question].answer2++;
      else if(_answers[question] == 3)
        _survey[question].answer3++;
      else if(_answers[question] == 4)
        _survey[question].answer4++;
      else if(_answers[question] == 5)
        _survey[question].answer5++;
      _survey[question].totalResponses++;
      await _dbAdmin.document(_survey[question].idQuestion).setData(
        _survey[question].toJson()
      );
    }
  }
  
}