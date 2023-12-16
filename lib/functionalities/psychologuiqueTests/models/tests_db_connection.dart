import 'package:http/http.dart' as http;
import './question_model.dart';
import 'dart:convert';

Future<List<Question>> getQuestionsPHQ9() async {
  final url = Uri.parse(
      'https://iamincontrol-abde7-default-rtdb.firebaseio.com/tests/test_phq_9/questions.json');

  return http.get(url).then((response) {
    var data = json.decode(response.body) as Map<String, dynamic>;
    List<Question> newQuestions = [];

    data.forEach((key, value) {
      var newQuestion = Question(
        id: key.toString(),
        title: value['title'],
        options: Map.castFrom(value['options']),
      );

      newQuestions.add(newQuestion);
    });

    return newQuestions;
  });
}

Future<List<Question>> getQuestionsGAD7() async {
  final url = Uri.parse(
      'https://iamincontrol-abde7-default-rtdb.firebaseio.com/tests/test_gad_7/questions.json');

  return http.get(url).then((response) {
    var data = json.decode(response.body) as Map<String, dynamic>;
    List<Question> newQuestions = [];

    data.forEach((key, value) {
      var newQuestion = Question(
        id: key.toString(),
        title: value['title'],
        options: Map.castFrom(value['options']),
      );

      newQuestions.add(newQuestion);
    });

    return newQuestions;
  });
}

Future<List<Question>> getQuestionsRosernbergScale() async {
  final url = Uri.parse(
      'https://iamincontrol-abde7-default-rtdb.firebaseio.com/tests/test_rosenberg_self-esteem_scale/questions.json');

  return http.get(url).then((response) {
    var data = json.decode(response.body) as Map<String, dynamic>;
    List<Question> newQuestions = [];

    data.forEach((key, value) {
      var newQuestion = Question(
        id: key.toString(),
        title: value['title'],
        options: Map.castFrom(value['options']),
      );

      newQuestions.add(newQuestion);
    });

    return newQuestions;
  });
}

Future<List<Question>> getQuestionsSCOFF() async {
  final url = Uri.parse(
      'https://iamincontrol-abde7-default-rtdb.firebaseio.com/tests/test_scoff_questionnaire/questions.json');

  return http.get(url).then((response) {
    var data = json.decode(response.body) as Map<String, dynamic>;
    List<Question> newQuestions = [];

    data.forEach((key, value) {
      var newQuestion = Question(
        id: key.toString(),
        title: value['title'],
        options: Map.castFrom(value['options']),
      );

      newQuestions.add(newQuestion);
    });

    return newQuestions;
  });
}
