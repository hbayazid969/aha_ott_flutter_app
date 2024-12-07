import 'package:get/get.dart';
import 'package:aha_ott_flutter_app/data/repository/all_movies_repo.dart';
import '../data/model/base_model/api_response.dart';

class AllMoviesController extends GetxController {
  final AllMoviesRepo allMoviesRepo;

  AllMoviesController({required this.allMoviesRepo});

  bool _isLoadingMovieData = false;
  bool get isLoadingMovieData => _isLoadingMovieData;

  dynamic allMoviesData;
  int currentPage = 1; // To track the current page

  // Function to fetch all movies for a given page
  Future<void> getAllMoviesData({dynamic page = 1}) async {
    // Set the loading state to true before making the API request
    _isLoadingMovieData = true;
    update();

    // Fetch data using the page parameter
    ApiResponse apiResponse = await allMoviesRepo.getAllMovies(page: page);

    // Check if the response is valid and handle accordingly
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      _isLoadingMovieData = false;
      update();

      // If data is available, append it to the existing list or set it
      if (apiResponse.response!.data != null) {
        if (page == 1) {
          // If it's the first page, reset the movie data
          allMoviesData = apiResponse.response!.data!["Search"];
        } else {
          // If it's not the first page, append the new data
          allMoviesData.addAll(apiResponse.response!.data!["Search"]);
        }
        update();
      }
    } else {
      // Set loading state to false if there's an error
      _isLoadingMovieData = false;
      update();
    }
  }

  // Function to load the next page of data
  void loadNextPage() {
    currentPage++; // Increment page number
    getAllMoviesData(page: currentPage); // Fetch data for the next page
  }

  // Reset pagination to the first page and fetch data again
  void resetPagination() {
    currentPage = 1;
    getAllMoviesData(page: currentPage);
  }

  @override
  void onInit() {
    // TODO: implement onInit
    getAllMoviesData(page: 1);
    super.onInit();
  }
}
