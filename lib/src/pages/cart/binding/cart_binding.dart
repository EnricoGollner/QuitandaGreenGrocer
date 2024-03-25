import 'package:get/get.dart';
import 'package:quitanda_app/src/pages/cart/controllers/cart_controller.dart';

class CartBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<CartController>(CartController());
  }
}