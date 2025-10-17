import 'package:flowery_tracking/features/mainLayout/tabs/orders/domain/entity/response/all_orders_entity.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/orders/domain/entity/response/driver_orders_response_entity.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/orders/domain/entity/response/meta_data_entity.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/orders/domain/entity/response/order_entity.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/orders/domain/entity/response/product_data_entity.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/orders/domain/entity/response/store_entity.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/orders/domain/entity/response/user_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:flowery_tracking/core/errors/api_results.dart';
import 'package:flowery_tracking/core/errors/failure.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/orders/domain/useCases/driver_orders_use_case.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/orders/domain/useCases/get_product_use_case.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/orders/presentation/viewModels/orders_event.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/orders/presentation/viewModels/orders_states.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/orders/presentation/viewModels/orders_view_model.dart';

// Manual mocks with proper default implementations
class MockDriverOrdersUseCase extends Mock implements DriverOrdersUseCase {
  @override
  Future<ApiResult<DriverOrdersResponseEntity>> invoke() {
    return super.noSuchMethod(
      Invocation.method(#invoke, []),
      returnValue: Future.value(ApiSuccessResult<DriverOrdersResponseEntity>(
        data: DriverOrdersResponseEntity(
          orders: [],
          message: 'Default',
          metadata: MetaDataEntity(
            currentPage: 1,
            limit: 10,
            totalItems: 0,
            totalPages: 0,
          ),
        ),
      )),
      returnValueForMissingStub: Future.value(ApiSuccessResult<DriverOrdersResponseEntity>(
        data: DriverOrdersResponseEntity(
          orders: [],
          message: 'Default',
          metadata: MetaDataEntity(
            currentPage: 1,
            limit: 10,
            totalItems: 0,
            totalPages: 0,
          ),
        ),
      )),
    );
  }
}

class MockGetProductUseCase extends Mock implements GetProductUseCase {
  @override
  Future<ApiResult<ProductDataEntity>> invoke(String productId) {
    return super.noSuchMethod(
      Invocation.method(#invoke, [productId]),
      returnValue: Future.value(ApiSuccessResult<ProductDataEntity>(
        data: ProductDataEntity(
          product: ProductItemEntity(
            title: 'Default Product',
            slug: 'default',
            imgCover: '',
            description: '',
            id: 'default',
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
            id: 'default',
            price: 0,
          ),
        ),
      )),
    );
  }
}

void main() {
  late OrdersViewModel ordersViewModel;
  late MockDriverOrdersUseCase mockDriverOrdersUseCase;
  late MockGetProductUseCase mockGetProductUseCase;

  // Dummy data
  DriverOrdersResponseEntity createDummyDriverOrdersEntity({
    List<AllOrdersEntity>? orders,
    String message = 'Success',
  }) {
    return DriverOrdersResponseEntity(
      orders: orders ?? [],
      message: message,
      metadata: MetaDataEntity(
        currentPage: 1,
        limit: 10,
        totalItems: 100,
        totalPages: 10,
      ),
    );
  }

  AllOrdersEntity createOrderEntity(String state, String id) {
    return AllOrdersEntity(
      createdAt: '',
      driver: '',
      id: '',
      store: StoreEntity(name: '', image: '', address: '', phoneNumber: '', latLong: ''),
      updatedAt: '',
      order: OrderEntity(
        updatedAt: '',
        createdAt: '',
        orderNumber: '',
        isDelivered: false,
        isPaid: false,
        orderItems: [],
        paymentType: '',
        totalPrice: 0,
        user: UserEntity(id: '', firstName: '', lastName: '', email: '', gender: '', phone: '', photo: '', passwordChangedAt: ''),
        state: state,
        id: id,
      ),
    );
  }

  ProductDataEntity createDummyProductEntity() {
    return ProductDataEntity(
      product: ProductItemEntity(
        title: 'Test Product',
        slug: 'test-product',
        imgCover: 'test.png',
        description: 'Test Description',
        id: '123',
        price: 12,
      ),
    );
  }

  setUp(() {
    mockDriverOrdersUseCase = MockDriverOrdersUseCase();
    mockGetProductUseCase = MockGetProductUseCase();
    ordersViewModel = OrdersViewModel(
      mockDriverOrdersUseCase,
      mockGetProductUseCase,
    );
  });

  group('OrdersViewModel', () {
    group('doIntend', () {
      test('should handle GetDriverOrdersEvent', () async {
        // Arrange
        final event = GetDriverOrdersEvent();
        final expectedEntity = createDummyDriverOrdersEntity();
        final expectedResult = ApiSuccessResult<DriverOrdersResponseEntity>(
          data: expectedEntity,
        );

        when(mockDriverOrdersUseCase.invoke())
            .thenAnswer((_) async => expectedResult);

        // Act
        await ordersViewModel.doIntend(event);

        // Assert
        verify(mockDriverOrdersUseCase.invoke()).called(1);
        expect(ordersViewModel.state.driverOrdersResponseEntity, expectedEntity);
        expect(ordersViewModel.state.isLoading, false);
        expect(ordersViewModel.state.failure, isNull);
      });

      test('should handle GetProductEvent', () async {
        // Arrange
        const productId = 'test_product_123';
        final event = GetProductEvent(productId);
        final expectedEntity = createDummyProductEntity();
        final expectedResult = ApiSuccessResult<ProductDataEntity>(
          data: expectedEntity,
        );

        when(mockGetProductUseCase.invoke(productId))
            .thenAnswer((_) async => expectedResult);

        // Act
        await ordersViewModel.doIntend(event);

        // Assert
        verify(mockGetProductUseCase.invoke(productId)).called(1);
        expect(ordersViewModel.state.productDataEntity, expectedEntity);
        expect(ordersViewModel.state.isLoading, false);
        expect(ordersViewModel.state.failure, isNull);
      });
    });

    group('_getDriverOrders', () {
      test('should emit loading state and then success state', () async {
        // Arrange
        final expectedEntity = createDummyDriverOrdersEntity();
        final expectedResult = ApiSuccessResult<DriverOrdersResponseEntity>(
          data: expectedEntity,
        );

        when(mockDriverOrdersUseCase.invoke())
            .thenAnswer((_) async => expectedResult);

        // Track state changes - listen BEFORE the action
        final states = <OrdersStates>[];
        final subscription = ordersViewModel.stream.listen(states.add);

        // Act
        await ordersViewModel.doIntend(GetDriverOrdersEvent());

        // Wait a bit for state changes to propagate
        await Future.delayed(Duration.zero);
        subscription.cancel();

        // Assert
        expect(states.length, greaterThanOrEqualTo(2));
        expect(states[0].isLoading, true);
        expect(states.last.isLoading, false);
        expect(states.last.driverOrdersResponseEntity, expectedEntity);
        expect(states.last.failure, isNull);
      });

      test('should count cancelled and completed orders correctly', () async {
        // Arrange
        final orders = [
          createOrderEntity('cancelled', '1'),
          createOrderEntity('completed', '2'),
          createOrderEntity('cancelled', '3'),
          createOrderEntity('pending', '4'),
          createOrderEntity('completed', '5'),
        ];
        final expectedEntity = createDummyDriverOrdersEntity(orders: orders);
        final expectedResult = ApiSuccessResult<DriverOrdersResponseEntity>(
          data: expectedEntity,
        );

        when(mockDriverOrdersUseCase.invoke())
            .thenAnswer((_) async => expectedResult);

        // Act
        await ordersViewModel.doIntend(GetDriverOrdersEvent());

        // Assert
        expect(ordersViewModel.cancelled, 2);
        expect(ordersViewModel.completed, 2);
      });

      test('should emit error state when use case returns failure', () async {
        // Arrange
        final expectedFailure = Failure(errorMessage: 'Network error');
        final expectedResult = ApiErrorResult<DriverOrdersResponseEntity>(
          failure: expectedFailure,
        );

        when(mockDriverOrdersUseCase.invoke())
            .thenAnswer((_) async => expectedResult);

        // Track state changes - listen BEFORE the action
        final states = <OrdersStates>[];
        final subscription = ordersViewModel.stream.listen(states.add);

        // Act
        await ordersViewModel.doIntend(GetDriverOrdersEvent());

        // Wait a bit for state changes to propagate
        await Future.delayed(Duration.zero);
        subscription.cancel();

        // Assert
        expect(states.length, greaterThanOrEqualTo(2));
        expect(states[0].isLoading, true);
        expect(states.last.isLoading, false);
        expect(states.last.failure, expectedFailure);
        expect(states.last.driverOrdersResponseEntity, isNull);
      });

      test('should handle empty orders list', () async {
        // Arrange
        final expectedEntity = createDummyDriverOrdersEntity(orders: []);
        final expectedResult = ApiSuccessResult<DriverOrdersResponseEntity>(
          data: expectedEntity,
        );

        when(mockDriverOrdersUseCase.invoke())
            .thenAnswer((_) async => expectedResult);

        // Act
        await ordersViewModel.doIntend(GetDriverOrdersEvent());

        // Assert
        expect(ordersViewModel.cancelled, 0);
        expect(ordersViewModel.completed, 0);
        expect(ordersViewModel.state.driverOrdersResponseEntity, expectedEntity);
      });
    });

    group('_getProduct', () {
      test('should emit success state with product data', () async {
        // Arrange
        const productId = 'test_product_123';
        final expectedEntity = createDummyProductEntity();
        final expectedResult = ApiSuccessResult<ProductDataEntity>(
          data: expectedEntity,
        );

        when(mockGetProductUseCase.invoke(productId))
            .thenAnswer((_) async => expectedResult);

        // Track state changes - listen BEFORE the action
        final states = <OrdersStates>[];
        final subscription = ordersViewModel.stream.listen(states.add);

        // Act
        await ordersViewModel.doIntend(GetProductEvent(productId));

        // Wait a bit for state changes to propagate
        await Future.delayed(Duration.zero);
        subscription.cancel();

        // Assert
        expect(states.last.isLoading, false);
        expect(states.last.productDataEntity, expectedEntity);
        expect(states.last.failure, isNull);
      });

      test('should emit error state when product use case returns failure', () async {
        // Arrange
        const productId = 'product_1';
        final expectedFailure = Failure(errorMessage: 'Product not found');
        final expectedResult = ApiErrorResult<ProductDataEntity>(
          failure: expectedFailure,
        );

        when(mockGetProductUseCase.invoke(productId))
            .thenAnswer((_) async => expectedResult);

        // Track state changes - listen BEFORE the action
        final states = <OrdersStates>[];
        final subscription = ordersViewModel.stream.listen(states.add);

        // Act
        await ordersViewModel.doIntend(GetProductEvent(productId));

        // Wait a bit for state changes to propagate
        await Future.delayed(Duration.zero);
        subscription.cancel();

        // Assert
        expect(states.last.isLoading, false);
        expect(states.last.failure, expectedFailure);
        expect(states.last.productDataEntity, isNull);
      });

      test('should call use case with correct product ID', () async {
        // Arrange
        const specificProductId = 'specific_product_456';
        final expectedEntity = createDummyProductEntity();
        final expectedResult = ApiSuccessResult<ProductDataEntity>(
          data: expectedEntity,
        );

        when(mockGetProductUseCase.invoke(specificProductId))
            .thenAnswer((_) async => expectedResult);

        // Act
        await ordersViewModel.doIntend(GetProductEvent(specificProductId));

        // Assert
        verify(mockGetProductUseCase.invoke(specificProductId)).called(1);
      });
    });

    group('state management', () {
      test('should accumulate cancelled and completed counters across multiple orders loads', () async {
        // Arrange - First call with some orders
        final firstOrders = [
          createOrderEntity('cancelled', '1'),
          createOrderEntity('completed', '2'),
        ];
        final firstEntity = createDummyDriverOrdersEntity(orders: firstOrders);
        final firstResult = ApiSuccessResult<DriverOrdersResponseEntity>(
          data: firstEntity,
        );

        // Second call with different orders
        final secondOrders = [
          createOrderEntity('completed', '3'),
        ];
        final secondEntity = createDummyDriverOrdersEntity(orders: secondOrders);
        final secondResult = ApiSuccessResult<DriverOrdersResponseEntity>(
          data: secondEntity,
        );

        // Use consecutive responses with the SAME mock instance
        var callCount = 0;
        when(mockDriverOrdersUseCase.invoke()).thenAnswer((_) async {
          callCount++;
          if (callCount == 1) {
            return firstResult;
          } else {
            return secondResult;
          }
        });

        // Act - First call
        await ordersViewModel.doIntend(GetDriverOrdersEvent());
        final firstCancelled = ordersViewModel.cancelled;
        final firstCompleted = ordersViewModel.completed;

        // Second call
        await ordersViewModel.doIntend(GetDriverOrdersEvent());
        final secondCancelled = ordersViewModel.cancelled;
        final secondCompleted = ordersViewModel.completed;

        // Assert - Counters should ACCUMULATE (not reset) based on your ViewModel implementation
        expect(firstCancelled, 1);
        expect(firstCompleted, 1);
        expect(secondCancelled, 1); // Accumulates: 1 (from first) + 0 (from second) = 1
        expect(secondCompleted, 2); // Accumulates: 1 (from first) + 1 (from second) = 2
      });

      test('should maintain separate state for orders and product', () async {
        // Arrange
        final ordersEntity = createDummyDriverOrdersEntity();
        final ordersResult = ApiSuccessResult<DriverOrdersResponseEntity>(
          data: ordersEntity,
        );
        final productEntity = createDummyProductEntity();
        final productResult = ApiSuccessResult<ProductDataEntity>(
          data: productEntity,
        );

        when(mockDriverOrdersUseCase.invoke())
            .thenAnswer((_) async => ordersResult);
        when(mockGetProductUseCase.invoke('test'))
            .thenAnswer((_) async => productResult);

        // Act - Get orders first
        await ordersViewModel.doIntend(GetDriverOrdersEvent());
        final stateAfterOrders = ordersViewModel.state;

        // Then get product
        await ordersViewModel.doIntend(GetProductEvent('test'));
        final stateAfterProduct = ordersViewModel.state;

        // Assert
        expect(stateAfterOrders.driverOrdersResponseEntity, ordersEntity);
        expect(stateAfterOrders.productDataEntity, isNull);

        expect(stateAfterProduct.driverOrdersResponseEntity, ordersEntity); // Should persist
        expect(stateAfterProduct.productDataEntity, productEntity);
      });
    });

    // Additional test for initial state
    test('should start with initial state', () {
      expect(ordersViewModel.state, const OrdersStates());
      expect(ordersViewModel.cancelled, 0);
      expect(ordersViewModel.completed, 0);
    });

    // Test to verify the actual ViewModel counter logic
    test('should accumulate counters correctly in ViewModel logic', () async {
      // Arrange
      final firstOrders = [
        createOrderEntity('cancelled', '1'),
        createOrderEntity('completed', '2'),
      ];
      final firstEntity = createDummyDriverOrdersEntity(orders: firstOrders);
      final firstResult = ApiSuccessResult<DriverOrdersResponseEntity>(data: firstEntity);

      final secondOrders = [
        createOrderEntity('completed', '3'),
      ];
      final secondEntity = createDummyDriverOrdersEntity(orders: secondOrders);
      final secondResult = ApiSuccessResult<DriverOrdersResponseEntity>(data: secondEntity);

      // Use call count to return different results
      var callCount = 0;
      when(mockDriverOrdersUseCase.invoke()).thenAnswer((_) async {
        callCount++;
        return callCount == 1 ? firstResult : secondResult;
      });

      // Act & Assert - First call
      await ordersViewModel.doIntend(GetDriverOrdersEvent());
      expect(ordersViewModel.cancelled, 1);
      expect(ordersViewModel.completed, 1);

      // Second call - counters should ACCUMULATE (not reset) based on your ViewModel
      await ordersViewModel.doIntend(GetDriverOrdersEvent());
      expect(ordersViewModel.cancelled, 1); // 1 (from first) + 0 (from second) = 1
      expect(ordersViewModel.completed, 2); // 1 (from first) + 1 (from second) = 2
    });

    // Test with fresh ViewModel instances to show accumulation vs fresh start
    test('should show difference between accumulation and fresh start', () async {
      // First ViewModel - accumulates counts
      final firstViewModel = OrdersViewModel(mockDriverOrdersUseCase, mockGetProductUseCase);

      // Second ViewModel - fresh start
      final secondViewModel = OrdersViewModel(mockDriverOrdersUseCase, mockGetProductUseCase);

      // Setup mock for both
      final orders = [
        createOrderEntity('cancelled', '1'),
        createOrderEntity('completed', '2'),
      ];
      final entity = createDummyDriverOrdersEntity(orders: orders);
      final result = ApiSuccessResult<DriverOrdersResponseEntity>(data: entity);

      when(mockDriverOrdersUseCase.invoke())
          .thenAnswer((_) async => result);

      // Act - Call twice on first ViewModel (accumulation)
      await firstViewModel.doIntend(GetDriverOrdersEvent());
      await firstViewModel.doIntend(GetDriverOrdersEvent());

      // Call once on second ViewModel (fresh)
      await secondViewModel.doIntend(GetDriverOrdersEvent());

      // Assert
      expect(firstViewModel.cancelled, 2); // 1 + 1 = 2 (accumulated)
      expect(firstViewModel.completed, 2); // 1 + 1 = 2 (accumulated)
      expect(secondViewModel.cancelled, 1); // Fresh count
      expect(secondViewModel.completed, 1); // Fresh count
    });
  });
}