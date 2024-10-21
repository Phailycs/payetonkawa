import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:payetonkawa/View/view_AugmentedReality.dart';
import 'package:payetonkawa/View/view_Product.dart';
import 'package:payetonkawa/View/view_Scanner.dart';

import 'package:payetonkawa/main.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.brown,
          fontFamily: 'Montserrat',
        ),
        home: WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            centerTitle: true,
            title: Ink.image(
              width: 150,
              height: 150, // adjust the height as needed
              fit: BoxFit.cover,
              image: const AssetImage('assets/splash.png'),
            ),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 200,
                  height: 240,
                  child: Card(
                    elevation: 6,
                    color: Colors.amber.shade100,
                    semanticContainer: true,
                    // Implement InkResponse
                    child: InkResponse(
                      containedInkWell: true,
                      highlightShape: BoxShape.rectangle,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProductListView()),
                        );
                      },
                      // Add image & text
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.all(20.0),
                            child: Ink.image(
                                width: 100,
                                height: 100,
                                fit: BoxFit.contain,
                                image: const AssetImage('assets/coffee.png')),
                          ),
                          const Text(
                            'Produits',
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 10)
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 60),
                ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    'Commandes',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.amber.shade100,
                    onPrimary: Colors.brown,
                    elevation: 10,
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 30),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
        ));
  }
}
