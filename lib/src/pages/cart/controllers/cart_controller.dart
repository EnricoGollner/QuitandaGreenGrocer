import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quitanda_app/src/core/utils/toast_util.dart';
import 'package:quitanda_app/src/models/cart_item_model.dart';
import 'package:quitanda_app/src/models/item_model.dart';
import 'package:quitanda_app/src/models/order_model.dart';
import 'package:quitanda_app/src/pages/auth/controllers/auth_controller.dart';
import 'package:quitanda_app/src/pages/base/common_widgets/payment_dialog.dart';
import 'package:quitanda_app/src/pages/cart/cart_result/cart_result.dart';
import 'package:quitanda_app/src/pages/cart/repositories/cart_repository.dart';

class CartController extends GetxController {
  final CartRepository _cartRepository = CartRepository();
  final AuthController _authController = Get.find<AuthController>();

  List<CartItemModel> cartItems = [];

  bool isCheckoutLoading = false;

  void setCheckoutLoading(bool value) {
    isCheckoutLoading = value;
    update();
  }

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

  Future checkoutCart() async {
    setCheckoutLoading(true);

    final CartResult<OrderModel> result = await _cartRepository.checkoutCart(
      token: _authController.user.token!,
      total: cartTotalPrice().toString(),
    );

    setCheckoutLoading(false);

    result.when(
      success: (order) {
        cartItems.clear();
        update();

        showDialog(
          context: Get.context!,
          builder: (context) {
            return PaymentDialog(
              order: order,
            );
          },
        );
        FlutterToastUtil.show(message: 'Pedido realizado com sucesso');
      }, error: (message) {
        FlutterToastUtil.show(message: message, isError: true);
      },
    );
  }

  Future<bool> changeItemQuantity({required CartItemModel item, required int quantity}) async {
    final bool result = await _cartRepository.changeItemQuantity(
      token: _authController.user.token!,
      cartItemId: item.id,
      quantity: quantity,
    );

    if (result) {
      if (quantity == 0) {
        cartItems.removeWhere((cartItem) => cartItem.id == item.id);
      } else {
        cartItems.firstWhere((cartItem) => cartItem.id == item.id).quantity = quantity;
      }
      update();
    } else {
      FlutterToastUtil.show(message: 'Ocorreu um erro ao alterar a quantidade do produto', isError: true);
    }

    return result;
  }

  Future<void> getCartItems() async {
    final CartResult<List<CartItemModel>> result = await _cartRepository.getCartItems(
      token: _authController.user.token!,
      userId: _authController.user.id!,
    );

    result.when(success: (data) {
      cartItems = data;
      update();
    }, error: (message) {
      FlutterToastUtil.show(message: message, isError: true);
    });
  }

  int getItemIndex(ItemModel item) {
    return cartItems.indexWhere((itemInList) => itemInList.item.id == item.id);
  }

  Future<void> addItemToCart({required ItemModel item, int quantity = 1}) async {
    int itemIndex = getItemIndex(item);

    if (itemIndex >= 0) {
      final CartItemModel product = cartItems[itemIndex];

      await changeItemQuantity(item: product, quantity: (product.quantity + quantity));
      
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
        FlutterToastUtil.show(message: message, isError: true);
      });
    }

    update();
  }

  int getCartTotalItems() {  
    return cartItems.isEmpty
      ? 0
      : cartItems.map((item) => item.quantity).reduce((a, b) => a + b);
  }
}
