import 'package:flowery_tracking/core/errors/api_results.dart';
import 'package:flowery_tracking/core/errors/failure.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/home/data/dataSources/home_remote_data_source.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/home/data/repositories/home_repo_impl.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/home/domain/entities/response/pending_orders_response_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateMocks([HomeRemoteDataSource])
import 'home_repo_impl_test.mocks.dart';

void main() {
  late HomeRepoImpl repo;
  late MockHomeRemoteDataSource mockRemoteDataSource;
  late PendingOrdersResponseEntity mockPendingOrdersResponse;

  setUp(() {
    mockRemoteDataSource = MockHomeRemoteDataSource();
    repo = HomeRepoImpl(mockRemoteDataSource);

    mockPendingOrdersResponse = PendingOrdersResponseEntity(orders: []);

    provideDummy<ApiResult<PendingOrdersResponseEntity>>(
      ApiSuccessResult(data: mockPendingOrdersResponse),
    );
  });

  group('HomeRepoImpl tests', () {
    test('success case for getPendingOrders', () async {
      // arrange
      const page = 1;
      const limit = 10;
      when(
        mockRemoteDataSource.getPendingOrders(page: page, limit: limit),
      ).thenAnswer(
        (_) async => ApiSuccessResult(data: mockPendingOrdersResponse),
      );

      // act
      final result = await repo.getPendingOrders(page: page, limit: limit);

      // assert
      expect(result, isA<ApiSuccessResult<PendingOrdersResponseEntity>>());
      verify(mockRemoteDataSource.getPendingOrders(page: page, limit: limit));
      verifyNoMoreInteractions(mockRemoteDataSource);
    });

    test('failure case for getPendingOrders', () async {
      // arrange
      const page = 1;
      const limit = 10;
      when(
        mockRemoteDataSource.getPendingOrders(page: page, limit: limit),
      ).thenAnswer(
        (_) async =>
            ApiErrorResult(failure: Failure(errorMessage: 'Server error')),
      );

      // act
      final result = await repo.getPendingOrders(page: page, limit: limit);

      // assert
      expect(result, isA<ApiErrorResult<PendingOrdersResponseEntity>>());
      verify(mockRemoteDataSource.getPendingOrders(page: page, limit: limit));
      verifyNoMoreInteractions(mockRemoteDataSource);
    });
  });
}
