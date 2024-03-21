import 'package:quitanda_app/src/constants/endpoints.dart';
import 'package:quitanda_app/src/models/user_model.dart';
import 'package:quitanda_app/src/pages/auth/repositories/auth_errors.dart'as auth_errors;
import 'package:quitanda_app/src/pages/auth/result/auth_result.dart';
import 'package:quitanda_app/src/services/http_manager.dart';

class AuthRepository {
  final HTTPManager _httpManager = HTTPManager();

  Future<AuthResult> validateToken(String token) async {
    final Map result = await _httpManager.restRequest(
      url: Endpoints.validateToken,
      method: HTTPMethods.post,
      headers: {
        'X-Parse-Session-Token': token,
      }
    );

    if (result['result'] != null) {
      final UserModel user = UserModel.fromJson(result['result']);
      return AuthResult.success(user);
    } else {
      return AuthResult.error(
        auth_errors.authErrorsString(result['error']),
      );
    }
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

    if (result['result'] != null) {
      final UserModel user = UserModel.fromJson(result['result']);
      return AuthResult.success(user);
    } else {
      return AuthResult.error(
        auth_errors.authErrorsString(result['error']),
      );
    }
  }
}
