import 'package:aha_ott_flutter_app/data/repository/search_repo.dart';
import 'package:get/get.dart';
import '../data/model/base_model/api_response.dart';

class SearchControllerLoad extends GetxController {
  final SearchRepo searchRepo;
  SearchControllerLoad({required this.searchRepo});

  bool _isLoadingSearch = false;
  bool get isLoadingSearch => _isLoadingSearch;

  dynamic searchData;

  /// Get Details Data
  Future<dynamic> getSearchData({dynamic search}) async {
    _isLoadingSearch = true;
    update();
    ApiResponse apiResponse = await searchRepo.getSearchData(search: search);

    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {
      _isLoadingSearch = false;
      update();
      if (apiResponse.response!.data != null) {
        searchData = apiResponse.response!.data!["Search"];
        update();
      }
    } else {
      _isLoadingSearch = false;
      update();
    }
  }

}