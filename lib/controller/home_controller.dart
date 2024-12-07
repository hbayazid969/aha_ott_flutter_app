import 'package:aha_ott_flutter_app/data/repository/home_repo.dart';
import 'package:get/get.dart';
import '../data/model/base_model/api_response.dart';

class HomeController extends GetxController {

  final HomeRepo homeRepo;

  HomeController({required this.homeRepo});

  bool _isLoadingMovieData = false;
  bool get isLoadingMovieData => _isLoadingMovieData;

  bool _isLoadingSeriesData = false;
  bool get isLoadingSeriesData => _isLoadingSeriesData;

  dynamic moviesData;
  dynamic seriesData;

  /// Get Movies Data
  Future<dynamic> getMoviesData() async {
    _isLoadingMovieData = true;
    update();
    ApiResponse apiResponse = await homeRepo.getData(search: "movies");

    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {
      _isLoadingMovieData = false;
      update();
      if (apiResponse.response!.data != null) {
        moviesData = apiResponse.response!.data!["Search"];
        update();
      }
    } else {
      _isLoadingMovieData = false;
      update();
    }
  }

  /// Get Movies Data
  Future<dynamic> getSeriesData() async {
    _isLoadingSeriesData = true;
    update();
    ApiResponse apiResponse = await homeRepo.getData(search: "series");

    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {
      _isLoadingSeriesData = false;
      update();
      if (apiResponse.response!.data != null) {
        seriesData = apiResponse.response!.data!["Search"];
        update();
      }
    } else {
      _isLoadingSeriesData = false;
      update();
    }
  }

  /// Get Details Data
  Future<dynamic> getDetailsData({dynamic id}) async {
    _isLoadingMovieData = true;
    update();
    ApiResponse apiResponse = await homeRepo.getData(search: "movies");

    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {
      _isLoadingMovieData = false;
      update();
      if (apiResponse.response!.data != null) {
        moviesData = apiResponse.response!.data!["Search"];
        update();
      }
    } else {
      _isLoadingMovieData = false;
      update();
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    getMoviesData();
    getSeriesData();
    super.onInit();
  }


}