import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ar_flutter_plugin/widgets/ar_view.dart';
import 'package:payetonkawa/View/view_AugmentedReality.dart';

void main() {
  testWidgets('AugmentedRealityView contains ARView', (WidgetTester tester) async {
    await tester.pumpWidget(const AugmentedRealityView());
    expect(find.byType(ARView), findsOneWidget);
  });
}
