import 'package:bloc_test/bloc_test.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/home/domain/useCases/update_order_state_use_case.dart';
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

@GenerateMocks([GetPendingOrdersUseCase, UpdateOrderStateUseCase])
void main() {
  late MockGetPendingOrdersUseCase mockGetPendingOrdersUseCase;
  late MockUpdateOrderStateUseCase mockUpdateOrderStateUseCase;

  const expectedLimit = 10;

  final dummyOrder = PendingOrderEntity(id: '1');
  final dummyResponse = PendingOrdersResponseEntity(orders: [dummyOrder]);
  final serverFailure = ServerFailure(errorMessage: 'Server Error');

  setUpAll(() {
    provideDummy<ApiResult<PendingOrdersResponseEntity>>(
      ApiErrorResult(failure: ServerFailure(errorMessage: 'Dummy Failure')),
    );
  });

  setUp(() {
    mockGetPendingOrdersUseCase = MockGetPendingOrdersUseCase();
    mockUpdateOrderStateUseCase = MockUpdateOrderStateUseCase();
  });

  group('HomeViewModel Tests', () {
    blocTest<HomeViewModel, HomeState>(
      'emits [loading, success] when LoadInitialOrdersEvent succeeds',
      build: () {
        when(
          mockGetPendingOrdersUseCase.invoke(page: 1, limit: expectedLimit),
        ).thenAnswer((_) async => ApiSuccessResult(data: dummyResponse));
        return HomeViewModel(
          mockGetPendingOrdersUseCase,
          mockUpdateOrderStateUseCase,
        );
      },
      act: (bloc) => bloc.doIntend(LoadInitialOrdersEvent()),
      expect: () => [
        isA<HomeState>().having((s) => s.isLoading, 'isLoading', true),
        isA<HomeState>()
            .having((s) => s.isLoading, 'isLoading', false)
            .having((s) => s.orders.length, 'orders length', 1)
            .having((s) => s.orders.first.id, 'first order id', '1'),
      ],
      verify: (_) {
        verify(
          mockGetPendingOrdersUseCase.invoke(page: 1, limit: expectedLimit),
        ).called(1);
      },
    );

    blocTest<HomeViewModel, HomeState>(
      'emits [loading, error] when LoadInitialOrdersEvent fails',
      build: () {
        when(
          mockGetPendingOrdersUseCase.invoke(page: 1, limit: expectedLimit),
        ).thenAnswer((_) async => ApiErrorResult(failure: serverFailure));
        return HomeViewModel(
          mockGetPendingOrdersUseCase,
          mockUpdateOrderStateUseCase,
        );
      },
      act: (bloc) => bloc.doIntend(LoadInitialOrdersEvent()),
      expect: () => [
        isA<HomeState>().having((s) => s.isLoading, 'isLoading', true),
        isA<HomeState>()
            .having((s) => s.isLoading, 'isLoading', false)
            .having((s) => s.failure, 'failure', isNotNull)
            .having(
              (s) => s.failure?.errorMessage,
              'error message',
              'Server Error',
            ),
      ],
    );

    blocTest<HomeViewModel, HomeState>(
      'removes order and sets orderRejected flag when RejectOrderEvent is called',
      seed: () => HomeState(orders: [dummyOrder]),
      build: () {
        return HomeViewModel(
          mockGetPendingOrdersUseCase,
          mockUpdateOrderStateUseCase,
        );
      },
      act: (bloc) => bloc.doIntend(RejectOrderEvent('1')),
      wait: const Duration(milliseconds: 200),
      expect: () => [
        isA<HomeState>()
            .having((s) => s.orders, 'orders', isEmpty)
            .having((s) => s.orderRejected, 'orderRejected', true),
        isA<HomeState>()
            .having((s) => s.orders, 'orders', isEmpty)
            .having((s) => s.orderRejected, 'orderRejected', false),
      ],
    );
  });
}
