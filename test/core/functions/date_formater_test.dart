import 'package:flowery_tracking/core/functions/date_formater.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('formats date with given pattern', () {
    final date = DateTime(2025, 10, 16, 14, 30);
    final result = formatDate(date: date, format: 'yyyy-MM-dd HH:mm');
    expect(result, '2025-10-16 14:30');
  });
}
