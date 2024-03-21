import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class AuthController extends GetxController {
  final RxBool isLoading = false.obs;

  Future<void> signIn({required String email, required String password}) async {
    isLoading.value = true;

    await Future.delayed(const Duration(seconds: 2), () {
      isLoading.value = false;
    });

    isLoading.value = false;
  }
}