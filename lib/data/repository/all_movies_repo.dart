import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/app_strings.dart';
import '../datasource/remote/dio/dio_client.dart';
import '../datasource/remote/exception/api_error_handler.dart';
import '../model/base_model/api_response.dart';

class AllMoviesRepo {
  final DioClient dioClient;
  final SharedPreferences sharedPreferences;

  AllMoviesRepo({required this.dioClient, required this.sharedPreferences});

  /// Get Movies
  Future<ApiResponse> getAllMovies({dynamic page}) async {
    try {
      Response response = await dioClient.get(
        "?apikey=${AppStrings.apiKey}&s=movies&page=$page",
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }


}