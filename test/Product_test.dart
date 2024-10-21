import 'package:flutter_test/flutter_test.dart';
import 'package:payetonkawa/Entities/productsEntity.dart';

void main() {
  test('ProductEntity should parse JSON data correctly', () {
    final json = {
      'id': '1',
      'createdAt': '2022-05-09T12:00:00Z',
      'name': 'Product 1',
      'details': {
        'price': '10.00',
        'description': 'A product',
        'color': 'red',
      },
      'stock': 5,
    };

    final product = ProductEntity.fromJson(json);

    expect(product.id, '1');
    expect(product.createdAt, '2022-05-09T12:00:00Z');
    expect(product.name, 'Product 1');
    expect(product.details.price, '10.00');
    expect(product.details.description, 'A product');
    expect(product.details.color, 'red');
    expect(product.stock, 5);
  });
}