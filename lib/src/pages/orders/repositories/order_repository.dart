import 'package:quitanda_app/src/constants/endpoints.dart';
import 'package:quitanda_app/src/models/order_model.dart';
import 'package:quitanda_app/src/pages/orders/orders_result/orders_result.dart';
import 'package:quitanda_app/src/services/http_manager.dart';

class OrdersRepository {
  final HTTPManager _httpManager = HTTPManager();

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
