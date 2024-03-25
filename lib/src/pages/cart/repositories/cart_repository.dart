import 'package:quitanda_app/src/constants/endpoints.dart';
import 'package:quitanda_app/src/services/http_manager.dart';

class CartRepository {
  final HTTPManager _httpManager = HTTPManager();

  Future getCartItems({required String token, required String userId}) async {
    final Map result = await _httpManager.restRequest(
      url: Endpoints.getCartItems,
      method: HTTPMethods.post,
      headers: {
        'X-Parse-Application-Id': token,
      },
      body: {
        'user': userId
      },
    );

    if (result['result'] != null) {

    } else {

    }
  }
}
