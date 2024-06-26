import 'package:get/get.dart';
import 'package:quitanda_app/src/constants/storage_keys.dart';
import 'package:quitanda_app/src/core/utils/app_pages.dart';
import 'package:quitanda_app/src/core/utils/utils_services.dart';
import 'package:quitanda_app/src/models/user_model.dart';
import 'package:quitanda_app/src/pages/auth/repositories/auth_repository.dart';
import 'package:quitanda_app/src/pages/auth/result/auth_result.dart';
import 'package:quitanda_app/src/pages/base/repositories/local_data_repository.dart';

class AuthController extends GetxController {
  final RxBool isLoading = false.obs;
  UserModel user = UserModel();

  final AuthRepository _authRepository = AuthRepository();
  final LocalDataRepository _localDataRepository = LocalDataRepository();

  Future<void> _saveTokenAndProceedToBase() async {
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
        UtilsServices.showFlutterToast(message: message, isError: true);
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
      await _saveTokenAndProceedToBase();
    }, error: (message) {
      UtilsServices.showFlutterToast(message: message, isError: true);
    });
  }

  Future<void> signUp() async {
    isLoading.value = true;
    AuthResult result = await _authRepository.signUp(user: user);
    isLoading.value = false;

    result.when(success: (user) async {
      this.user = user;
      await _saveTokenAndProceedToBase();
    }, error: (message) {
      UtilsServices.showFlutterToast(message: message, isError: true);
    });
  }

  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    isLoading.value = true;
    final result = await _authRepository.changePassword(
      token: user.token!,
      email: user.email!,
      currentPassword: currentPassword,
      newPassword: newPassword,
    );
    isLoading.value = false;
    
    if (result) {
      UtilsServices.showFlutterToast(message: 'Password changed successfully');
      await signOut();
    } else {
      UtilsServices.showFlutterToast(message: 'Failed to change password - Current Passwrod is incorrect', isError: true);
    }
  }

  Future<void> resetPassword(String email) async {
    isLoading.value = true;
    await _authRepository.resetPassword(email: email);
    isLoading.value = false;
  }
  
  Future<void> signOut() async {
    user = UserModel();
    await _localDataRepository.removeLocalData(key: StorageKeys.token);
    Get.offAllNamed(PagesRoutes.signIn);
  }
}
