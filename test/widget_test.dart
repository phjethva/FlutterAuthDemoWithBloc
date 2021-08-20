import 'package:flutter_auth_demo_with_bloc/myapp.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Flutter Auth Demo With BLOC Test', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());
  });
}
