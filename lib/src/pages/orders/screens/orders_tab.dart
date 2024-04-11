import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:quitanda_app/src/pages/orders/controllers/orders_controller.dart';
import 'package:quitanda_app/src/pages/orders/screens/components/order_tile.dart';

class OrdersTab extends StatelessWidget {
  const OrdersTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders'),
      ),
      body: GetBuilder<OrdersController>(
        builder: (ordersController) {
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            separatorBuilder: (_, index) => const SizedBox(height: 10),
            itemCount: ordersController.orders.length,
            itemBuilder: (_, index) {
              return OrderTile(order: ordersController.orders[index]);
            },
          );
        },
      ),
    );
  }
}
