import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/app_strings.dart';
import '../datasource/remote/dio/dio_client.dart';
import '../datasource/remote/exception/api_error_handler.dart';
import '../model/base_model/api_response.dart';

class HomeRepo {
  final DioClient dioClient;
  final SharedPreferences sharedPreferences;

  HomeRepo({required this.dioClient, required this.sharedPreferences});

  /// Get Data
  Future<ApiResponse> getData(
      {
        dynamic search,
      }
      ) async {
    try {
      Response response = await dioClient.get(
        "?apikey=${AppStrings.apiKey}&s=$search",
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  /// Get Details
  Future<ApiResponse> getDetails(
      {
        dynamic id,
      }
      ) async {
    try {
      Response response = await dioClient.get(
        "?apikey=${AppStrings.apiKey}&i=$id",
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }


}