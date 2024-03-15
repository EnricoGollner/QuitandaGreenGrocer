import 'package:flutter/material.dart';
import 'package:quitanda_app/src/core/utils/app_data.dart' as app_data;
import 'package:quitanda_app/src/pages/orders/screens/components/order_tile.dart';

class OrdersTab extends StatelessWidget {
  const OrdersTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Orders'),
        ),
        body: ListView.separated(
          padding: const EdgeInsets.all(16),
          separatorBuilder: (_, index) => const SizedBox(height: 10),
          itemCount: app_data.orders.length,
          itemBuilder: (_, index) {
            return OrderTile(order: app_data.orders[index]);
          },
        ));
  }
}
