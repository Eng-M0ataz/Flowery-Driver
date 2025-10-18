import 'package:flowery_tracking/features/mainLayout/tabs/orders/domain/entity/response/driver_orders_response_entity.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/orders/domain/entity/response/meta_data_entity.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/orders/domain/useCases/driver_orders_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flowery_tracking/core/errors/api_results.dart';
import 'package:flowery_tracking/core/errors/failure.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/orders/domain/repositories/orders_repo.dart';
import 'driver_orders_use_case_test.mocks.dart';

// Provide dummy values for Mockito
void provideDummyApiResults() {
  provideDummy<ApiResult<DriverOrdersResponseEntity>>(
    ApiSuccessResult<DriverOrdersResponseEntity>(
      data: DriverOrdersResponseEntity(
        orders: [],
        message: 'Dummy',
        metadata: MetaDataEntity(
          currentPage: 0,
          limit: 0,
          totalItems: 0,
          totalPages: 0,
        ),
      ),
    ),
  );
}

@GenerateMocks([OrdersRepo])
void main() {
  late DriverOrdersUseCase driverOrdersUseCase;
  late MockOrdersRepo mockOrdersRepo;

  // Dummy data
  DriverOrdersResponseEntity createDummyDriverOrdersEntity() {
    return DriverOrdersResponseEntity(
      orders: [],
      message: 'Success',
      metadata: MetaDataEntity(
        currentPage: 10,
        limit: 1,
        totalItems: 100,
        totalPages: 10,
      ),
    );
  }

  setUpAll(() {
    // Register dummy values before any tests run
    provideDummyApiResults();
  });

  setUp(() {
    mockOrdersRepo = MockOrdersRepo();
    driverOrdersUseCase = DriverOrdersUseCase(ordersRepo: mockOrdersRepo);
  });

  group('DriverOrdersUseCase', () {
    group('invoke', () {
      test('should return ApiSuccess when repository returns success', () async {
        // Arrange
        final expectedEntity = createDummyDriverOrdersEntity();
        final expectedResult = ApiSuccessResult<DriverOrdersResponseEntity>(data: expectedEntity);

        when(mockOrdersRepo.getDriverOrders())
            .thenAnswer((_) async => expectedResult);

        // Act
        final result = await driverOrdersUseCase.invoke();

        // Assert
        expect(result, isA<ApiSuccessResult<DriverOrdersResponseEntity>>());

        final successResult = result as ApiSuccessResult<DriverOrdersResponseEntity>;
        expect(successResult.data.orders, expectedEntity.orders);
        expect(successResult.data.message, expectedEntity.message);
        expect(successResult.data.metadata!.currentPage, expectedEntity.metadata!.currentPage);
        expect(successResult.data.metadata!.limit, expectedEntity.metadata!.limit);
        expect(successResult.data.metadata!.totalItems, expectedEntity.metadata!.totalItems);
        expect(successResult.data.metadata!.totalPages, expectedEntity.metadata!.totalPages);

        verify(mockOrdersRepo.getDriverOrders());
        verifyNoMoreInteractions(mockOrdersRepo);
      });

      test('should return ApiErrorResult when repository returns failure', () async {
        // Arrange
        final expectedFailure = Failure(errorMessage: 'Network error');
        final expectedResult = ApiErrorResult<DriverOrdersResponseEntity>(failure: expectedFailure);

        when(mockOrdersRepo.getDriverOrders())
            .thenAnswer((_) async => expectedResult);

        // Act
        final result = await driverOrdersUseCase.invoke();

        // Assert
        expect(result, isA<ApiErrorResult<DriverOrdersResponseEntity>>());

        final errorResult = result as ApiErrorResult<DriverOrdersResponseEntity>;
        expect(errorResult.failure.errorMessage, 'Network error');

        verify(mockOrdersRepo.getDriverOrders());
        verifyNoMoreInteractions(mockOrdersRepo);
      });

      test('should propagate exceptions from repository', () async {
        // Arrange
        final exception = Exception('Test exception');
        when(mockOrdersRepo.getDriverOrders())
            .thenThrow(exception);

        // Act & Assert
        expect(() async => await driverOrdersUseCase.invoke(), throwsException);

        verify(mockOrdersRepo.getDriverOrders());
        verifyNoMoreInteractions(mockOrdersRepo);
      });

      test('should call repository method exactly once', () async {
        // Arrange
        final expectedEntity = createDummyDriverOrdersEntity();
        final expectedResult = ApiSuccessResult<DriverOrdersResponseEntity>(data: expectedEntity);

        when(mockOrdersRepo.getDriverOrders())
            .thenAnswer((_) async => expectedResult);

        // Act
        await driverOrdersUseCase.invoke();

        // Assert
        verify(mockOrdersRepo.getDriverOrders()).called(1);
        verifyNoMoreInteractions(mockOrdersRepo);
      });
    });

    group('edge cases', () {
      test('should handle empty orders list from repository', () async {
        // Arrange
        final emptyEntity = DriverOrdersResponseEntity(
          orders: [],
          message: 'No orders found',
          metadata: MetaDataEntity(
            currentPage: 1,
            limit: 10,
            totalItems: 0,
            totalPages: 0,
          ),
        );
        final expectedResult = ApiSuccessResult<DriverOrdersResponseEntity>(data: emptyEntity);

        when(mockOrdersRepo.getDriverOrders())
            .thenAnswer((_) async => expectedResult);

        // Act
        final result = await driverOrdersUseCase.invoke();

        // Assert
        expect(result, isA<ApiSuccessResult<DriverOrdersResponseEntity>>());

        final successResult = result as ApiSuccessResult<DriverOrdersResponseEntity>;
        expect(successResult.data.orders, isEmpty);
        expect(successResult.data.message, 'No orders found');
        expect(successResult.data.metadata!.totalItems, 0);

        verify(mockOrdersRepo.getDriverOrders());
        verifyNoMoreInteractions(mockOrdersRepo);
      });

      test('should handle different types of failures from repository', () async {
        // Arrange
        final failures = [
          Failure(errorMessage: 'Network error'),
          Failure(errorMessage: 'Server error'),
          Failure(errorMessage: 'Timeout error'),
        ];

        for (final failure in failures) {
          final expectedResult = ApiErrorResult<DriverOrdersResponseEntity>(failure: failure);

          when(mockOrdersRepo.getDriverOrders())
              .thenAnswer((_) async => expectedResult);

          // Act
          final result = await driverOrdersUseCase.invoke();

          // Assert
          expect(result, isA<ApiErrorResult<DriverOrdersResponseEntity>>());

          final errorResult = result as ApiErrorResult<DriverOrdersResponseEntity>;
          expect(errorResult.failure.errorMessage, failure.errorMessage);

          // Reset mock for next iteration
          reset(mockOrdersRepo);
        }
      });
    });
  });
}