import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:payetonkawa/Controller/post_Login.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  test('returns true if response is 200', () async {
    final client = MockClient();
    final postLogin = postLoginCrm();
    postLogin.client = client;

    final jsonString = {
      "username": "ouinonoui",
      "firstName": "oui",
      "lastName": "non",
      "email": "tristan.eiche@epsi.fr",
      "companyName": "leouiouinonon",
      "id": 0,
      "address": {"postalCode": 33000, "city": "Bordeaux "}
    };
    final url = Uri.parse(
        'https://api-cmx2u6eqa-mrbalraf751.vercel.app/api/createCustomer');
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode(jsonString);

    when(client.post(
      url,
      headers: headers,
      body: body,
      encoding: anyNamed('encoding'), // ajouter cette ligne
    )).thenAnswer((_) async => http.Response('{"status": "success"}', 200));

    final result = await postLogin.postLogin(jsonString);

    expect(result, equals(true));
  });
}
