import 'package:flowery_tracking/core/errors/api_results.dart';
import 'package:flowery_tracking/features/orderDetails/domain/repositories/order_details_repo.dart';
import 'package:flowery_tracking/features/orderDetails/domain/useCases/delete_order_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateMocks([OrderDetailsRepo])
import 'delete_order_use_case_test.mocks.dart';

void main() {
  setUpAll(() {
    provideDummy<ApiResult<void>>(ApiSuccessResult<void>(data: null));
  });

  late MockOrderDetailsRepo mockRepo;
  late DeleteOrderUseCase useCase;

  setUp(() {
    mockRepo = MockOrderDetailsRepo();
    useCase = DeleteOrderUseCase(mockRepo);
  });

  test('invokes repo.deleteOrder and returns its result', () async {
    const path = 'orders/1';
    when(
      mockRepo.deleteOrder(path: anyNamed('path')),
    ).thenAnswer((_) async => ApiSuccessResult<void>(data: null));

    final result = await useCase.invoke(path: path);

    expect(result, isA<ApiSuccessResult<void>>());
    verify(mockRepo.deleteOrder(path: path)).called(1);
  });
}
