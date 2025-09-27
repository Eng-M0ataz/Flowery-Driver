// import 'package:flowery_tracking/features/auth/api/mapper/signIn/sigin_in_dto_mapper.dart';
// import 'package:flowery_tracking/features/auth/api/model/signIn/response/sign_in_response_dto.dart';
// import 'package:flowery_tracking/features/auth/domain/use_cases/sign_in_use_case.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/annotations.dart';
// import 'package:mockito/mockito.dart';
// import 'package:flowery_tracking/core/errors/api_results.dart';
// import 'package:flowery_tracking/core/errors/failure.dart';
// import 'package:flowery_tracking/features/auth/domain/entity/signIn/sign_in_request_entity.dart';
// import 'package:flowery_tracking/features/auth/domain/entity/signIn/sign_in_response_entity.dart';
// import 'package:flowery_tracking/features/auth/domain/repositories/auth_repo.dart';
//
// import 'sign_in_use_case_test.mocks.dart';
//
// // Generate mocks
// @GenerateMocks([AuthRepo])
//
// void main() {
//   late SignInUseCase useCase;
//   late MockAuthRepo mockAuthRepo;
//
//   setUp(() {
//     mockAuthRepo = MockAuthRepo();
//     useCase = SignInUseCase(authRepo: mockAuthRepo);
//   });
//
//   group('SignInUseCase', () {
//     final requestEntity =
//     SignInRequestEntity(email: 'test@example.com', password: 'Ahmed@123');
//     final responseDto =
//     SignInResponseDto(message: 'success', token: 'token123');
//     final responseEntity =responseDto.toEntity();
//
//     group('invoke', () {
//       test('should return ApiSuccessResult when repository call is successful', () async {
//         // Arrange
//         final successResult = ApiSuccessResult<SignInResponseEntity>(data: responseEntity);
//         when(mockAuthRepo.signIn(
//           requestEntity: anyNamed('requestEntity'),
//           rememberMeChecked: anyNamed('rememberMeChecked'),
//         )).thenAnswer((_) async => successResult);
//
//         // Act
//         final result = await useCase.invoke(requestEntity: requestEntity);
//
//         // Assert
//         expect(result, isA<ApiSuccessResult<SignInResponseEntity>>());
//         final success = result as ApiSuccessResult<SignInResponseEntity>;
//         expect(success.data.token, responseEntity.token);
//         expect(success.data.message, responseEntity.message);
//
//         verify(mockAuthRepo.signIn(
//           requestEntity: requestEntity,
//           rememberMeChecked: false,
//         )).called(1);
//       });
//     });
//   });
// }