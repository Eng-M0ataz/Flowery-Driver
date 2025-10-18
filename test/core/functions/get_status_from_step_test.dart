import 'package:flowery_tracking/core/enum/order_status.dart';
import 'package:flowery_tracking/core/functions/get_status_from_step.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('maps steps 0..4 to correct OrderStatus', () {
    expect(getStatusFromStep(0), OrderStatus.accepted);
    expect(getStatusFromStep(1), OrderStatus.picked);
    expect(getStatusFromStep(2), OrderStatus.outfordelivery);
    expect(getStatusFromStep(3), OrderStatus.arrived);
    expect(getStatusFromStep(4), OrderStatus.delivered);
  });

  test('default returns accepted for unknown steps', () {
    expect(getStatusFromStep(-1), OrderStatus.accepted);
    expect(getStatusFromStep(99), OrderStatus.accepted);
  });
}
