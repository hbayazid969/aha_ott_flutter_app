import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/app_strings.dart';
import '../datasource/remote/dio/dio_client.dart';
import '../datasource/remote/exception/api_error_handler.dart';
import '../model/base_model/api_response.dart';

class DetailsRepo {
  final DioClient dioClient;
  final SharedPreferences sharedPreferences;

  DetailsRepo({required this.dioClient, required this.sharedPreferences});

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