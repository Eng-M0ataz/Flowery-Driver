import 'package:bloc_test/bloc_test.dart';
import 'package:flowery_tracking/core/enum/order_status.dart';
import 'package:flowery_tracking/core/errors/api_results.dart';
import 'package:flowery_tracking/core/errors/failure.dart';
import 'package:flowery_tracking/features/orderDetails/api/models/request/update_order_status_with_api_model.dart';
import 'package:flowery_tracking/features/orderDetails/api/models/request/update_order_status_with_server_model.dart';
import 'package:flowery_tracking/features/orderDetails/domain/useCases/delete_order_use_case.dart';
import 'package:flowery_tracking/features/orderDetails/domain/useCases/update_driver_location_on_server_use_case.dart';
import 'package:flowery_tracking/features/orderDetails/domain/useCases/update_order_status_on_server_use_case.dart';
import 'package:flowery_tracking/features/orderDetails/domain/useCases/update_order_status_with_api_use_case.dart';
import 'package:flowery_tracking/features/orderDetails/presentation/ViewModel/order_details_events.dart';
import 'package:flowery_tracking/features/orderDetails/presentation/ViewModel/order_details_state.dart';
import 'package:flowery_tracking/features/orderDetails/presentation/ViewModel/order_details_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateMocks([
  DeleteOrderUseCase,
  UpdateDriverLocationOnServerUseCase,
  UpdateOrderStatusOnServerUseCase,
  UpdateOrderStatusWithApiUseCase,
])
import 'order_details_view_model_test.mocks.dart';

// Minimal subclass to avoid closing subscriptions during blocTest auto-close
class _TestVM extends OrderDetailsViewModel {
  _TestVM(
    super.deleteOrderUseCase,
    super.updateDriverLocationOnServerUseCase,
    super.updateOrderStatusOnServerUseCase,
    super.updateOrderStatusWithApiUseCase,
  );

  @override
  // ignore: must_call_super
  Future<void> close() async {}
}

