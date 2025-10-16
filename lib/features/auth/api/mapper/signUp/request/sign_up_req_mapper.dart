import 'package:dio/dio.dart';
import 'package:flowery_tracking/features/auth/api/model/signUp/request/sign_up_request_model.dart';

extension SignUpRequestModelExtension on SignUpRequestModel {
  Future<FormData> toFormData() async {
    final Map<String, dynamic> fields = {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'password': password,
      'rePassword': confirmPassword,
      'phone': phoneNumber,
      'country': country,
      'vehicleType': vehicleType,
      'vehicleNumber': vehicleNumber,
      'NID': nationalId,
      'gender': gender,
    };

    fields['NIDImg'] = await MultipartFile.fromFile(
      nationalIdImage,
      filename: 'national_id.jpg',
    );

    fields['vehicleLicense'] = await MultipartFile.fromFile(
      vehicleLicenseImage,
      filename: 'vehicle_license.jpg',
    );

    return FormData.fromMap(fields);
  }
}
