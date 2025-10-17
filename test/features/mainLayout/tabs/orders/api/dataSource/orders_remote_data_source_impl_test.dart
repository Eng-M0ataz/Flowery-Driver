import 'package:flowery_tracking/core/errors/failure.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/orders/api/dataSource/orders_remote_data_source_impl.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/orders/api/models/reponses/meta_data_dto.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/orders/api/models/reponses/product_data_dto.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/orders/api/models/reponses/product_dto.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/orders/domain/entity/response/driver_orders_response_entity.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/orders/domain/entity/response/meta_data_entity.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/orders/domain/entity/response/product_data_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flowery_tracking/core/errors/api_results.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/orders/api/client/orders_api_service.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/orders/api/models/reponses/driver_orders_response_dto.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/orders/data/dataSources/orders_remote_data_source.dart';

import 'orders_remote_data_source_impl_test.mocks.dart';

// Generate mocks
@GenerateMocks([OrdersApiService])
void main() {
  late OrdersRemoteDataSourceImpl dataSource;
  late MockOrdersApiService mockOrdersApiService;

  // Dummy data providers
  DriverOrdersResponseDto createDummyDriverOrdersDto() {
    return DriverOrdersResponseDto(
      // Add your DTO properties here based on your actual model
      orders: [],
      message: 'Success',
      metadata: MetaDataDto(
        currentPage: 1,
        limit: 1,
        totalItems: 100,
        totalPages: 10,
      ),
    );
  }

  DriverOrdersResponseEntity createDummyDriverOrdersEntity() {
    return DriverOrdersResponseEntity(
      // Add your Entity properties here based on your actual model
      orders: [],
      message: 'Success',
      metadata: MetaDataEntity(
        currentPage: 1,
        limit: 1,
        totalItems: 100,
        totalPages: 10,
      ),
    );
  }

  ProductDataDto createDummyProductDto() {
    return ProductDataDto(
     message: 'Success',
      product: ProductItemDto(
        price: 22,
        id: '1232',
        description: 'test',
        imgCover: 'test.png',
        slug: 'test',
        title: 'test',
      )
    );
  }

  ProductDataEntity createDummyProductEntity() {
    return ProductDataEntity(
        message: 'Success',
        product: ProductItemEntity(
          price: 22,
          id: '1232',
          description: 'test',
          imgCover: 'test.png',
          slug: 'test',
          title: 'test',
        )
    );
  }

  setUp(() {
    mockOrdersApiService = MockOrdersApiService();
    dataSource = OrdersRemoteDataSourceImpl(
      ordersApiService: mockOrdersApiService,
    );
  });

  group('getDriverOrders', () {
    test('should return ApiSuccess with DriverOrdersResponseEntity when API call is successful', () async {
      // Arrange
      final dummyDto = createDummyDriverOrdersDto();
      final expectedEntity = createDummyDriverOrdersEntity();

      when(mockOrdersApiService.getDriverOrders())
          .thenAnswer((_) async => dummyDto);

      // Act
      final result = await dataSource.getDriverOrders();

      // Assert
      expect(result, isA<ApiSuccessResult<DriverOrdersResponseEntity>>());

      final successResult = result as ApiSuccessResult<DriverOrdersResponseEntity>;
      // Compare individual properties instead of the whole object
      expect(successResult.data.orders, expectedEntity.orders);

      verify(mockOrdersApiService.getDriverOrders());
      verifyNoMoreInteractions(mockOrdersApiService);
    });

    test('should return ApiErrorResult with Failure when API call throws an exception', () async {
      // Arrange
      final exception = Exception('Network error');
      when(mockOrdersApiService.getDriverOrders())
          .thenThrow(exception);

      // Act
      final result = await dataSource.getDriverOrders();

      // Assert
      expect(result, isA<ApiErrorResult<DriverOrdersResponseEntity>>());

      final errorResult = result as ApiErrorResult<DriverOrdersResponseEntity>;
      expect(errorResult.failure, isA<Failure>());

      // Check the Failure properties - adjust based on your Failure class structure
      expect(errorResult.failure.errorMessage, contains('Network error'));
      // OR if your Failure has different properties:
      // expect(errorResult.failure.toString(), contains('Network error'));

      verify(mockOrdersApiService.getDriverOrders());
      verifyNoMoreInteractions(mockOrdersApiService);
    });

  });

  group('getProduct', () {
    const testProductId = 'test_product_123';

    test('should return ApiSuccess with ProductDataEntity when API call is successful', () async {
      // Arrange
      final dummyDto = createDummyProductDto();
      final expectedEntity = createDummyProductEntity();

      when(mockOrdersApiService.getProduct(testProductId))
          .thenAnswer((_) async => dummyDto);

      // Act
      final result = await dataSource.getProduct(testProductId);

      // Assert
      expect(result, isA<ApiSuccessResult<ProductDataEntity>>());

      final successResult = result as ApiSuccessResult<ProductDataEntity>;

      // Compare individual properties of the ProductItemEntity
      expect(successResult.data.product!.id, expectedEntity.product!.id);
      expect(successResult.data.product!.title, expectedEntity.product!.title);
      expect(successResult.data.product!.description, expectedEntity.product!.description);
      // Add any other properties your ProductItemEntity has

      // Also compare other properties of ProductDataEntity if it has any
      // For example:
      // expect(successResult.data.someOtherProperty, expectedEntity.someOtherProperty);

      verify(mockOrdersApiService.getProduct(testProductId));
      verifyNoMoreInteractions(mockOrdersApiService);
    });

    test('should return ApiFailure when getProduct API call throws an exception', () async {
      // Arrange
      const productId = 'product_1';
      final exception = Exception('Product not found');

      when(mockOrdersApiService.getProduct(productId))
          .thenThrow(exception);

      // Act
      final result = await dataSource.getProduct(productId);

      // Assert - Check for Failure object, not the raw exception
      expect(result, isA<ApiErrorResult<ProductDataEntity>>());

      final failureResult = result as ApiErrorResult<ProductDataEntity>;
      expect(failureResult.failure, isA<Failure>());
      expect(failureResult.failure.errorMessage.toString(), contains('Product not found'));

      verify(mockOrdersApiService.getProduct(productId));
      verifyNoMoreInteractions(mockOrdersApiService);
    });

    test('should call API service with correct product ID', () async {
      // Arrange
      const specificProductId = 'specific_product_456';
      final dummyDto = createDummyProductDto();

      when(mockOrdersApiService.getProduct(specificProductId))
          .thenAnswer((_) async => dummyDto);

      // Act
      await dataSource.getProduct(specificProductId);

      // Assert
      verify(mockOrdersApiService.getProduct(specificProductId));
      verifyNoMoreInteractions(mockOrdersApiService);
    });
  });

  group('edge cases', () {
    test('should handle empty response data appropriately', () async {
      // Arrange
      final emptyDto = DriverOrdersResponseDto(
        orders: [],
        message: '',
        metadata: MetaDataDto(
          currentPage: 1,
          limit: 10,
          totalItems: 0,
          totalPages: 0,
        )
      );

      when(mockOrdersApiService.getDriverOrders())
          .thenAnswer((_) async => emptyDto);

      // Act
      final result = await dataSource.getDriverOrders();

      // Assert
      expect(result, isA<ApiSuccessResult<DriverOrdersResponseEntity>>());
      final successResult = result as ApiSuccessResult<DriverOrdersResponseEntity>;
      expect(successResult.data.orders, isEmpty);
      expect(successResult.data.message, '');
      expect(successResult.data.metadata.currentPage, 1);
      expect(successResult.data.metadata.limit, 10);
      expect(successResult.data.metadata.totalItems, 0);
      expect(successResult.data.metadata.totalPages, 0);
    });

  });
}