import 'package:flowery_tracking/core/errors/api_results.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/orders/domain/entity/response/driver_orders_response_entity.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/orders/domain/entity/response/product_data_entity.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/orders/domain/useCases/driver_orders_use_case.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/orders/domain/useCases/get_product_use_case.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/orders/presentation/viewModels/orders_event.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/orders/presentation/viewModels/orders_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class OrdersViewModel extends Cubit<OrdersStates> {
  OrdersViewModel(this._driverOrdersUseCase, this._getProductUseCase)
    : super(const OrdersStates());
  final DriverOrdersUseCase _driverOrdersUseCase;
  final GetProductUseCase _getProductUseCase;
  int cancelled = 0;

  int completed = 0;

  Future<void> doIntend(OrdersEvent event) async {
    switch (event) {
      case GetDriverOrdersEvent():
        await _getDriverOrders();
      case GetProductEvent():
        await _getProduct(event.productId);
    }
  }

  Future<void> _getDriverOrders() async {
    emit(state.copyWith(isLoading: true, failure: null));
    final result = await _driverOrdersUseCase.invoke();
    switch (result) {
      case ApiSuccessResult<DriverOrdersResponseEntity>():
        final response = result.data;
        for (var element in response.orders!) {
          if (element.order!.state == 'cancelled') {
            cancelled++;
          } else if (element.order!.state == 'completed') {
            completed++;
          }
        }
        emit(
          state.copyWith(
            isLoading: false,
            failure: null,
            driverOrdersResponseEntity: response,
          ),
        );
        break;

      case ApiErrorResult<DriverOrdersResponseEntity>():
        emit(state.copyWith(isLoading: false, failure: result.failure));
        break;
    }
  }

  Future<void> _getProduct(String productId) async {
    final result = await _getProductUseCase.invoke(productId);
    switch (result) {
      case ApiSuccessResult<ProductDataEntity>():
        final response = result.data;
        emit(
          state.copyWith(
            isLoading: false,
            failure: null,
            productDataEntity: response
          ),
        );
      case ApiErrorResult<ProductDataEntity>():
        emit(state.copyWith(isLoading: false, failure: result.failure));
        break;
    }
  }
}
