import 'package:flowery_tracking/core/helpers/regex.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppRegExp', () {
    test('isNameValid', () {
      expect(AppRegExp.isNameValid('A'), isFalse);
      expect(AppRegExp.isNameValid('Ab'), isTrue);
      expect(AppRegExp.isNameValid('John'), isTrue);
      expect(AppRegExp.isNameValid('John3'), isFalse);
    });

    test('isEmailValid', () {
      expect(AppRegExp.isEmailValid('a@b.com'), isTrue);
      expect(AppRegExp.isEmailValid('user.name@domain.co'), isTrue);
      expect(AppRegExp.isEmailValid('bad'), isFalse);
      expect(AppRegExp.isEmailValid('a@b'), isFalse);
    });

    test('isPhoneNumberValid (EG +20 patterns)', () {
      expect(AppRegExp.isPhoneNumberValid('+201001234567'), isTrue);
      expect(AppRegExp.isPhoneNumberValid('201001234567'), isTrue);
      expect(AppRegExp.isPhoneNumberValid('01001234567'), isTrue);
      expect(AppRegExp.isPhoneNumberValid('01101234567'), isTrue);
      expect(AppRegExp.isPhoneNumberValid('01201234567'), isTrue);
      expect(AppRegExp.isPhoneNumberValid('01501234567'), isTrue);
      expect(AppRegExp.isPhoneNumberValid('12345'), isFalse);
      expect(AppRegExp.isPhoneNumberValid('01901234567'), isFalse);
    });

    test('isOTPValid', () {
      expect(AppRegExp.isOTPValid('123456'), isTrue);
      expect(AppRegExp.isOTPValid('12345'), isFalse);
      expect(AppRegExp.isOTPValid('1234567'), isFalse);
      expect(AppRegExp.isOTPValid('12a456'), isFalse);
    });

    test('isPasswordValid', () {
      expect(AppRegExp.isPasswordValid('Short1#'), isFalse);
      expect(AppRegExp.isPasswordValid('NoSpecial123'), isFalse);
      expect(AppRegExp.isPasswordValid('noupper#1'), isFalse);
      expect(AppRegExp.isPasswordValid('NOLOWER#1'), isFalse);
      expect(AppRegExp.isPasswordValid('Valid#123'), isTrue);
    });
  });
}
