import 'package:equatable/equatable.dart';
import 'package:flowery_tracking/core/errors/failure.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/orders/domain/entity/reponses/driver_orders_response_entity.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/orders/domain/entity/reponses/product_data_entity.dart';


class OrdersStates extends Equatable {

  const OrdersStates({
    this.isLoading = true,
    this.failure,
    this.driverOrdersResponseEntity,
    this.productDataEntity,
  });
  final bool isLoading;
  final Failure? failure;
  final DriverOrdersResponseEntity? driverOrdersResponseEntity;
  final ProductDataEntity? productDataEntity;



  @override
  List<Object?> get props => [
    isLoading,
    failure,
    driverOrdersResponseEntity,
    productDataEntity,
  ];

  OrdersStates copyWith({
    bool? isLoading,
    Failure? failure,
    DriverOrdersResponseEntity? driverOrdersResponseEntity,
    ProductDataEntity? productDataEntity,
  }) {
    return OrdersStates(
      isLoading: isLoading ?? this.isLoading,
      failure: failure ?? this.failure,
      driverOrdersResponseEntity:
      driverOrdersResponseEntity ?? this.driverOrdersResponseEntity,
      productDataEntity: productDataEntity ?? this.productDataEntity,

    );
  }
}
