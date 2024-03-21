import 'package:get/get.dart';
import 'package:quitanda_app/src/constants/storage_keys.dart';
import 'package:quitanda_app/src/core/pages_routes/app_pages.dart';
import 'package:quitanda_app/src/core/utils/toast_util.dart';
import 'package:quitanda_app/src/models/user_model.dart';
import 'package:quitanda_app/src/pages/auth/repositories/auth_repository.dart';
import 'package:quitanda_app/src/pages/auth/result/auth_result.dart';
import 'package:quitanda_app/src/pages/base/repositories/local_data_repository.dart';

class AuthController extends GetxController {
  final RxBool isLoading = false.obs;
  UserModel user = UserModel();

  final AuthRepository _authRepository = AuthRepository();
  final LocalDataRepository _localDataRepository = LocalDataRepository();

  Future<void> saveTokenAndProceedToBase() async {
    await _localDataRepository.saveLocalData(key: StorageKeys.token, value: user.token!);
    Get.offAllNamed(PagesRoutes.base);
  }

  Future<void> validateToken() async {
    String? token = await _localDataRepository.getLocalData(key: StorageKeys.token);
    
    if (token == null) return Get.offAllNamed(PagesRoutes.signIn);

    await _authRepository.validateToken(token).then((result) {
      result.when(success: (user) {
        this.user = user;
        Get.offAllNamed(PagesRoutes.base);
      }, error: (message) {
        FlutterToastUtil.show(message: message, isError: true);
        signOut();
      });
    });
  }

  Future<void> signIn({required String email, required String password}) async {
    isLoading.value = true;

    AuthResult result = await _authRepository.signIn(email: email, password: password);
    isLoading.value = false;

    result.when(success: (user) async {
      this.user = user;
      await saveTokenAndProceedToBase();
    }, error: (message) {
      FlutterToastUtil.show(message: message, isError: true);
    });
  }

  Future<void> signUp() async {
    isLoading.value = true;

    AuthResult result = await _authRepository.signUp(user: user);
    isLoading.value = false;

    result.when(success: (user) async {
      this.user = user;
      await saveTokenAndProceedToBase();
    }, error: (message) {
      FlutterToastUtil.show(message: message, isError: true);
    });
  }
  
  Future<void> signOut() async {
    user = UserModel();
    await _localDataRepository.removeLocalData(key: StorageKeys.token);
    Get.offAllNamed(PagesRoutes.signIn);
  }
}
