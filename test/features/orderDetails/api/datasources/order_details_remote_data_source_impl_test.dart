import 'package:flowery_tracking/core/classes/remote_executor.dart';
import 'package:flowery_tracking/core/errors/api_results.dart';
import 'package:flowery_tracking/core/errors/failure.dart';
import 'package:flowery_tracking/core/services/real_time_database_service.dart';
import 'package:flowery_tracking/features/orderDetails/api/client/order_details_api_service.dart';
import 'package:flowery_tracking/features/orderDetails/api/datasources/order_details_remote_data_source_impl.dart';
import 'package:flowery_tracking/features/orderDetails/api/models/request/location_request_model.dart';
import 'package:flowery_tracking/features/orderDetails/api/models/request/update_order_status_with_api_model.dart';
import 'package:flowery_tracking/features/orderDetails/api/models/request/update_order_status_with_server_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateMocks([
  OrderDetailsApiService,
  RealTimeDataBaseService,
  FirebaseRemoteExecutor,
  ApiRemoteExecutor,
])
import 'order_details_remote_data_source_impl_test.mocks.dart';

void main() {
  setUpAll(() {
    provideDummy<ApiResult<void>>(ApiSuccessResult<void>(data: null));
  });
  late MockOrderDetailsApiService mockApiService;
  late MockRealTimeDataBaseService mockRtdb;
  late MockFirebaseRemoteExecutor mockFirebaseExecutor;
  late MockApiRemoteExecutor mockApiExecutor;
  late OrderDetailsRemoteDataSourceImpl dataSource;

  setUp(() {
    mockApiService = MockOrderDetailsApiService();
    mockRtdb = MockRealTimeDataBaseService();
    mockFirebaseExecutor = MockFirebaseRemoteExecutor();
    mockApiExecutor = MockApiRemoteExecutor();

    dataSource = OrderDetailsRemoteDataSourceImpl(
      mockApiService,
      mockRtdb,
      mockFirebaseExecutor,
      mockApiExecutor,
    );
  });

  group('deleteOrder', () {
    test('calls RTDB delete and returns success', () async {
      const path = 'orders/123';

      when(mockRtdb.delete(any)).thenAnswer((_) async {});
      when(
        mockFirebaseExecutor.execute<void, void>(
          request: anyNamed('request'),
          mapper: anyNamed('mapper'),
        ),
      ).thenAnswer((invocation) async {
        final request =
            invocation.namedArguments[const Symbol('request')]
                as Future<dynamic> Function();
        await request();
        return ApiSuccessResult<void>(data: null);
      });

      final result = await dataSource.deleteOrder(path: path);

      expect(result, isA<ApiSuccessResult<void>>());
      verify(mockRtdb.delete(path)).called(1);
      verify(
        mockFirebaseExecutor.execute<void, void>(
          request: anyNamed('request'),
          mapper: anyNamed('mapper'),
        ),
      ).called(1);
      verifyNoMoreInteractions(mockRtdb);
    });

    test('propagates error when executor returns error', () async {
      const path = 'orders/err';

      when(
        mockFirebaseExecutor.execute<void, void>(
          request: anyNamed('request'),
          mapper: anyNamed('mapper'),
        ),
      ).thenAnswer(
        (_) async => ApiErrorResult<void>(failure: Failure(errorMessage: 'x')),
      );

      final result = await dataSource.deleteOrder(path: path);

      expect(result, isA<ApiErrorResult<void>>());
    });
  });

  group('updateOrderStatusWithApi', () {
    test('calls API and returns success via api executor', () async {
      const id = '789';
      const model = UpdateOrderStatusWithApiModel(state: 'picked');

      when(
        mockApiService.updateOrderStatusOnApi(
          id: anyNamed('id'),
          UpdateOrderStatusWithApiModel: anyNamed(
            'UpdateOrderStatusWithApiModel',
          ),
        ),
      ).thenAnswer((_) async {
        return;
      });

      when(
        mockApiExecutor.execute<void, void>(
          request: anyNamed('request'),
          mapper: anyNamed('mapper'),
        ),
      ).thenAnswer((invocation) async {
        final request =
            invocation.namedArguments[const Symbol('request')]
                as Future<dynamic> Function();
        await request();
        return ApiSuccessResult<void>(data: null);
      });

      final result = await dataSource.updateOrderStatusWithApi(
        id: id,
        UpdateOrderStatusWithApiModel: model,
      );

      expect(result, isA<ApiSuccessResult<void>>());
      verify(
        mockApiService.updateOrderStatusOnApi(
          id: id,
          UpdateOrderStatusWithApiModel: model,
        ),
      ).called(1);
      verify(
        mockApiExecutor.execute<void, void>(
          request: anyNamed('request'),
          mapper: anyNamed('mapper'),
        ),
      ).called(1);
    });
  });

  group('updateOrderStatusOnServer', () {
    test('updates RTDB with mapped data and returns success', () async {
      const path = 'orders/456';
      const model = UpdateOrderStatusWithServerModel(
        status: 'arrived',
        statusUpdatedDate: '2025-10-16T10:00:00Z',
      );

      when(mockRtdb.update(any, any)).thenAnswer((_) async {});
      when(
        mockFirebaseExecutor.execute<void, void>(
          request: anyNamed('request'),
          mapper: anyNamed('mapper'),
        ),
      ).thenAnswer((invocation) async {
        final request =
            invocation.namedArguments[const Symbol('request')]
                as Future<dynamic> Function();
        await request();
        return ApiSuccessResult<void>(data: null);
      });

      final result = await dataSource.updateOrderStatusOnServer(
        path: path,
        updateOrderStatusModel: model,
      );

      expect(result, isA<ApiSuccessResult<void>>());
      verify(
        mockRtdb.update(path, {
          'status': model.status,
          'statusUpdateDate': model.statusUpdatedDate,
        }),
      ).called(1);
    });
  });

  group('updateDriverLocationOnServer', () {
    test('updates RTDB location and returns success', () async {
      const path = 'drivers/loc/123';
      const location = LocationRequestModel(lat: 24.7136, long: 46.6753);

      when(mockRtdb.update(any, any)).thenAnswer((_) async {});
      when(
        mockFirebaseExecutor.execute<void, void>(
          request: anyNamed('request'),
          mapper: anyNamed('mapper'),
        ),
      ).thenAnswer((invocation) async {
        final request =
            invocation.namedArguments[const Symbol('request')]
                as Future<dynamic> Function();
        await request();
        return ApiSuccessResult<void>(data: null);
      });

      final result = await dataSource.updateDriverLocationOnServer(
        locationRequestModel: location,
        path: path,
      );

      expect(result, isA<ApiSuccessResult<void>>());
      verify(
        mockRtdb.update(path, {'lat': location.lat, 'long': location.long}),
      ).called(1);
    });
  });
}
