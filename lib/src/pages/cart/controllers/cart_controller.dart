import 'package:get/get.dart';
import 'package:quitanda_app/src/core/utils/toast_util.dart';
import 'package:quitanda_app/src/models/cart_item_model.dart';
import 'package:quitanda_app/src/models/item_model.dart';
import 'package:quitanda_app/src/pages/auth/controllers/auth_controller.dart';
import 'package:quitanda_app/src/pages/cart/cart_result/cart_result.dart';
import 'package:quitanda_app/src/pages/cart/repositories/cart_repository.dart';

class CartController extends GetxController {
  final CartRepository _cartRepository = CartRepository();
  final AuthController _authController = Get.find<AuthController>();

  List<CartItemModel> cartItems = [];

  @override
  void onInit() {
    getCartItems();
    super.onInit();
  }

  double cartTotalPrice() {
    double total = 0;

    for (var cartItem in cartItems) {
      total += cartItem.totalPrice();
    }

    return total;
  }

  Future<void> getCartItems() async {
    final CartResult<List<CartItemModel>> result =
        await _cartRepository.getCartItems(
      token: _authController.user.token!,
      userId: _authController.user.id!,
    );

    result.when(success: (data) {
      cartItems = data;
      update();
    }, error: (message) {
      FlutterToastUtil.show(message: message);
    });
  }

  int getItemIndex(ItemModel item) {
    return cartItems.indexWhere((itemInList) => itemInList.item.id == item.id);
  }

  Future<void> addItemToCart(
      {required ItemModel item, int quantity = 1}) async {
    int itemIndex = getItemIndex(item);

    if (itemIndex != -1) {
      cartItems[itemIndex].quantity += quantity;
    } else {
      final CartResult<String> result = await _cartRepository.addItemToCart(
        userId: _authController.user.id!,
        token: _authController.user.token!,
        productId: item.id,
        quantity: quantity,
      );

      result.when(success: (cartItemId) {
        cartItems.add(CartItemModel(
          id: cartItemId,
          item: item,
          quantity: quantity,
        ));
      }, error: (message) {
        FlutterToastUtil.show(message: message);
      });
    }

    update();
  }
}
