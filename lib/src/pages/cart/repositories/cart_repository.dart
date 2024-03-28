import 'package:quitanda_app/src/constants/endpoints.dart';
import 'package:quitanda_app/src/models/cart_item_model.dart';
import 'package:quitanda_app/src/pages/cart/cart_result/cart_result.dart';
import 'package:quitanda_app/src/services/http_manager.dart';

class CartRepository {
  final HTTPManager _httpManager = HTTPManager();

  Future<CartResult<List<CartItemModel>>> getCartItems(
      {required String token, required String userId}) async {
    final Map result = await _httpManager.restRequest(
      url: Endpoints.getCartItems,
      method: HTTPMethods.post,
      headers: {
        'X-Parse-Application-Id': token,
      },
      body: {'user': userId},
    );

    if (result['result'] != null) {
      List<CartItemModel> data =
          List<Map<String, dynamic>>.from(result['result'])
              .map(CartItemModel.fromJson)
              .toList();
      return CartResult<List<CartItemModel>>.success(data);
    } else {
      return CartResult.error(
          'Ocorreu um erro ao recuperar os itens do carrinho.');
    }
  }

  Future<CartResult<String>> addItemToCart({
    required String userId,
    required String token,
    required String productId,
    required int quantity,
  }) async {
    final result = await _httpManager.restRequest(
      url: Endpoints.addItemsToCart,
      method: HTTPMethods.post,
      body: {
        'user': userId,
        'qauntity': quantity,
        'productId': productId,
      },
      headers: {
        'X-Parse-Session-Token': token,
      },
    );

    if (result['result'] != null) {
      return CartResult<String>.success(result['result']['id']);
    } else {
      return CartResult.error('Ocorreu um erro ao adicionar o item ao carrinho.');
    }
  }
}
