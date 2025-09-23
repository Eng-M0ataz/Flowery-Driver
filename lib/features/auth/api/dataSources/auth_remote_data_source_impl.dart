import 'package:dio/dio.dart';
import 'package:flowery_tracking/core/errors/api_results.dart';
import 'package:flowery_tracking/core/errors/failure.dart';
import 'package:flowery_tracking/features/auth/api/client/auth_api_service.dart';
import 'package:flowery_tracking/features/auth/api/mapper/signIn/sigin_in_dto_mapper.dart';
import 'package:flowery_tracking/features/auth/api/model/signIn/request/sign_in_request_dto.dart';
import 'package:flowery_tracking/features/auth/data/dataSources/auth_remote_data_source.dart';
import 'package:flowery_tracking/features/auth/domain/entity/signIn/sign_in_request_entity.dart';
import 'package:flowery_tracking/features/auth/domain/entity/signIn/sign_in_response_entity.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  AuthRemoteDataSourceImpl(this._apiServices);
  final AuthApiService _apiServices;

  @override
  Future<ApiResult<SignInResponseEntity>> signIn({required SignInRequestEntity requestEntity}) async {
    try{
      final response = await _apiServices.signIn(requestDto: SignInRequestDto(email: requestEntity.email, password: requestEntity.password));
      return ApiSuccessResult<SignInResponseEntity>(data: response.toEntity());
    } on DioException catch(e){
      final failure = ServerFailure.fromDioError(dioException: e);
      return ApiErrorResult<SignInResponseEntity>(failure: failure);
    }catch (e){
      final failure = Failure(errorMessage: e.toString());
      return ApiErrorResult<SignInResponseEntity>(failure: failure);
    }

  }
}
