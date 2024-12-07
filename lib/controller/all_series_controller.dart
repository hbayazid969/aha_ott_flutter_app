import 'package:aha_ott_flutter_app/data/repository/all_series_repo.dart';
import 'package:get/get.dart';
import 'package:aha_ott_flutter_app/data/repository/all_movies_repo.dart';
import '../data/model/base_model/api_response.dart';

class AllSeriesController extends GetxController {
  final AllSeriesRepo allSeriesRepo;

  AllSeriesController({required this.allSeriesRepo});

  bool _isLoadingSeriesData = false;
  bool get isLoadingSeriesData => _isLoadingSeriesData;

  dynamic allSeriesData;
  int currentPage = 1; // To track the current page

  // Function to fetch all series for a given page
  Future<void> getAllSeriesData({dynamic page = 1}) async {
    // Set the loading state to true before making the API request
    _isLoadingSeriesData = true;
    update();

    // Fetch data using the page parameter
    ApiResponse apiResponse = await allSeriesRepo.getAllSeries(page: page);

    // Check if the response is valid and handle accordingly
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      _isLoadingSeriesData = false;
      update();

      // If data is available, append it to the existing list or set it
      if (apiResponse.response!.data != null) {
        if (page == 1) {
          // If it's the first page, reset the movie data
          allSeriesData = apiResponse.response!.data!["Search"];
        } else {
          // If it's not the first page, append the new data
          allSeriesData.addAll(apiResponse.response!.data!["Search"]);
        }
        update();
      }
    } else {
      // Set loading state to false if there's an error
      _isLoadingSeriesData = false;
      update();
    }
  }

  // Function to load the next page of data
  void loadNextPage() {
    currentPage++; // Increment page number
    getAllSeriesData(page: currentPage); // Fetch data for the next page
  }

  // Reset pagination to the first page and fetch data again
  void resetPagination() {
    currentPage = 1;
    getAllSeriesData(page: currentPage);
  }

  @override
  void onInit() {
    // TODO: implement onInit
    getAllSeriesData(page: 1);
    super.onInit();
  }
}
