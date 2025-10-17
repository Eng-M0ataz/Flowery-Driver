import 'package:flowery_tracking/core/functions/validators.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Validations', () {
    test('validateName', () {
      expect(Validations.validateName(''), 'Name is required!');
      expect(Validations.validateName('a'), 'This Name is not valid');
      expect(Validations.validateName('John'), null);
    });

    test('validateEmail', () {
      expect(Validations.validateEmail(''), 'Email is required!');
      expect(Validations.validateEmail('bad'), 'This Email is not valid');
      expect(Validations.validateEmail('a@b.com'), null);
    });

    test('validatePassword', () {
      expect(Validations.validatePassword(''), 'Password is required!');
      expect(
        Validations.validatePassword('weak'),
        'This Password is not valid',
      );
      expect(Validations.validatePassword('Strong#1'), null);
    });

    test('validateConfirmPassword', () {
      expect(
        Validations.validateConfirmPassword('Strong#1', ''),
        'Confirm Password is required!',
      );
      expect(
        Validations.validateConfirmPassword('Strong#1', 'weak'),
        'This Confirm Password is not valid',
      );
      expect(
        Validations.validateConfirmPassword('Strong#1', 'Strong#2'),
        'Password and Confirm Password must be same!',
      );
      expect(Validations.validateConfirmPassword('Strong#1', 'Strong#1'), null);
    });

    test('validatePhoneNumber', () {
      expect(Validations.validatePhoneNumber(''), 'Phone number is required!');
      expect(
        Validations.validatePhoneNumber('12345'),
        'This Phone number is not valid',
      );
      expect(Validations.validatePhoneNumber('+201001234567'), null);
    });

    test('validateAddress', () {
      expect(Validations.validateAddress(null), 'Address is required!');
      expect(Validations.validateAddress('   '), 'Address is required!');
      expect(Validations.validateAddress('1234'), 'Address is too short');
      expect(Validations.validateAddress('a' * 101), 'Address is too long');
      expect(Validations.validateAddress('12345 Main St'), null);
    });

    test('validateCity', () {
      expect(Validations.validateCity(null), 'Please select a city');
      expect(Validations.validateCity('   '), 'Please select a city');
      expect(Validations.validateCity('Cairo'), null);
    });

    test('pinCodeValidator', () {
      expect(Validations.pinCodeValidator('12345'), 'Please enter all digits');
      expect(Validations.pinCodeValidator('123456'), null);
    });

    test('validateRecipientName', () {
      expect(
        Validations.validateRecipientName('   '),
        'Recipient name is required!',
      );
      expect(
        Validations.validateRecipientName('Single'),
        'Please enter full name (first and last name)',
      );
      expect(
        Validations.validateRecipientName('John 123'),
        'Name can only contain letters',
      );
      expect(Validations.validateRecipientName('John Doe'), null);
    });
  });
}
