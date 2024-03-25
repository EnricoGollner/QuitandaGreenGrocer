import 'package:get/get.dart';
import 'package:quitanda_app/src/pages/auth/controllers/auth_controller.dart';
import 'package:quitanda_app/src/pages/cart/repositories/cart_repository.dart';

class CartController extends GetxController {
  final CartRepository _cartRepository = CartRepository();
  final AuthController _authController = Get.find<AuthController>();

  @override
  void onInit() {
    getCartItems();
    super.onInit();
  }

  Future<void> getCartItems() async {
    await _cartRepository.getCartItems(token: _authController.user.token!, userId: _authController.user.id!);
  }
}