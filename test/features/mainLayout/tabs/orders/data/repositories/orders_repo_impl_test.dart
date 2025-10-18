import 'package:flowery_tracking/core/errors/failure.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/orders/domain/entity/response/driver_orders_response_entity.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/orders/domain/entity/response/meta_data_entity.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/orders/domain/entity/response/product_data_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flowery_tracking/core/errors/api_results.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/orders/data/dataSources/orders_remote_data_source.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/orders/domain/repositories/orders_repo.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/orders/data/repositories/orders_repo_impl.dart';

import 'orders_repo_impl_test.mocks.dart';

// Provide dummy values for Mockito
void provideDummyApiResult<T>() {
  provideDummy<ApiResult<T>>(ApiSuccessResult<T>(data: _createDummyData<T>()));
}

T _createDummyData<T>() {
  if (T == DriverOrdersResponseEntity) {
    return createDummyDriverOrdersEntity() as T;
  } else if (T == ProductDataEntity) {
    return createDummyProductEntity() as T;
  }
  return null as T;
}
DriverOrdersResponseEntity createDummyDriverOrdersEntity() {
  return DriverOrdersResponseEntity(
      orders: [],
      message: 'Success',
      metadata: MetaDataEntity(
        currentPage: 10,
        limit: 1,
        totalItems: 100,
        totalPages: 10,
      )
  );
}

