import 'dart:convert';
import 'package:http/http.dart' as http;

class postLoginCrm {
  late http.Client _client;

  set client(http.Client client) {
    _client = client;
  }

  Future<bool> postLogin(jsonString) async {
    final url = Uri.parse(
        'https://api-cmx2u6eqa-mrbalraf751.vercel.app/api/createCustomer');
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode(jsonString);
    print(body);

    final response = await _client.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      print('Requête réussie, réponse : ${response.body}');
      return true;
    } else {
      print('Requête échouée avec le code d\'erreur ${response.statusCode}');
      return false;
    }
  }
}
