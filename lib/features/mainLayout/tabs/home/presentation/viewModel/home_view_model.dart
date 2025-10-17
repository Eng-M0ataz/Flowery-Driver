import 'dart:async';
import 'dart:developer';
import 'package:flowery_tracking/core/errors/api_results.dart';
import 'package:flowery_tracking/core/utils/constants/app_constants.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/home/api/models/request/order_details_request_model.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/home/domain/entities/pending_order_entity.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/home/domain/entities/response/driver_response_entity.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/home/domain/entities/response/pending_orders_response_entity.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/home/domain/useCases/create_order_use_case.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/home/domain/useCases/get_driver_data_use_case.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/home/domain/useCases/get_pending_orders_use_case.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/home/domain/useCases/start_order_use_case.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/home/presentation/viewModel/home_event.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/home/presentation/viewModel/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class HomeViewModel extends Cubit<HomeState> {
  HomeViewModel(
    this._getPendingOrdersUseCase,
    this._startOrderUseCase,
    this._createOrderUseCase,
    this._getDriverDataUseCase,
  ) : super(HomeState());
  final GetPendingOrdersUseCase _getPendingOrdersUseCase;
  final StartOrderUseCase _startOrderUseCase;
  final CreateOrderUseCase _createOrderUseCase;
  final GetDriverDataUseCase _getDriverDataUseCase;

  final _uiEventsController = StreamController<HomeEvent>();

  Stream<HomeEvent> get uiEvents => _uiEventsController.stream;

  @override
  Future<void> close() {
    _uiEventsController.close();
    return super.close();
  }

  Future<void> doIntend(HomeEvent event) async {
    switch (event) {
      case LoadInitialOrdersEvent():
        await _loadOrders(page: 1, isRefresh: false);
        break;
      case LoadNextOrdersEvent():
        if (!state.isLoadingMore && state.hasMore) {
          await _loadOrders(page: state.currentPage + 1, isRefresh: false);
        }
        break;
      case RefreshOrdersEvent():
        await _loadOrders(page: 1, isRefresh: true);
        break;

      case RejectOrderEvent():
        _rejectOrder(event.orderId);
        break;
      case StartOrderEvent():
        await _startOrder(event.orderId);
        break;
      case GetDriverDataEvent():
        await _getDriverData();
        break;
      case CreateOrderEvent(
        orderDetailsRequestModel: final orderDetailsRequestModel,
        path: final path,
      ):
        await _createOrder(
          orderDetailsRequestModel: orderDetailsRequestModel,
          path: path,
        );
        break;
    }
  }

  Future<void> _createOrder({
    required OrderDetailsRequestModel orderDetailsRequestModel,
    required String path,
  }) async {
    final result = await _createOrderUseCase.invoke(
      orderDetailsRequestModel: orderDetailsRequestModel,
      path: path,
    );
    switch (result) {
      case ApiSuccessResult<void>():
        return;
      case ApiErrorResult<void>():
        emit(state.copyWith(createOrderFailure: result.failure));
        log(result.failure.errorMessage);
    }
  }

  Future<void> _getDriverData() async {
    final result = await _getDriverDataUseCase.invoke();
    switch (result) {
      case ApiSuccessResult<DriverResponseEntity>():
        emit(state.copyWith(driverData: result.data));

      case ApiErrorResult<DriverResponseEntity>():
        emit(state.copyWith(driverDataFailure: result.failure));
    }
  }

  Future<void> _startOrder(String orderId) async {
    emit(state.copyWith(loadingProducts: {orderId: true}));
    final result = await _startOrderUseCase.invoke(orderId: orderId);

    switch (result) {
      case ApiSuccessResult():
        emit(
          state.copyWith(
            loadingProducts: {orderId: false},
            startOrderEntity: result.data,
          ),
        );
        break;

      case ApiErrorResult():
        emit(
          state.copyWith(
            loadingProducts: {orderId: false},
            startOrderFailure: result.failure,
          ),
        );
        break;
    }
  }

  void _rejectOrder(String orderId) {
    final updatedOrders = List<PendingOrderEntity>.from(state.orders);

    updatedOrders.removeWhere((order) => order.id == orderId);

    emit(state.copyWith(orders: updatedOrders, orderRejected: true));
    Future.delayed(
      const Duration(milliseconds: AppConstants.uiRebuildDelay),
      () {
        emit(state.copyWith(orderRejected: false));
      },
    );
  }

  Future<void> _loadOrders({required int page, required bool isRefresh}) async {
    if (isRefresh) {
      emit(state.copyWith(isLoading: true, orders: [], failure: null));
    } else if (page == 1) {
      emit(state.copyWith(isLoading: true, failure: null));
    } else {
      emit(state.copyWith(isLoadingMore: true));
    }

    final result = await _getPendingOrdersUseCase.invoke(
      page: page,
      limit: AppConstants.ordersPageLimit,
    );

    switch (result) {
      case ApiSuccessResult<PendingOrdersResponseEntity>():
        final newOrders = result.data.orders ?? [];

        emit(
          state.copyWith(
            isLoading: false,
            isLoadingMore: false,
            orders: isRefresh ? newOrders : [...state.orders, ...newOrders],
            currentPage: page,
            hasMore: newOrders.isNotEmpty,
          ),
        );
        break;
      case ApiErrorResult<PendingOrdersResponseEntity>():
        emit(
          state.copyWith(
            isLoading: false,
            isLoadingMore: false,
            failure: result.failure,
          ),
        );
        break;
    }
  }
}
