import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:payetonkawa/View/view_Scanner.dart';
import 'package:payetonkawa/splashScreen.dart';
import 'package:payetonkawa/Controller/post_Login.dart';
import 'package:payetonkawa/View/view_home.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Controller/post_ConfirmationAuth.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'PayeTonKawa',
        theme: ThemeData(
          primarySwatch: Colors.brown,
          fontFamily: 'Montserrat',
        ),
        initialRoute: '/',
        routes: {'/': (context) => SplashScreen()});
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.title});
  final String title;

  @override
  State<LoginPage> createState() => _LoginPagestate();
}

class _LoginPagestate extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _nomController = TextEditingController();
  final _prenomController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController();
  final _cpController = TextEditingController();
  final _companynameController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _nomController.dispose();
    _prenomController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _cpController.dispose();
    _companynameController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _loadData();
    if (tokenAuth != null) {
      Route route = MaterialPageRoute(builder: (context) => HomePage());
      Navigator.pushReplacement(context, route);
    }
  }

  var tokenAuth;

  void _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      tokenAuth = prefs.getString('tokenAuth') ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Paye ton kawa'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: _usernameController,
                  decoration: const InputDecoration(
                    labelText: 'Pseudonyme',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _nomController,
                  decoration: const InputDecoration(
                    labelText: 'Nom',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _prenomController,
                  decoration: const InputDecoration(
                    labelText: 'Prénom',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _companynameController,
                  decoration: const InputDecoration(
                    labelText: 'Nom de l\'entreprise',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _addressController,
                  decoration: const InputDecoration(
                    labelText: 'Ville',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _cpController,
                  decoration: const InputDecoration(
                    labelText: 'Code postal',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  key: Key('Validation'),
                  onPressed: () async {
                    // Récupérer les valeurs saisies
                    final username = _usernameController.text;
                    final nom = _nomController.text;
                    final prenom = _prenomController.text;
                    final email = _emailController.text;
                    final adresse = _addressController.text;
                    final cp = int.tryParse(_cpController.text) ?? 0;
                    final companyName = _companynameController.text;

                    bool checkFields(username, nom, prenom, email, adresse, cp,
                        companyName) {
                      return username.isNotEmpty &&
                          nom.isNotEmpty &&
                          prenom.isNotEmpty &&
                          email.isNotEmpty &&
                          adresse.isNotEmpty &&
                          cp != 0 &&
                          companyName.isNotEmpty;
                    }

                    if (checkFields(username, nom, prenom, email, adresse, cp,
                        companyName)) {
                      final user = User(
                        username: username,
                        firstName: nom,
                        lastName: prenom,
                        email: email,
                        companyName: companyName,
                        id: 0,
                        address: Address(postalCode: cp, city: adresse),
                      );

                      final jsonString = jsonEncode(user.toJson());

                      final LoginCrm = postLoginCrm();
                      bool confirmation = await LoginCrm.postLogin(jsonString);

                      if (confirmation) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => QRScanPage(emailUser: email),
                          ),
                        );
                      } else {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text(
                                  'Une erreur est survenue veuillez réssayer'),
                              actions: <Widget>[
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('Fermer'),
                                ),
                              ],
                            );
                          },
                        );
                      }
                    } else {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Champs invalides ou manquants'),
                            actions: <Widget>[
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Fermer'),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                  child: const Text('Créer'),
                ),
                const SizedBox(width: 16.0),
                ElevatedButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomePage(),
                    ),
                  ),
                  child: const Text('Annuler'),
                ),
                const SizedBox(height: 16.0),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}

class User {
  final String username;
  final String firstName;
  final String lastName;
  final String email;
  final String companyName;
  final int id;
  final Address address;

  User({
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.companyName,
    required this.id,
    required this.address,
  });

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'companyName': companyName,
      'id': id,
      'address': address.toJson(),
    };
  }
}

class Address {
  final int postalCode;
  final String city;

  Address({
    required this.postalCode,
    required this.city,
  });

  Map<String, dynamic> toJson() {
    return {
      'postalCode': postalCode,
      'city': city,
    };
  }
}
