import 'package:flutter_test/flutter_test.dart';
import 'package:payetonkawa/View/view_home.dart';

void main() {
  testWidgets('HomePage widget test', (WidgetTester tester) async {
    await tester.pumpWidget(HomePage());
    await tester.pumpAndSettle();
    expect(find.text('Produits'), findsOneWidget);
    expect(find.text('Commandes'), findsOneWidget);
  });
}