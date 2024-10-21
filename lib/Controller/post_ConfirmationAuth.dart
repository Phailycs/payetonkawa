import 'dart:convert';
import 'package:http/http.dart' as http;

class postConfirmationAuthCrm {
  Future<String> confirmationAuth(String? token, String email) async {
    final url = Uri.parse(
        'https://api-cmx2u6eqa-mrbalraf751.vercel.app/api/authConfirmation');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    final body = jsonEncode({'email': email});

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      print('Requête réussie, réponse : ${response.body}');

      return "true";
    } else if (response.statusCode == 201) {
      print('Nouveau token requis');
      return response.body;
    } else {
      print('Requête échouée avec le code d\'erreur ${response.statusCode}');
      return "false";
    }
  }
}
