import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List<dynamic>> fetchQuestions() async {
  final response = await http.get(Uri.parse('http://localhost:3003/questions'));

  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception('Failed to load questions');
  }
}
