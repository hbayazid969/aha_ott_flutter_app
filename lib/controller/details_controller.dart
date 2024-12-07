import 'package:aha_ott_flutter_app/data/repository/details_repo.dart';
import 'package:get/get.dart';
import '../data/model/base_model/api_response.dart';

class DetailsController extends GetxController {
  final DetailsRepo detailsRepo;
  DetailsController({required this.detailsRepo});

  bool _isLoadingDetailsData = false;
  bool get isLoadingDetailsData => _isLoadingDetailsData;

  dynamic detailsData;

  /// Get Details Data
  Future<dynamic> getDetailsData({dynamic id}) async {
    _isLoadingDetailsData = true;
    update();
    ApiResponse apiResponse = await detailsRepo.getDetails(id: id);

    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {
      _isLoadingDetailsData = false;
      update();
      if (apiResponse.response!.data != null) {
        detailsData = apiResponse.response!.data!;
        update();
      }
    } else {
      _isLoadingDetailsData = false;
      update();
    }
  }




}