void main() {
  setUpAll(() {
    provideDummy<ApiResult<void>>(ApiSuccessResult<void>(data: null));
  });

  late MockDeleteOrderUseCase mockDeleteOrder;
  late MockUpdateDriverLocationOnServerUseCase mockUpdateLocation;
  late MockUpdateOrderStatusOnServerUseCase mockUpdateServer;
  late MockUpdateOrderStatusWithApiUseCase mockUpdateApi;

  OrderDetailsViewModel buildVm() {
    return _TestVM(
      mockDeleteOrder,
      mockUpdateLocation,
      mockUpdateServer,
      mockUpdateApi,
    );
  }

  setUp(() {
    mockDeleteOrder = MockDeleteOrderUseCase();
    mockUpdateLocation = MockUpdateDriverLocationOnServerUseCase();
    mockUpdateServer = MockUpdateOrderStatusOnServerUseCase();
    mockUpdateApi = MockUpdateOrderStatusWithApiUseCase();
  });

  blocTest<OrderDetailsViewModel, OrderDetailsState>(
    'updateOrderStatusOnServer emits loading then status on success',
    build: () {
      when(
        mockUpdateServer.invoke(
          path: anyNamed('path'),
          updateOrderStatusModel: anyNamed('updateOrderStatusModel'),
        ),
      ).thenAnswer((_) async => ApiSuccessResult<void>(data: null));
      return buildVm();
    },
    act: (vm) => vm.doIntent(
      event: UpdateOrderStatusOnServerEvent(
        path: '/orders/1',
        updateOrderStatusWithServerModel:
            const UpdateOrderStatusWithServerModel(
              status: 'arrived',
              statusUpdatedDate: 'now',
            ),
      ),
    ),
    expect: () => [
      isA<OrderDetailsState>().having((s) => s.isLoading, 'isLoading', true),
      isA<OrderDetailsState>()
          .having((s) => s.orderStatus, 'orderStatus', OrderStatus.arrived)
          .having((s) => s.isLoading, 'isLoading', false),
    ],
    verify: (vm) {
      // Verify final state has the status set to arrived
      expect(vm.state.orderStatus?.name, 'arrived');
    },
  );

  blocTest<OrderDetailsViewModel, OrderDetailsState>(
    'updateOrderStatusOnServer emits failure on error',
    build: () {
      when(
        mockUpdateServer.invoke(
          path: anyNamed('path'),
          updateOrderStatusModel: anyNamed('updateOrderStatusModel'),
        ),
      ).thenAnswer(
        (_) async => ApiErrorResult<void>(failure: Failure(errorMessage: 'e')),
      );
      return buildVm();
    },
    act: (vm) => vm.doIntent(
      event: UpdateOrderStatusOnServerEvent(
        path: '/orders/1',
        updateOrderStatusWithServerModel:
            const UpdateOrderStatusWithServerModel(
              status: 'picked',
              statusUpdatedDate: 'now',
            ),
      ),
    ),
    expect: () => [
      const OrderDetailsState(isLoading: true),
      isA<OrderDetailsState>().having(
        (s) => s.driverServerStatusFailure,
        'server failure',
        isNotNull,
      ),
    ],
  );

  blocTest<OrderDetailsViewModel, OrderDetailsState>(
    'updateOrderStatusWithApi emits nothing on success; emits failure on error',
    build: () => buildVm(),
    setUp: () {
      when(
        mockUpdateApi.invoke(
          id: anyNamed('id'),
          UpdateOrderStatusWithApiModel: anyNamed(
            'UpdateOrderStatusWithApiModel',
          ),
        ),
      ).thenAnswer((_) async => ApiSuccessResult<void>(data: null));
    },
    act: (vm) async {
      await vm.doIntent(
        event: UpdateOrderStatusWithApiEvent(
          orderId: '1',
          updateOrderStatusWithApiModel: const UpdateOrderStatusWithApiModel(
            state: 'delivered',
          ),
        ),
      );
      // Now stub error and call again
      when(
        mockUpdateApi.invoke(
          id: anyNamed('id'),
          UpdateOrderStatusWithApiModel: anyNamed(
            'UpdateOrderStatusWithApiModel',
          ),
        ),
      ).thenAnswer(
        (_) async =>
            ApiErrorResult<void>(failure: Failure(errorMessage: 'err')),
      );
      await vm.doIntent(
        event: UpdateOrderStatusWithApiEvent(
          orderId: '1',
          updateOrderStatusWithApiModel: const UpdateOrderStatusWithApiModel(
            state: 'delivered',
          ),
        ),
      );
    },
    expect: () => [
      // First call (success) produces no state updates
      // Second call (error) updates driverApiStatusFailure
      isA<OrderDetailsState>().having(
        (s) => s.driverApiStatusFailure,
        'api failure',
        isNotNull,
      ),
    ],
  );

  blocTest<OrderDetailsViewModel, OrderDetailsState>(
    'handleOrderStatusFlow updates server, then api+delete when delivered',
    build: () {
      when(
        mockUpdateServer.invoke(
          path: anyNamed('path'),
          updateOrderStatusModel: anyNamed('updateOrderStatusModel'),
        ),
      ).thenAnswer((_) async => ApiSuccessResult<void>(data: null));
      when(
        mockUpdateApi.invoke(
          id: anyNamed('id'),
          UpdateOrderStatusWithApiModel: anyNamed(
            'UpdateOrderStatusWithApiModel',
          ),
        ),
      ).thenAnswer((_) async => ApiSuccessResult<void>(data: null));
      when(
        mockDeleteOrder.invoke(path: anyNamed('path')),
      ).thenAnswer((_) async => ApiSuccessResult<void>(data: null));
      return buildVm();
    },
    act: (vm) => vm.doIntent(
      event: HandleOrderStatusFlowEvent(
        path: '/orders/1',
        deletePath: '/orders/1',
        orderId: '1',
        updateOrderStatusModel: const UpdateOrderStatusWithServerModel(
          status: 'delivered',
          statusUpdatedDate: 'now',
        ),
        updateOrderStatusWithApiModel: const UpdateOrderStatusWithApiModel(
          state: 'delivered',
        ),
      ),
    ),
    expect: () => [
      isA<OrderDetailsState>().having((s) => s.isLoading, 'isLoading', true),
      isA<OrderDetailsState>()
          .having((s) => s.orderStatus, 'orderStatus', OrderStatus.delivered)
          .having((s) => s.isLoading, 'isLoading', false),
    ],
    verify: (vm) {
      expect(vm.state.orderStatus?.name, 'delivered');
      verify(
        mockUpdateApi.invoke(
          id: anyNamed('id'),
          UpdateOrderStatusWithApiModel: anyNamed(
            'UpdateOrderStatusWithApiModel',
          ),
        ),
      ).called(1);
      verify(mockDeleteOrder.invoke(path: anyNamed('path'))).called(1);
    },
  );
}
