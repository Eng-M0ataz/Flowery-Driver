import 'package:dio/dio.dart';
import 'package:flowery_tracking/core/classes/remote_executor.dart';
import 'package:flowery_tracking/core/errors/api_results.dart';
import 'package:flowery_tracking/core/services/real_time_database_service.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/home/api/client/home_api_service.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/home/api/dataSources/home_remote_data_source_impl.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/home/api/mappers/pending_orders_response_dto_mapper.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/home/api/models/response/pending_orders_response_dto.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/home/domain/entities/response/pending_orders_response_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'home_remote_data_source_impl_test.mocks.dart';

@GenerateMocks([HomeApiService])
void main() {
  late HomeRemoteDataSourceImpl dataSource;
  late MockHomeApiService mockApiService;
  late RealTimeDataBaseService fakeRealTimeDb;
  late FirebaseRemoteExecutor firebaseRemoteExecutor;
  late ApiRemoteExecutor apiRemoteExecutor;

  setUp(() {
    mockApiService = MockHomeApiService();
    fakeRealTimeDb = _FakeRealTimeDB();
    firebaseRemoteExecutor = FirebaseRemoteExecutor();
    apiRemoteExecutor = ApiRemoteExecutor();
    dataSource = HomeRemoteDataSourceImpl(
      mockApiService,
      fakeRealTimeDb,
      firebaseRemoteExecutor,
      apiRemoteExecutor,
    );
  });

  group('getPendingOrders', () {
    const page = 1;
    const limit = 10;
    final mockResponse = PendingOrdersResponseDto(
      message: 'Success',
      orders: [],
    );
    final mockEntity = mockResponse.toEntity();

    test(
      'should return ApiSuccessResult with data when API call is successful',
      () async {
        // arrange
        when(
          mockApiService.getPendingOrders(page: page, limit: limit),
        ).thenAnswer((_) async => mockResponse);

        // act
        final result = await dataSource.getPendingOrders(
          page: page,
          limit: limit,
        );

        // assert
        expect(result, isA<ApiSuccessResult<PendingOrdersResponseEntity>>());
        final successResult =
            result as ApiSuccessResult<PendingOrdersResponseEntity>;
        expect(successResult.data.orders, mockEntity.orders);
        verify(mockApiService.getPendingOrders(page: page, limit: limit));
        verifyNoMoreInteractions(mockApiService);
      },
    );

    test(
      'should return ApiErrorResult when API call throws DioException',
      () async {
        // arrange
        final dioError = DioException(
          requestOptions: RequestOptions(path: ''),
          error: 'Server error',
          type: DioExceptionType.unknown,
        );
        when(
          mockApiService.getPendingOrders(page: page, limit: limit),
        ).thenThrow(dioError);

        // act
        final result = await dataSource.getPendingOrders(
          page: page,
          limit: limit,
        );

        // assert
        expect(result, isA<ApiErrorResult<PendingOrdersResponseEntity>>());
        final errorResult =
            result as ApiErrorResult<PendingOrdersResponseEntity>;
        expect(
          errorResult.failure.errorMessage,
          contains('Unexpected error occurred'),
        );
        verify(mockApiService.getPendingOrders(page: page, limit: limit));
        verifyNoMoreInteractions(mockApiService);
      },
    );

    test(
      'should return ApiErrorResult when API call throws other exceptions',
      () async {
        // arrange
        when(
          mockApiService.getPendingOrders(page: page, limit: limit),
        ).thenThrow(Exception('Unexpected error occurred'));

        // act
        final result = await dataSource.getPendingOrders(
          page: page,
          limit: limit,
        );

        // assert
        expect(result, isA<ApiErrorResult<PendingOrdersResponseEntity>>());
        final errorResult =
            result as ApiErrorResult<PendingOrdersResponseEntity>;
        expect(
          errorResult.failure.errorMessage,
          contains('Unexpected error occurred'),
        );
        verify(mockApiService.getPendingOrders(page: page, limit: limit));
        verifyNoMoreInteractions(mockApiService);
      },
    );
  });
}

class _FakeRealTimeDB implements RealTimeDataBaseService {
  @override
  Future<void> create(String path, Map<String, dynamic> data) async {}

  @override
  Future<void> delete(String path) async {}

  @override
  Stream<Map<String, dynamic>> listenData(String path) async* {}

  @override
  Future<Map<String, dynamic>?> read(String path) async => <String, dynamic>{};

  @override
  Future<void> update(String path, Map<String, dynamic> data) async {}
}
