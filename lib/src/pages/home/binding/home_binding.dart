import 'package:get/get.dart';
import 'package:quitanda_app/src/pages/home/controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(HomeController());
  }
}