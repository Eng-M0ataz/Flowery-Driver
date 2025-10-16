import 'package:flowery_tracking/core/errors/failure.dart';
import 'package:flowery_tracking/features/mainLayout/tabs/home/domain/entities/pending_order_entity.dart';
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
    );
  }
}
