import 'package:flowery_tracking/core/functions/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('shows snackbar with AwesomeSnackbarContent', (tester) async {
    late BuildContext captured;
    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (context) {
            captured = context;
            return const Scaffold(body: SizedBox.shrink());
          },
        ),
      ),
    );

    showSnackBar(context: captured, title: 'Title', message: 'Message');

    await tester.pump();
    expect(find.byType(SnackBar), findsOneWidget);
  });
}
