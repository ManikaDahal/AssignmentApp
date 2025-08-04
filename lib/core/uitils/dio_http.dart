import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:project_1/core/uitils/api_response.dart';
import 'package:project_1/core/uitils/status_utils.dart';

final Dio dio = Dio();

/// POST request with token header
Future<ApiResponse> postData(String url, dynamic data,{String ?token}) async {
  try {
    
    
    // Set Authorization header if token exists
    if (token != null && token.isNotEmpty) {
      dio.options.headers['Authorization'] = 'Bearer $token';
    }
    final response = await dio.post(url, data: data);

    

    if (response.statusCode == 200 || response.statusCode == 201) {
      return ApiResponse(
        statusUtil: StatusUtils.success,
        data: response.data,
      );
    } else {
      return ApiResponse(
        statusUtil: StatusUtils.error,
        errorMessage: 'Unexpected status code: ${response.statusCode}',
      );
    }
  } catch (e) {
    return ApiResponse(
      statusUtil: StatusUtils.error,
      errorMessage: e.toString(),
    );
  }
}



/// GET request
Future<ApiResponse> getData(String url,{String? token}) async {
  try {
    final response = await dio.get(url);
    if (token != null) {
      dio.options.headers['Authorization'] = 'Bearer $token';
    }
    if (response.statusCode == 200 || response.statusCode == 201) {
      return ApiResponse(
        statusUtil: StatusUtils.success,
        data: response.data,
      );
    } else {
      return ApiResponse(
        statusUtil: StatusUtils.error,
        errorMessage: 'Unexpected status code: ${response.statusCode}',
      );
    }
  } catch (e) {
    return ApiResponse(
      statusUtil: StatusUtils.error,
      errorMessage: e.toString(),
    );
  }
}



