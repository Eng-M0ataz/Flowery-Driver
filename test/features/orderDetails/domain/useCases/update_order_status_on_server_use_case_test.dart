import 'package:flowery_tracking/core/errors/api_results.dart';
import 'package:flowery_tracking/features/orderDetails/api/models/request/update_order_status_with_server_model.dart';
import 'package:flowery_tracking/features/orderDetails/domain/repositories/order_details_repo.dart';
import 'package:flowery_tracking/features/orderDetails/domain/useCases/update_order_status_on_server_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateMocks([OrderDetailsRepo])
import 'update_order_status_on_server_use_case_test.mocks.dart';

void main() {
  setUpAll(() {
    provideDummy<ApiResult<void>>(ApiSuccessResult<void>(data: null));
  });

  late MockOrderDetailsRepo mockRepo;
  late UpdateOrderStatusOnServerUseCase useCase;

  setUp(() {
    mockRepo = MockOrderDetailsRepo();
    useCase = UpdateOrderStatusOnServerUseCase(mockRepo);
  });

  test(
    'invokes repo.updateOrderStatusOnServer and returns its result',
    () async {
      const path = 'orders/2';
      const model = UpdateOrderStatusWithServerModel(
        status: 'arrived',
        statusUpdatedDate: 'now',
      );

      when(
        mockRepo.updateOrderStatusOnServer(
          path: anyNamed('path'),
          updateOrderStatusModel: anyNamed('updateOrderStatusModel'),
        ),
      ).thenAnswer((_) async => ApiSuccessResult<void>(data: null));

      final result = await useCase.invoke(
        path: path,
        updateOrderStatusModel: model,
      );

      expect(result, isA<ApiSuccessResult<void>>());
      verify(
        mockRepo.updateOrderStatusOnServer(
          path: path,
          updateOrderStatusModel: model,
        ),
      ).called(1);
    },
  );
}
