import 'package:http/http.dart' as http;
import 'option_model.dart';
import 'dart:convert';

Future<List<Option>> getQuestionsListJovens() async {
  final url = Uri.parse(
      'https://iamincontrol-abde7-default-rtdb.firebaseio.com/lists/list_jovens/questions.json');

  return http.get(url).then((response) {
    var data = json.decode(response.body) as Map<String, dynamic>;
    List<Option> newQuestions = [];

    data.forEach((key, value) {
      var newQuestion = Option(
        id: key.toString(),
        title: value['title'],
        options: Map.castFrom(value['options']),
      );

      newQuestions.add(newQuestion);
    });

    return newQuestions;
  });
}

Future<List<Option>> getQuestionsListAdultos() async {
  final url = Uri.parse(
      'https://iamincontrol-abde7-default-rtdb.firebaseio.com/lists/list_adultos/questions.json');

  return http.get(url).then((response) {
    var data = json.decode(response.body) as Map<String, dynamic>;
    List<Option> newQuestions = [];

    data.forEach((key, value) {
      var newQuestion = Option(
        id: key.toString(),
        title: value['title'],
        options: Map.castFrom(value['options']),
      );

      newQuestions.add(newQuestion);
    });

    return newQuestions;
  });
}

Future<List<Option>> getQuestionsListAutoCuidado() async {
  final url = Uri.parse(
      'https://iamincontrol-abde7-default-rtdb.firebaseio.com/lists/list_auto_cuidado/questions.json');

  return http.get(url).then((response) {
    var data = json.decode(response.body) as Map<String, dynamic>;
    List<Option> newQuestions = [];

    data.forEach((key, value) {
      var newQuestion = Option(
        id: key.toString(),
        title: value['title'],
        options: Map.castFrom(value['options']),
      );

      newQuestions.add(newQuestion);
    });

    return newQuestions;
  });
}

Future<List<Option>> getQuestionsListResiliencia() async {
  final url = Uri.parse(
      'https://iamincontrol-abde7-default-rtdb.firebaseio.com/lists/list_resiliencia/questions.json');

  return http.get(url).then((response) {
    var data = json.decode(response.body) as Map<String, dynamic>;
    List<Option> newQuestions = [];

    data.forEach((key, value) {
      var newQuestion = Option(
        id: key.toString(),
        title: value['title'],
        options: Map.castFrom(value['options']),
      );

      newQuestions.add(newQuestion);
    });

    return newQuestions;
  });
}
