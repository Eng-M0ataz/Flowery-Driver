import 'package:flowery_tracking/core/errors/api_results.dart';
import 'package:flowery_tracking/features/orderDetails/api/models/request/update_order_status_with_api_model.dart';
import 'package:flowery_tracking/features/orderDetails/domain/repositories/order_details_repo.dart';
import 'package:flowery_tracking/features/orderDetails/domain/useCases/update_order_status_with_api_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateMocks([OrderDetailsRepo])
import 'update_order_status_with_api_use_case_test.mocks.dart';

void main() {
  setUpAll(() {
    provideDummy<ApiResult<void>>(ApiSuccessResult<void>(data: null));
  });

  late MockOrderDetailsRepo mockRepo;
  late UpdateOrderStatusWithApiUseCase useCase;

  setUp(() {
    mockRepo = MockOrderDetailsRepo();
    useCase = UpdateOrderStatusWithApiUseCase(mockRepo);
  });

  test(
    'invokes repo.updateOrderStatusWithApi and returns its result',
    () async {
      const id = 'id-3';
      const model = UpdateOrderStatusWithApiModel(state: 'picked');

      when(
        mockRepo.updateOrderStatusWithApi(
          id: anyNamed('id'),
          UpdateOrderStatusWithApiModel: anyNamed(
            'UpdateOrderStatusWithApiModel',
          ),
        ),
      ).thenAnswer((_) async => ApiSuccessResult<void>(data: null));

      final result = await useCase.invoke(
        id: id,
        UpdateOrderStatusWithApiModel: model,
      );

      expect(result, isA<ApiSuccessResult<void>>());
      verify(
        mockRepo.updateOrderStatusWithApi(
          id: id,
          UpdateOrderStatusWithApiModel: model,
        ),
      ).called(1);
    },
  );
}
