import 'package:get/get.dart';
import 'package:quitanda_app/src/core/pages_routes/app_pages.dart';
import 'package:quitanda_app/src/core/utils/toast_util.dart';
import 'package:quitanda_app/src/models/user_model.dart';
import 'package:quitanda_app/src/pages/auth/repositories/auth_repository.dart';
import 'package:quitanda_app/src/pages/auth/result/auth_result.dart';

class AuthController extends GetxController {
  final RxBool isLoading = false.obs;
  UserModel user = UserModel();

  final AuthRepository _authRepository = AuthRepository();

  Future<void> signIn({required String email, required String password}) async {
    isLoading.value = true;

    AuthResult result = await _authRepository.signIn(email: email, password: password);
    isLoading.value = false;

    result.when(success: (user) {
      this.user = user;
      Get.offAllNamed(PagesRoutes.base);
    }, error: (message) {
      FlutterToastUtil.show(message: message, isError: true);
    });
  }
}
