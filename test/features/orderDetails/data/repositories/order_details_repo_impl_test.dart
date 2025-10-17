import 'package:flowery_tracking/core/errors/api_results.dart';
import 'package:flowery_tracking/core/errors/failure.dart';
import 'package:flowery_tracking/features/orderDetails/api/models/request/location_request_model.dart';
import 'package:flowery_tracking/features/orderDetails/api/models/request/update_order_status_with_api_model.dart';
import 'package:flowery_tracking/features/orderDetails/api/models/request/update_order_status_with_server_model.dart';
import 'package:flowery_tracking/features/orderDetails/data/dataSources/order_details_remote_data_source.dart';
import 'package:flowery_tracking/features/orderDetails/data/repositories/order_details_repo_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateMocks([OrderDetailsRemoteDataSource])
import 'order_details_repo_impl_test.mocks.dart';

void main() {
  setUpAll(() {
    provideDummy<ApiResult<void>>(ApiSuccessResult<void>(data: null));
  });

  late MockOrderDetailsRemoteDataSource mockRemote;
  late OrderDetailsRepoImpl repo;

  setUp(() {
    mockRemote = MockOrderDetailsRemoteDataSource();
    repo = OrderDetailsRepoImpl(mockRemote);
  });

  group('deleteOrder', () {
    test('delegates to remote and returns success', () async {
      const path = 'orders/123';
      when(
        mockRemote.deleteOrder(path: anyNamed('path')),
      ).thenAnswer((_) async => ApiSuccessResult<void>(data: null));

      final result = await repo.deleteOrder(path: path);

      expect(result, isA<ApiSuccessResult<void>>());
      verify(mockRemote.deleteOrder(path: path)).called(1);
    });

    test('delegates to remote and returns error', () async {
      const path = 'orders/err';
      when(mockRemote.deleteOrder(path: anyNamed('path'))).thenAnswer(
        (_) async => ApiErrorResult<void>(failure: Failure(errorMessage: 'x')),
      );

      final result = await repo.deleteOrder(path: path);

      expect(result, isA<ApiErrorResult<void>>());
      verify(mockRemote.deleteOrder(path: path)).called(1);
    });
  });

  group('updateDriverLocationOnServer', () {
    test('delegates to remote and returns success', () async {
      const path = 'drivers/1';
      const location = LocationRequestModel(lat: 1.0, long: 2.0);
      when(
        mockRemote.updateDriverLocationOnServer(
          locationRequestModel: anyNamed('locationRequestModel'),
          path: anyNamed('path'),
        ),
      ).thenAnswer((_) async => ApiSuccessResult<void>(data: null));

      final result = await repo.updateDriverLocationOnServer(
        locationRequestModel: location,
        path: path,
      );

      expect(result, isA<ApiSuccessResult<void>>());
      verify(
        mockRemote.updateDriverLocationOnServer(
          locationRequestModel: location,
          path: path,
        ),
      ).called(1);
    });
  });

  group('updateOrderStatusOnServer', () {
    test('delegates to remote and returns success', () async {
      const path = 'orders/456';
      const model = UpdateOrderStatusWithServerModel(
        status: 'arrived',
        statusUpdatedDate: '2025-10-16T10:00:00Z',
      );

      when(
        mockRemote.updateOrderStatusOnServer(
          path: anyNamed('path'),
          updateOrderStatusModel: anyNamed('updateOrderStatusModel'),
        ),
      ).thenAnswer((_) async => ApiSuccessResult<void>(data: null));

      final result = await repo.updateOrderStatusOnServer(
        path: path,
        updateOrderStatusModel: model,
      );

      expect(result, isA<ApiSuccessResult<void>>());
      verify(
        mockRemote.updateOrderStatusOnServer(
          path: path,
          updateOrderStatusModel: model,
        ),
      ).called(1);
    });
  });

  group('updateOrderStatusWithApi', () {
    test('delegates to remote and returns success', () async {
      const id = 'id-1';
      const model = UpdateOrderStatusWithApiModel(state: 'picked');
      when(
        mockRemote.updateOrderStatusWithApi(
          id: anyNamed('id'),
          UpdateOrderStatusWithApiModel: anyNamed(
            'UpdateOrderStatusWithApiModel',
          ),
        ),
      ).thenAnswer((_) async => ApiSuccessResult<void>(data: null));

      final result = await repo.updateOrderStatusWithApi(
        id: id,
        UpdateOrderStatusWithApiModel: model,
      );

      expect(result, isA<ApiSuccessResult<void>>());
      verify(
        mockRemote.updateOrderStatusWithApi(
          id: id,
          UpdateOrderStatusWithApiModel: model,
        ),
      ).called(1);
    });
  });
}
