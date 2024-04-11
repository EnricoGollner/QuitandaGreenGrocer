import 'package:quitanda_app/src/constants/endpoints.dart';
import 'package:quitanda_app/src/models/user_model.dart';
import 'package:quitanda_app/src/pages/auth/repositories/auth_errors.dart'
    as auth_errors;
import 'package:quitanda_app/src/pages/auth/result/auth_result.dart';
import 'package:quitanda_app/src/services/http_manager.dart';

class AuthRepository {
  final HTTPManager _httpManager = HTTPManager();

  Future<bool> changePassword({
    required String token,
    required String email,
    required String currentPassword,
    required String newPassword,
  }) async {
    final result = await _httpManager.restRequest(
      url: Endpoints.changePassword,
      method: HTTPMethods.post,
      headers: {
        'X-Parse-Session-Token': token,
      },
      body: {
        'email': email,
        'currentPassword': currentPassword,
        'newPassword': newPassword,
      }
    );

    return result['error'] == null;
  }

  Future<AuthResult> validateToken(String token) async {
    final Map result = await _httpManager.restRequest(
        url: Endpoints.validateToken,
        method: HTTPMethods.post,
        headers: {
          'X-Parse-Session-Token': token,
        });

    return _handleResult(result);
  }

  Future<AuthResult> signIn(
      {required String email, required String password}) async {
    final Map result = await _httpManager.restRequest(
      url: Endpoints.signIn,
      method: HTTPMethods.post,
      body: {
        'email': email,
        'password': password,
      },
    );

    return _handleResult(result);
  }

  Future<AuthResult> signUp({required UserModel user}) async {
    final Map result = await _httpManager.restRequest(
      url: Endpoints.signUp,
      method: HTTPMethods.post,
      body: user.toJson(),
    );

    return _handleResult(result);
  }

  Future<void> resetPassword({required String email}) async {
    await _httpManager.restRequest(
      url: Endpoints.ressetPassword,
      method: HTTPMethods.post,
      body: {'email': email},
    );
  }

  AuthResult _handleResult(Map result) {
    if (result['result'] != null) {
      final UserModel user = UserModel.fromJson(result['result']);
      return AuthResult.success(user);
    } else {
      return AuthResult.error(
        auth_errors.handleAuthErrors(result['error']),
      );
    }
  }
}
