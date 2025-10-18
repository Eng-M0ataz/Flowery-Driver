import 'package:flowery_tracking/core/errors/failure.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/home/domain/entities/pending_order_entity.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/home/domain/entities/response/driver_response_entity.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/home/domain/entities/response/start_order_response_entity.dart';

class HomeState {
  HomeState({
    this.isLoading = true,
    this.failure,
    this.orders = const [],
    this.currentPage = 1,
    this.hasMore = true,
    this.isLoadingMore = false,
    this.orderRejected = false,
    this.startOrderEntity,
    this.loadingProducts = const {},
    this.driverDataFailure,
    this.driverData,
    this.createOrderFailure,
    this.startOrderFailure,
  });

  final bool isLoading;
  final Failure? failure;
  final List<PendingOrderEntity> orders;
  final int currentPage;
  final bool hasMore;
  final bool isLoadingMore;
  final bool orderRejected;
  final Map<String, bool>? loadingProducts;
  final StartOrderResponseEntity? startOrderEntity;
  final Failure? driverDataFailure;
  final Failure? createOrderFailure;
  final Failure? startOrderFailure;
  final DriverResponseEntity? driverData;

  HomeState copyWith({
    StartOrderResponseEntity? startOrderEntity,
    bool? isLoading,
    Failure? failure,
    List<PendingOrderEntity>? orders,
    int? currentPage,
    bool? hasMore,
    bool? isLoadingMore,
    bool? orderRejected,
    Map<String, bool>? loadingProducts,
    Failure? driverDataFailure,
    DriverResponseEntity? driverData,
    Failure? createOrderFailure,
    Failure? startOrderFailure,
  }) {
    return HomeState(
      startOrderEntity: startOrderEntity ?? this.startOrderEntity,
      isLoading: isLoading ?? this.isLoading,
      failure: failure ?? this.failure,
      orders: orders ?? this.orders,
      currentPage: currentPage ?? this.currentPage,
      hasMore: hasMore ?? this.hasMore,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      orderRejected: orderRejected ?? this.orderRejected,
      loadingProducts: loadingProducts ?? this.loadingProducts,
      driverData: driverData ?? this.driverData,
      driverDataFailure: driverDataFailure ?? this.driverDataFailure,
      createOrderFailure: createOrderFailure ?? this.createOrderFailure,
      startOrderFailure: startOrderFailure ?? this.startOrderFailure,
    );
  }
}
