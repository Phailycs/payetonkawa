import 'dart:convert';
import 'package:http/http.dart' as http;

import '../Entities/productsEntity.dart';

class GetProductList {
  String baseUrl = "";
  String username = "";
  String password = "";

  Future<List<ProductEntity>> fetchApiData() async {
    final response = await http.get(
      Uri.parse("https://api-3rclymj4y-mrbalraf751.vercel.app/api/products"),
      // headers: {
      //   'Authorization':
      //       'Basic ' + base64Encode(utf8.encode('$username:$password')),
      // })
    );

    if (response.statusCode == 200) {
      // Traitement des données récupérées
      print(response.body);
      final List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((json) => ProductEntity.fromJson(json)).toList();
    } else {
      // Gestion des erreurs
      throw Exception('Failed to load products');
    }
  }
}
