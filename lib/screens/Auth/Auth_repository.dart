import 'package:craftify_vendor/const/urls.dart';
import 'package:dio/dio.dart';

class AuthRepository {
  final Dio dio = Dio();

  // -------- Register APi --------->

  Future registerVendor(Map<String, dynamic> data) async {
    try {
      MultipartFile? imageFile;
      if (data["display_image"] != null) {
        imageFile = await MultipartFile.fromFile(data["display_image"].path);
      }

      FormData formData = FormData.fromMap({
        "name": data["name"],
        "contact_number": data["contact_number"],
        "whatsapp_number": data["whatsapp_number"],
        "email": data["email"],
        if (imageFile != null) "display_image": imageFile,
      });

      Response response = await dio.post(
        '${baseUrl}vendors/',
        data: formData,
      );

      // Success case
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response;
      } else {
        // This block is not needed if using default validateStatus
        throw Exception('Unexpected status code: ${response.statusCode}');
      }
    } on DioException catch (e) {
      // Handle 400 errors and other Dio exceptions
      if (e.response != null) {
        String errorMessage = '';
        errorMessage = e.response!.data.entries.first.value[0];
        print('---------------->${errorMessage}');

        throw Exception(errorMessage.isNotEmpty
            ? errorMessage
            : 'Registration Failed failed');
      } else {
        throw Exception('Network error: ${e.message}');
      }
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }
  // -------- Login API ---------->

  Future loginVendor(Map<String, dynamic> data) async {
    try {
      FormData formData = FormData.fromMap(data);

      Response response = await dio.post(
        '${baseUrl}vendor-login/',
        data: formData,
      );

      // Success case
      if (response.statusCode == 200 || response.statusCode == 201) {
        print(response);
        return response;
      } else {
        // This block is not needed if using default validateStatus
        throw Exception('Unexpected status code: ${response.statusCode}');
      }
    } on DioException catch (e) {
      // Handle 400 errors and other Dio exceptions
      if (e.response != null) {
        String errorMessage = '';
        errorMessage = e.response!.data.entries.first.value[0];
        print('---------------->${errorMessage}');

        throw Exception(
            errorMessage.isNotEmpty ? errorMessage : 'Sent otp failed');
      } else {
        throw Exception('Network error: ${e.message}');
      }
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

// ---------- Loging Otp  Verification --------->

  Future loginOtpVerify(Map<String, dynamic> data) async {
    try {
      FormData formData = FormData.fromMap(data);

      Response response = await dio.post(
        '${baseUrl}vendor-otpverify/',
        data: formData,
      );

      // Success case
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response;
      } else {
        throw Exception('Unexpected status code: ${response.statusCode}');
      }
    } on DioException catch (e) {
      // Handle API errors
      if (e.response != null) {
        String errorMessage = '';

        var errorData = e.response!.data;

        if (errorData is Map && errorData.isNotEmpty) {
          var firstError = errorData.entries.first.value;

          // If it's a List, get the first element
          if (firstError is List && firstError.isNotEmpty) {
            errorMessage = firstError.first.toString();
          } else if (firstError is String) {
            errorMessage = firstError;
          } else {
            errorMessage = 'Login failed';
          }
        } else {
          errorMessage = 'An unknown error occurred';
        }

        print('---------------->${errorMessage}');
        throw Exception(errorMessage);
      } else {
        throw Exception('Network error: ${e.message}');
      }
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }
}
