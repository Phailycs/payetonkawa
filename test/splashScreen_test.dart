import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lottie/lottie.dart';
import 'package:mockito/mockito.dart';
import 'package:payetonkawa/View/view_home.dart';
import 'package:payetonkawa/splashScreen.dart';


void main() {
  testWidgets('Splash screen is removed from widget tree after timer runs out', (tester) async {
    await tester.pumpWidget(MaterialApp(home: SplashScreen()));

    // Wait for the timer to run out
    await tester.pump(Duration(seconds: 4));

    // Check if the SplashScreen widget is still in the widget tree
    expect(find.byType(SplashScreen), findsNothing);
  });
}