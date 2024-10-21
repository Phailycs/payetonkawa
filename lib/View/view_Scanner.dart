import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Controller/post_ConfirmationAuth.dart';
import './view_home.dart';

class QRScanPage extends StatefulWidget {
  final String emailUser;

  const QRScanPage({Key? key, required this.emailUser}) : super(key: key);

  @override
  ScannerPageState createState() => ScannerPageState();
}

class ScannerPageState extends State<QRScanPage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;

  bool flashOn = false;

  void _onFlashOn() {
    controller?.toggleFlash();
    setState(() {
      flashOn = !flashOn;
    });
  }

  var emailUser;
  var tokenAuth;
  var emailUserVerif;
  var tokenAuthVerif;

  void _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      emailUserVerif = prefs.getString('emailUser') ?? '';
      tokenAuth = prefs.getString('tokenAuth') ?? '';
    });
  }

  void _saveEmail(String emailUser) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('emailUser', emailUser);
  }

  void _saveTokenData(String tokenAuth) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('tokenAuth', tokenAuth);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scanner un QR code'),
      ),
      body: Stack(
        children: <Widget>[
          QRView(
            key: qrKey,
            onQRViewCreated: (QRViewController controller) {
              this.controller = controller;
              controller.scannedDataStream.listen((scanData) async {
                setState(() {
                  result = scanData;
                });

                emailUser = widget.emailUser;
                tokenAuth = result?.code;
                _loadData();

                if (emailUserVerif == '') {
                  _saveEmail(emailUser);
                }
                if (tokenAuthVerif == '') {
                  _saveTokenData(tokenAuth);
                }

                if (result?.code != null) {
                  final confAuth = postConfirmationAuthCrm();
                  String verifAuth =
                      await confAuth.confirmationAuth(result?.code, emailUser);

                  if (verifAuth != "true" && verifAuth != "false") {
                    _saveTokenData(verifAuth);
                  }

                  if (verifAuth == "true") {
                    Route route =
                        MaterialPageRoute(builder: (context) => HomePage());
                    Navigator.pushReplacement(context, route);
                  } else {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text(
                              'Le QR CODE est invalide, veuillez réessayer'),
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
                        title: const Text(
                            'Un problème est survenu, veuillez réessayer'),
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
              });},
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.all(20.0),
              color: Colors.black.withOpacity(0.5),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Un QR code vous a été transmis par mail scannez-le pour vous connecter !',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Flash :',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: _onFlashOn,
                        child: Text(flashOn ? 'ON' : 'OFF'),
                        style: ElevatedButton.styleFrom(
                          primary: flashOn ? Colors.green : Colors.red,
                          textStyle: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}

class QRResultPage extends StatelessWidget {
  final String qrResult;

  QRResultPage(this.qrResult);

  @override
  Widget build(BuildContext context) {
    print(qrResult);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Résultat QR code'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Résultat :',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            Text(
              qrResult,
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
