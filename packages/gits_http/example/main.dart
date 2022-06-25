// ignore_for_file: avoid_print

import 'package:gits_http/gits_http.dart';

void main(List<String> args) async {
  final http = GitsHttp();

  try {
    final response = await http.post(
      Uri.parse('https://reqres.in/api/login'),
      body: {"email": "eve.holt@reqres.in", "password": "cityslicka"},
    );
    print(response.body);
  } on GitsException catch (e) {
    final failure = e.toGitsFailure();
    print(failure.toString());
  } catch (e) {
    print(e.toString());
  }
}
