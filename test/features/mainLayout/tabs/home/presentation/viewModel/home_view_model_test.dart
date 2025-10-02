import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flowery_tracking/core/errors/api_results.dart';
import 'package:flowery_tracking/core/errors/failure.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/home/domain/entities/pending_order_entity.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/home/domain/entities/response/pending_orders_response_entity.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/home/domain/useCases/get_pending_orders_use_case.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/home/presentation/viewModel/home_view_model.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/home/presentation/viewModel/home_state.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/home/presentation/viewModel/home_event.dart';

import 'home_view_model_test.mocks.dart';

@GenerateMocks([GetPendingOrdersUseCase])
void main() {
  late MockGetPendingOrdersUseCase mockGetPendingOrdersUseCase;

  // Register fallback values for Mockito
  setUpAll(() {
    provideDummy<ApiResult<PendingOrdersResponseEntity>>(
      ApiSuccessResult(data: PendingOrdersResponseEntity(orders: [])),
    );
  });

  // Dummy Data
  final dummyOrder = PendingOrderEntity(id: '1');
  final dummyResponse = PendingOrdersResponseEntity(orders: [dummyOrder]);
  final serverFailure = ServerFailure(errorMessage: "Server Error");

  setUp(() {
    mockGetPendingOrdersUseCase = MockGetPendingOrdersUseCase();
  });

  group('HomeViewModel Tests', () {
    blocTest<HomeViewModel, HomeState>(
      'emits [loading, success] when LoadInitialOrdersEvent succeeds',
      build: () {
        when(mockGetPendingOrdersUseCase.invoke(page: 1, limit: 30))
            .thenAnswer((_) async => ApiSuccessResult(data: dummyResponse));
        return HomeViewModel(mockGetPendingOrdersUseCase);
      },
      act: (bloc) => bloc.doIntend(LoadInitialOrdersEvent()),
      skip: 0,
      expect: () => [
        isA<HomeState>()
            .having((s) => s.isLoading, 'isLoading', true)
            .having((s) => s.orders, 'orders', isEmpty)
            .having((s) => s.orderRejected, 'orderRejected', false),
        isA<HomeState>()
            .having((s) => s.isLoading, 'isLoading', false)
            .having((s) => s.orders.length, 'orders length', 1)
            .having((s) => s.orders.first.id, 'first order id', '1')
            .having((s) => s.orderRejected, 'orderRejected', false),
      ],
      verify: (_) {
        verify(mockGetPendingOrdersUseCase.invoke(page: 1, limit: 30)).called(1);
      },
    );

    blocTest<HomeViewModel, HomeState>(
      'emits [loading, error] when LoadInitialOrdersEvent fails',
      build: () {
        when(mockGetPendingOrdersUseCase.invoke(page: 1, limit: 30))
            .thenAnswer((_) async => ApiErrorResult(failure: serverFailure));
        return HomeViewModel(mockGetPendingOrdersUseCase);
      },
      act: (bloc) => bloc.doIntend(LoadInitialOrdersEvent()),
      skip: 0,
      expect: () => [
        isA<HomeState>()
            .having((s) => s.isLoading, 'isLoading', true)
            .having((s) => s.orders, 'orders', isEmpty)
            .having((s) => s.orderRejected, 'orderRejected', false),
        isA<HomeState>()
            .having((s) => s.isLoading, 'isLoading', false)
            .having((s) => s.failure, 'failure', isNotNull)
            .having((s) => s.failure?.errorMessage, 'error message', 'Server Error')
            .having((s) => s.orderRejected, 'orderRejected', false),
      ],
    );

    blocTest<HomeViewModel, HomeState>(
      'removes order and sets orderRejected flag when RejectOrderEvent is called',
      build: () {
        when(mockGetPendingOrdersUseCase.invoke(page: 1, limit: 30))
            .thenAnswer((_) async => ApiSuccessResult(data: dummyResponse));
        return HomeViewModel(mockGetPendingOrdersUseCase);
      },
      act: (bloc) async {
        // First load the orders
        bloc.doIntend(LoadInitialOrdersEvent());
        // Wait for loading to complete
        await Future.delayed(const Duration(milliseconds: 100));
        // Then reject an order
        bloc.doIntend(RejectOrderEvent('1'));
      },
      wait: const Duration(milliseconds: 200),
      expect: () => [
        // State 1: Loading state from LoadInitialOrdersEvent
        isA<HomeState>()
            .having((s) => s.isLoading, 'isLoading', true),
        // State 2: Success state from LoadInitialOrdersEvent
        isA<HomeState>()
            .having((s) => s.isLoading, 'isLoading', false)
            .having((s) => s.orders.length, 'orders length', 1),
        // State 3: RejectOrderEvent directly emits final state (no loading)
        isA<HomeState>()
            .having((s) => s.orders, 'orders', isEmpty)
            .having((s) => s.orderRejected, 'orderRejected', true)
            .having((s) => s.isLoading, 'isLoading', false),
        // State 4: After delay, orderRejected is reset to false
        isA<HomeState>()
            .having((s) => s.orders, 'orders', isEmpty)
            .having((s) => s.orderRejected, 'orderRejected', false)
            .having((s) => s.isLoading, 'isLoading', false),
      ],
    );
  });
}