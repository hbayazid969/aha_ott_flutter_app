import 'package:get/get.dart';
import '../view/screen/home_screen.dart';

class SplashController extends GetxController {

  // Call initially when splash screen will create
  @override
  void onInit() {
    super.onInit();
    autoNavigate();
  }

  // Navigate to HomeScreen after a 2-second delay
  void autoNavigate() {
    // Use Future.delayed to add a 2-second delay
    Future.delayed(const Duration(seconds: 2), () {
      // Navigate to HomeScreen after delay
      Get.offAll(() =>  HomeScreen(),transition: Transition.leftToRight);
    });
  }
}
