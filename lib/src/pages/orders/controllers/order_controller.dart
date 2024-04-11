import 'package:get/get.dart';
import 'package:quitanda_app/src/core/utils/utils_services.dart';
import 'package:quitanda_app/src/models/cart_item_model.dart';
import 'package:quitanda_app/src/models/order_model.dart';
import 'package:quitanda_app/src/pages/auth/controllers/auth_controller.dart';
import 'package:quitanda_app/src/pages/orders/orders_result/orders_result.dart';
import 'package:quitanda_app/src/pages/orders/repositories/order_repository.dart';

class OrderController extends GetxController {
  final OrdersRepository _ordersRepository = OrdersRepository();
  final AuthController _authController = Get.find<AuthController>();
  bool isLoading = false;

  void setLoading(bool value) {
    isLoading = value;
    update();
  }

  final OrderModel order;
  OrderController({required this.order});

  Future<void> getOrderItems({required String orderId}) async {
    setLoading(true);
    final OrdersResult<List<CartItemModel>> result = await _ordersRepository.getOrderItems(
      orderId: orderId,
      token: _authController.user.token!,
    );
    setLoading(false);

    result.when(
      success: (items) {
        order.items = items;
        update();
      },
      error: (message) {
        UtilsServices.showFlutterToast(message: message, isError: true);
      },
    );
  }
}
