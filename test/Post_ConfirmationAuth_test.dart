import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:payetonkawa/Controller/post_ConfirmationAuth.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Test confirmationAuth function', (WidgetTester tester) async {
    postConfirmationAuthCrm post = postConfirmationAuthCrm();
    String response = await post.confirmationAuth("token", "email");
    expect(response, equals("true"));
  });
}