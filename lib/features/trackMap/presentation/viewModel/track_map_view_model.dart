import 'package:flowery_tracking/features/trackMap/domain/useCases/get_route_use_case.dart';
import 'package:flowery_tracking/features/trackMap/domain/entities/route_response_entity.dart';
import 'package:flowery_tracking/features/trackMap/presentation/viewModel/track_map_event.dart';
import 'package:flowery_tracking/features/trackMap/presentation/viewModel/track_map_state.dart';
import 'package:flowery_tracking/core/errors/api_results.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class TrackMapViewModel extends Cubit<TrackMapState> {

  TrackMapViewModel(this._getRouteUseCase) : super(const TrackMapState());
  final GetRouteUseCase _getRouteUseCase;

  Future<void> doIntent(TrackMapEvents event) async {
    switch (event) {
      case GetRouteEvent():
        await _handleGetRoute(event);
    }
  }

  Future<void> _handleGetRoute(GetRouteEvent event) async {
    emit(state.copyWith(isLoading: true));

    final result = await _getRouteUseCase(
      apiKey: event.apiKey,
      fieldMask: 'routes.duration,routes.distanceMeters,routes.polyline.encodedPolyline',
      body: event.body,
    );

    switch (result) {
      case ApiSuccessResult<RouteResponseEntity>():
        emit(
          state.copyWith(
            isLoading: false,
            routeResponse: result.data,
          ),
        );
      case ApiErrorResult<RouteResponseEntity>():
        emit(
          state.copyWith(
            isLoading: false,
            failure: result.failure,
          ),
        );
    }
  }
}