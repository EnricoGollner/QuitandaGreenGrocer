import 'package:get/get.dart';
import 'package:quitanda_app/src/pages/orders/controllers/orders_controller.dart';

class OrdersBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OrdersController());
  }
}