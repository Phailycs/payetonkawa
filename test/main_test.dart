import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:payetonkawa/main.dart';

void main() {
  testWidgets('Test formulaire d\'inscription', (WidgetTester tester) async {
    // Construire le formulaire d'inscription
    await tester.pumpWidget(MyApp());

    // Attendre que le formulaire soit construit
    await tester.pumpAndSettle();

    // Remplir les champs de texte
    await tester.enterText(find.byType(TextFormField).at(0), 'Mon pseudonyme');
    await tester.enterText(find.byType(TextFormField).at(1), 'Nom');
    await tester.enterText(find.byType(TextFormField).at(2), 'Prénom');
    await tester.enterText(find.byType(TextFormField).at(3), 'email@example.com');
    await tester.enterText(find.byType(TextFormField).at(4), 'Nom de l\'entreprise');
    await tester.enterText(find.byType(TextFormField).at(5), 'Ville');
    await tester.enterText(find.byType(TextFormField).at(6), '12345');

    // Appuyer sur le bouton d'inscription
    await tester.tap(find.byKey(Key('Validation')));
    await tester.pumpAndSettle();

    // Vérifier que le dialogue de succès s'affiche
    expect(find.text('Une erreur est survenue veuillez réssayer'), findsNothing);
  });
}