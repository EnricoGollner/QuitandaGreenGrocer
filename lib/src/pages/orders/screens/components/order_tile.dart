import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quitanda_app/src/core/utils/formatters.dart';
import 'package:quitanda_app/src/models/cart_item_model.dart';
import 'package:quitanda_app/src/models/order_model.dart';
import 'package:quitanda_app/src/pages/base/common_widgets/payment_dialog.dart';
import 'package:quitanda_app/src/pages/orders/controllers/order_controller.dart';
import 'package:quitanda_app/src/pages/orders/screens/components/order_status_widget.dart';

class OrderTile extends StatelessWidget {
  final OrderModel order;

  const OrderTile({super.key, required this.order});
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: GetBuilder<OrderController>(
          init: OrderController(order: order),
          global: false,
          builder: (orderController) {
            return ExpansionTile(
              onExpansionChanged: (value) async {
                if (value && order.items.isEmpty) {
                  await orderController.getOrderItems(orderId: order.id);
                }
              },
              title: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Pedido ${order.id}'),
                  Text(
                    Formatters.formatDatetime(order.createdDateTime!),
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
              children: orderController.isLoading
                ? [
                  Container(
                    height: 100,
                    alignment: Alignment.center,
                    child: const CircularProgressIndicator(),
                  )
                ]
                : [
                    IntrinsicHeight(
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: SizedBox(
                              height: 150,
                              child: ListView.builder(
                                itemCount: orderController.order.items.length,
                                itemBuilder: (context, index) {
                                  final CartItemModel orderItem = orderController.order.items[index];
                                  return _OrderItemWidget(orderItem: orderItem);
                                },
                              ),
                            ),
                          ),
                          VerticalDivider(
                            color: Colors.grey.shade300,
                            thickness: 2,
                            width: 8,
                          ),
                          Expanded(
                            flex: 2,
                            child: OrderStatusWidget(
                              status: order.status,
                              isOverdue: order.overdueDateTime.isBefore(DateTime.now()),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text.rich(
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                      TextSpan(
                        children: [
                          const TextSpan(
                            text: 'Total ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(text: Formatters.priceToCurrency(order.total))
                        ],
                      ),
                    ),
                    Visibility(
                      visible: order.status == 'pending_payment' && !order.isOverdue,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          showDialog(context: context, builder: (context){
                            return PaymentDialog(order: order);
                          });
                        },
                        icon: const Icon(Icons.pix),
                        label: const Text('Pix QR Code'),
                      ),
                    ),
                  ],
            );
          }
        )
      ),
    );
  }
}

class _OrderItemWidget extends StatelessWidget {
  const _OrderItemWidget({
    required this.orderItem,
  });

  final CartItemModel orderItem;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Text(
            '${orderItem.quantity} ${orderItem.item.unit}',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(child: Text(orderItem.item.itemName)),
          Text(
            Formatters.priceToCurrency(orderItem.totalPrice()),
          ),
        ],
      ),
    );
  }
}
