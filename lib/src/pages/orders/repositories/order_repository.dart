import 'package:quitanda_app/src/constants/endpoints.dart';
import 'package:quitanda_app/src/models/cart_item_model.dart';
import 'package:quitanda_app/src/models/order_model.dart';
import 'package:quitanda_app/src/pages/orders/orders_result/orders_result.dart';
import 'package:quitanda_app/src/services/http_manager.dart';

class OrdersRepository {
  final HTTPManager _httpManager = HTTPManager();

  Future<OrdersResult<List<CartItemModel>>> getOrderItems({
    required String orderId,
    required String token,
  }) async {
    final Map result = await _httpManager.restRequest(
      url: Endpoints.getOrderItems,
      method: HTTPMethods.post,
      headers: {
        'X-Parse-Session-Token': token,
      },
      body: {
        'orderId': orderId
      },
    );

    if (result['result'] != null) {
      final List<CartItemModel> items = List<Map<String, dynamic>>.from(result['result'])
          .map(CartItemModel.fromJson)
          .toList();
      return OrdersResult<List<CartItemModel>>.success(items);
    } else {
      return OrdersResult.error('Não foi possível carregar os itens do pedido.');
    }
  }

  Future<OrdersResult<List<OrderModel>>> getAllOrders({
    required String userId,
    required String token,
  }) async {
    final Map result = await _httpManager.restRequest(
      url: Endpoints.getAllOrders,
      method: HTTPMethods.post,
      body: {
        'user': userId,
      },
      headers: {
        'X-Parse-Application-Id': token,
      },
    );

    if (result['result'] != null) {
      List<OrderModel> orders =
          List<Map<String, dynamic>>.from(result['result'])
              .map(OrderModel.fromJson)
              .toList();
      return OrdersResult<List<OrderModel>>.success(orders);
    } else {
      return OrdersResult.error('Não foi possível carregar os pedidos.');
    }
  }
}
