import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:flowery_tracking/core/errors/api_results.dart';
import 'package:flowery_tracking/core/errors/failure.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/orders/domain/entity/reponses/product_data_entity.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/orders/domain/repositories/orders_repo.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/orders/domain/useCases/get_product_use_case.dart';

// Manual mock with explicit default return values
class MockOrdersRepo extends Mock implements OrdersRepo {
  @override
  Future<ApiResult<ProductDataEntity>> getProduct(String productId) =>
      super.noSuchMethod(
        Invocation.method(#getProduct, [productId]),
        returnValue: Future.value(ApiSuccessResult<ProductDataEntity>(
          data: ProductDataEntity(
            product: ProductItemEntity(
              title: 'Default Product',
              slug: 'default',
              imgCover: '',
              description: '',
              Id: 'default',
              price: 0,
            ),
          ),
        )),
        returnValueForMissingStub: Future.value(ApiSuccessResult<ProductDataEntity>(
          data: ProductDataEntity(
            product: ProductItemEntity(
              title: 'Default Product',
              slug: 'default',
              imgCover: '',
              description: '',
              Id: 'default',
              price: 0,
            ),
          ),
        )),
      );
}

void main() {
  late GetProductUseCase getProductUseCase;
  late MockOrdersRepo mockOrdersRepo;

  // Dummy data
  ProductDataEntity createDummyProductEntity() {
    return ProductDataEntity(
      product: ProductItemEntity(
        title: 'Test Product',
        slug: 'test-product',
        imgCover: 'test.png',
        description: 'Test Description',
        Id: '123',
        price: 12,
      ),
    );
  }

  setUp(() {
    mockOrdersRepo = MockOrdersRepo();
    getProductUseCase = GetProductUseCase(ordersRepo: mockOrdersRepo);
  });

  group('GetProductUseCase', () {
    group('invoke', () {
      test('should return ApiSuccess when repository returns success', () async {
        // Arrange
        const productId = 'test_product_123';
        final expectedEntity = createDummyProductEntity();
        final expectedResult = ApiSuccessResult<ProductDataEntity>(data: expectedEntity);

        when(mockOrdersRepo.getProduct(productId))
            .thenAnswer((_) async => expectedResult);

        // Act
        final result = await getProductUseCase.invoke(productId);

        // Assert
        expect(result, isA<ApiSuccessResult<ProductDataEntity>>());

        final successResult = result as ApiSuccessResult<ProductDataEntity>;
        expect(successResult.data.product!.title, expectedEntity.product!.title);
        expect(successResult.data.product!.slug, expectedEntity.product!.slug);
        expect(successResult.data.product!.imgCover, expectedEntity.product!.imgCover);
        expect(successResult.data.product!.description, expectedEntity.product!.description);
        expect(successResult.data.product!.Id, expectedEntity.product!.Id);
        expect(successResult.data.product!.price, expectedEntity.product!.price);

        verify(mockOrdersRepo.getProduct(productId));
        verifyNoMoreInteractions(mockOrdersRepo);
      });

      test('should return ApiErrorResult when repository returns failure', () async {
        // Arrange
        const productId = 'product_1';
        final expectedFailure = Failure(errorMessage: 'Product not found');
        final expectedResult = ApiErrorResult<ProductDataEntity>(failure: expectedFailure);

        when(mockOrdersRepo.getProduct(productId))
            .thenAnswer((_) async => expectedResult);

        // Act
        final result = await getProductUseCase.invoke(productId);

        // Assert
        expect(result, isA<ApiErrorResult<ProductDataEntity>>());

        final errorResult = result as ApiErrorResult<ProductDataEntity>;
        expect(errorResult.failure.errorMessage, 'Product not found');

        verify(mockOrdersRepo.getProduct(productId));
        verifyNoMoreInteractions(mockOrdersRepo);
      });

      test('should propagate exceptions from repository', () async {
        // Arrange
        const productId = 'product_1';
        final exception = Exception('Test exception');

        when(mockOrdersRepo.getProduct(productId))
            .thenThrow(exception);

        // Act & Assert
        expect(() async => await getProductUseCase.invoke(productId), throwsException);

        verify(mockOrdersRepo.getProduct(productId));
        verifyNoMoreInteractions(mockOrdersRepo);
      });

      test('should call repository method with correct product ID', () async {
        // Arrange
        const specificProductId = 'specific_product_456';
        final expectedEntity = createDummyProductEntity();
        final expectedResult = ApiSuccessResult<ProductDataEntity>(data: expectedEntity);

        when(mockOrdersRepo.getProduct(specificProductId))
            .thenAnswer((_) async => expectedResult);

        // Act
        await getProductUseCase.invoke(specificProductId);

        // Assert
        verify(mockOrdersRepo.getProduct(specificProductId));
        verifyNoMoreInteractions(mockOrdersRepo);
      });

      test('should call repository method exactly once', () async {
        // Arrange
        const productId = 'test_product';
        final expectedEntity = createDummyProductEntity();
        final expectedResult = ApiSuccessResult<ProductDataEntity>(data: expectedEntity);

        when(mockOrdersRepo.getProduct(productId))
            .thenAnswer((_) async => expectedResult);

        // Act
        await getProductUseCase.invoke(productId);

        // Assert
        verify(mockOrdersRepo.getProduct(productId)).called(1);
        verifyNoMoreInteractions(mockOrdersRepo);
      });
    });

    group('parameter validation', () {
      test('should handle empty product ID', () async {
        // Arrange
        const emptyProductId = '';
        final expectedEntity = createDummyProductEntity();
        final expectedResult = ApiSuccessResult<ProductDataEntity>(data: expectedEntity);

        when(mockOrdersRepo.getProduct(emptyProductId))
            .thenAnswer((_) async => expectedResult);

        // Act
        final result = await getProductUseCase.invoke(emptyProductId);

        // Assert
        expect(result, isA<ApiSuccessResult<ProductDataEntity>>());
        verify(mockOrdersRepo.getProduct(emptyProductId));
        verifyNoMoreInteractions(mockOrdersRepo);
      });

      test('should handle product ID with special characters', () async {
        // Arrange
        const specialProductId = 'product-123_abc@test';
        final expectedEntity = createDummyProductEntity();
        final expectedResult = ApiSuccessResult<ProductDataEntity>(data: expectedEntity);

        when(mockOrdersRepo.getProduct(specialProductId))
            .thenAnswer((_) async => expectedResult);

        // Act
        final result = await getProductUseCase.invoke(specialProductId);

        // Assert
        expect(result, isA<ApiSuccessResult<ProductDataEntity>>());
        verify(mockOrdersRepo.getProduct(specialProductId));
        verifyNoMoreInteractions(mockOrdersRepo);
      });
    });

    group('edge cases', () {
      test('should handle different types of failures from repository', () async {
        // Arrange
        const productId = 'product_1';
        final failures = [
          Failure(errorMessage: 'Network error'),
          Failure(errorMessage: 'Product not found'),
          Failure(errorMessage: 'Server error'),
          Failure(errorMessage: 'Invalid product ID'),
        ];

        for (final failure in failures) {
          final expectedResult = ApiErrorResult<ProductDataEntity>(failure: failure);

          // Create a fresh mock for each iteration to avoid conflicts
          final freshMock = MockOrdersRepo();
          final freshUseCase = GetProductUseCase(ordersRepo: freshMock);

          when(freshMock.getProduct(productId))
              .thenAnswer((_) async => expectedResult);

          // Act
          final result = await freshUseCase.invoke(productId);

          // Assert
          expect(result, isA<ApiErrorResult<ProductDataEntity>>());
          final errorResult = result as ApiErrorResult<ProductDataEntity>;
          expect(errorResult.failure.errorMessage, failure.errorMessage);
        }
      });

      test('should handle product with minimal data', () async {
        // Arrange
        const productId = 'minimal_product';
        final minimalEntity = ProductDataEntity(
          product: ProductItemEntity(
            title: 'Minimal Product',
            slug: 'minimal',
            imgCover: '',
            description: '',
            Id: 'minimal_123',
            price: 0,
          ),
        );
        final expectedResult = ApiSuccessResult<ProductDataEntity>(data: minimalEntity);

        when(mockOrdersRepo.getProduct(productId))
            .thenAnswer((_) async => expectedResult);

        // Act
        final result = await getProductUseCase.invoke(productId);

        // Assert
        expect(result, isA<ApiSuccessResult<ProductDataEntity>>());
        final successResult = result as ApiSuccessResult<ProductDataEntity>;
        expect(successResult.data.product!.title, 'Minimal Product');
        expect(successResult.data.product!.slug, 'minimal');
        expect(successResult.data.product!.imgCover, '');
        expect(successResult.data.product!.description, '');
        expect(successResult.data.product!.price, 0);

        verify(mockOrdersRepo.getProduct(productId));
        verifyNoMoreInteractions(mockOrdersRepo);
      });
    });
  });
}