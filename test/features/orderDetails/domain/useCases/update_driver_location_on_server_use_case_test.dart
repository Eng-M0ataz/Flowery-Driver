import 'package:flowery_tracking/core/errors/api_results.dart';
import 'package:flowery_tracking/features/orderDetails/api/models/request/location_request_model.dart';
import 'package:flowery_tracking/features/orderDetails/domain/repositories/order_details_repo.dart';
import 'package:flowery_tracking/features/orderDetails/domain/useCases/update_driver_location_on_server_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateMocks([OrderDetailsRepo])
import 'update_driver_location_on_server_use_case_test.mocks.dart';

void main() {
  setUpAll(() {
    provideDummy<ApiResult<void>>(ApiSuccessResult<void>(data: null));
  });

  late MockOrderDetailsRepo mockRepo;
  late UpdateDriverLocationOnServerUseCase useCase;

  setUp(() {
    mockRepo = MockOrderDetailsRepo();
    useCase = UpdateDriverLocationOnServerUseCase(mockRepo);
  });

  test(
    'invokes repo.updateDriverLocationOnServer and returns its result',
    () async {
      const path = 'drivers/1';
      const location = LocationRequestModel(lat: 10, long: 20);
      when(
        mockRepo.updateDriverLocationOnServer(
          locationRequestModel: anyNamed('locationRequestModel'),
          path: anyNamed('path'),
        ),
      ).thenAnswer((_) async => ApiSuccessResult<void>(data: null));

      final result = await useCase.invoke(
        path: path,
        locationRequestModel: location,
      );

      expect(result, isA<ApiSuccessResult<void>>());
      verify(
        mockRepo.updateDriverLocationOnServer(
          locationRequestModel: location,
          path: path,
        ),
      ).called(1);
    },
  );
}
