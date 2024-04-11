import 'package:get/get.dart';
import 'package:quitanda_app/src/core/utils/utils_services.dart';
import 'package:quitanda_app/src/models/order_model.dart';
import 'package:quitanda_app/src/pages/auth/controllers/auth_controller.dart';
import 'package:quitanda_app/src/pages/orders/orders_result/orders_result.dart';
import 'package:quitanda_app/src/pages/orders/repositories/order_repository.dart';

class OrdersController extends GetxController {
  final OrdersRepository _ordersRepository = OrdersRepository();
  final AuthController _authController = Get.find<AuthController>();

  List<OrderModel> orders = [];

  @override
  Future<void> onInit() async {
    await getAllOrders();
    super.onInit();
  }

  Future<void> getAllOrders() async {
    final OrdersResult<List<OrderModel>> result = await _ordersRepository.getAllOrders(
      token: _authController.user.token!,
      userId: _authController.user.id!,
    );

    result.when(success: (orders) {
      orders = orders..sort((a, b) => b.createdDateTime!.compareTo(a.createdDateTime!));
      update();
    }, error: (message) {
      UtilsServices.showFlutterToast(message: message, isError: true);
    });
  }
}
