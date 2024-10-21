import 'package:flutter_test/flutter_test.dart';
import 'package:payetonkawa/Entities/productsEntity.dart';
import 'package:payetonkawa/View/view_ProductDetail.dart';

void main() {
  testWidgets('Product detail page displays correct information', (WidgetTester tester) async {
    // Create a ProductEntity object to pass to the widget
    final product = ProductEntity(
      id: '1',
      createdAt: '2023-05-08T00:00:00.000Z',
      name: 'Test product',
      details: ProduitDetails(
        price: '9.99',
        description: 'This is a test product',
        color: 'Blue',
      ),
      stock: 5,
    );

    // Build the widget and trigger a frame
    await tester.pumpWidget(ProductDetailPage(product: product));

    // Verify that the widget displays the correct information
    expect(find.text('Test product'), findsOneWidget);
    expect(find.text('This is a test product'), findsOneWidget);
    expect(find.text('Prix : 9.99'), findsOneWidget);
    expect(find.text('Couleur : Blue'), findsOneWidget);
    expect(find.text('En stock'), findsOneWidget);
    expect(find.text('Commander'), findsOneWidget);

    // Tap the "Commander" button and verify that it triggers the expected action
    await tester.tap(find.text('Commander'));
    await tester.pump();
    // TODO: Add code to verify the expected action
  });
}