ProductDataEntity createDummyProductEntity() {
  return ProductDataEntity(
    product: ProductItemEntity(
      title: 'test',
      slug: 'test',
      imgCover: 'test.png',
      description: 'test',
      id: '233',
      price: 123,
    ),
  );
}
@GenerateMocks([OrdersRemoteDataSource])
void main() {
  late OrdersRepoImpl ordersRepo;
  late MockOrdersRemoteDataSource mockOrdersRemoteDataSource;


  setUp(() {
    mockOrdersRemoteDataSource = MockOrdersRemoteDataSource();
    ordersRepo = OrdersRepoImpl(
      ordersRemoteDataSource: mockOrdersRemoteDataSource,
    );
  });

  setUpAll(() {
    // Provide dummy values for all ApiResult types used in tests
    provideDummyApiResult<DriverOrdersResponseEntity>();
    provideDummyApiResult<ProductDataEntity>();
  });

  group('OrdersRepoImpl', () {
    group('getDriverOrders', () {
      test('should return ApiSuccess when remote data source returns success', () async {
        // Arrange
        final expectedEntity = createDummyDriverOrdersEntity();
        final expectedResult = ApiSuccessResult<DriverOrdersResponseEntity>(data: expectedEntity);

        when(mockOrdersRemoteDataSource.getDriverOrders())
            .thenAnswer((_) async => expectedResult);

        // Act
        final result = await ordersRepo.getDriverOrders();

        // Assert
        expect(result, isA<ApiSuccessResult<DriverOrdersResponseEntity>>());
        final successResult = result as ApiSuccessResult<DriverOrdersResponseEntity>;
        expect(successResult.data.orders, expectedEntity.orders);
        expect(successResult.data.message, expectedEntity.message);
        expect(successResult.data.metadata!.currentPage, expectedEntity.metadata!.currentPage);
        verify(mockOrdersRemoteDataSource.getDriverOrders());
        verifyNoMoreInteractions(mockOrdersRemoteDataSource);
      });

      test('should return ApiErrorResult when remote data source returns failure', () async {
        // Arrange
        final expectedFailure = Failure(errorMessage: 'Network error');
        final expectedResult = ApiErrorResult<DriverOrdersResponseEntity>(failure: expectedFailure);

        when(mockOrdersRemoteDataSource.getDriverOrders())
            .thenAnswer((_) async => expectedResult);

        // Act
        final result = await ordersRepo.getDriverOrders();

        // Assert
        expect(result, isA<ApiErrorResult<DriverOrdersResponseEntity>>());
        final errorResult = result as ApiErrorResult<DriverOrdersResponseEntity>;
        expect(errorResult.failure.errorMessage, 'Network error');
        verify(mockOrdersRemoteDataSource.getDriverOrders());
        verifyNoMoreInteractions(mockOrdersRemoteDataSource);
      });

      test('should propagate exceptions from remote data source', () async {
        // Arrange
        final exception = Exception('Test exception');
        when(mockOrdersRemoteDataSource.getDriverOrders())
            .thenThrow(exception);

        // Act & Assert
        expect(() async => await ordersRepo.getDriverOrders(), throwsException);
        verify(mockOrdersRemoteDataSource.getDriverOrders());
        verifyNoMoreInteractions(mockOrdersRemoteDataSource);
      });
    });

    group('getProduct', () {
      const testProductId = 'test_product_123';

      test('should return ApiSuccess when remote data source returns success', () async {
        // Arrange
        final expectedEntity = createDummyProductEntity();
        final expectedResult = ApiSuccessResult<ProductDataEntity>(data: expectedEntity);

        when(mockOrdersRemoteDataSource.getProduct(testProductId))
            .thenAnswer((_) async => expectedResult);

        // Act
        final result = await ordersRepo.getProduct(testProductId);

        // Assert
        expect(result, isA<ApiSuccessResult<ProductDataEntity>>());
        final successResult = result as ApiSuccessResult<ProductDataEntity>;
        expect(successResult.data.product!.title, expectedEntity.product!.title);
        expect(successResult.data.product!.slug, expectedEntity.product!.slug);
        expect(successResult.data.product!.price, expectedEntity.product!.price);
        verify(mockOrdersRemoteDataSource.getProduct(testProductId));
        verifyNoMoreInteractions(mockOrdersRemoteDataSource);
      });

      test('should return ApiErrorResult when remote data source returns failure', () async {
        // Arrange
        const productId = 'product_1';
        final expectedFailure = Failure(errorMessage: 'Product not found');
        final expectedResult = ApiErrorResult<ProductDataEntity>(failure: expectedFailure);

        when(mockOrdersRemoteDataSource.getProduct(productId))
            .thenAnswer((_) async => expectedResult);

        // Act
        final result = await ordersRepo.getProduct(productId);

        // Assert
        expect(result, isA<ApiErrorResult<ProductDataEntity>>());
        final errorResult = result as ApiErrorResult<ProductDataEntity>;
        expect(errorResult.failure.errorMessage, 'Product not found');
        verify(mockOrdersRemoteDataSource.getProduct(productId));
        verifyNoMoreInteractions(mockOrdersRemoteDataSource);
      });

      test('should call remote data source with correct product ID', () async {
        // Arrange
        const specificProductId = 'specific_product_456';
        final expectedEntity = createDummyProductEntity();
        final expectedResult = ApiSuccessResult<ProductDataEntity>(data: expectedEntity);

        when(mockOrdersRemoteDataSource.getProduct(specificProductId))
            .thenAnswer((_) async => expectedResult);

        // Act
        await ordersRepo.getProduct(specificProductId);

        // Assert
        verify(mockOrdersRemoteDataSource.getProduct(specificProductId));
        verifyNoMoreInteractions(mockOrdersRemoteDataSource);
      });

      test('should propagate exceptions from remote data source', () async {
        // Arrange
        const productId = 'product_1';
        final exception = Exception('Test exception');
        when(mockOrdersRemoteDataSource.getProduct(productId))
            .thenThrow(exception);

        // Act & Assert
        expect(() async => await ordersRepo.getProduct(productId), throwsException);
        verify(mockOrdersRemoteDataSource.getProduct(productId));
        verifyNoMoreInteractions(mockOrdersRemoteDataSource);
      });
    });

    group('edge cases', () {
      test('should handle empty product ID', () async {
        // Arrange
        const emptyProductId = '';
        final expectedEntity = createDummyProductEntity();
        final expectedResult = ApiSuccessResult<ProductDataEntity>(data: expectedEntity);

        when(mockOrdersRemoteDataSource.getProduct(emptyProductId))
            .thenAnswer((_) async => expectedResult);

        // Act
        final result = await ordersRepo.getProduct(emptyProductId);

        // Assert
        expect(result, isA<ApiSuccessResult<ProductDataEntity>>());
        final successResult = result as ApiSuccessResult<ProductDataEntity>;
        expect(successResult.data.product!.title, expectedEntity.product!.title);
        verify(mockOrdersRemoteDataSource.getProduct(emptyProductId));
        verifyNoMoreInteractions(mockOrdersRemoteDataSource);
      });
    });
  });
}