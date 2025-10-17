import 'package:flowery_tracking/core/functions/image_fixer.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('returns empty string when input is null or empty', () {
    expect(imageFixer(null), '');
    expect(imageFixer(''), '');
  });

  test('prefixes non-http paths with uploads base URL', () {
    expect(
      imageFixer('imgs/pic.png'),
      'https://flower.elevateegy.com/uploads/imgs/pic.png',
    );
  });

  test('returns original when already absolute http url', () {
    const url = 'http://example.com/a.png';
    expect(imageFixer(url), url);
  });
}
