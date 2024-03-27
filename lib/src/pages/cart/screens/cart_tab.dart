import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:quitanda_app/src/core/theme/colors.dart';
import 'package:quitanda_app/src/core/utils/formatters.dart';
import 'package:quitanda_app/src/core/utils/toast_util.dart';
import 'package:quitanda_app/src/models/order_model.dart';
import 'package:quitanda_app/src/pages/base/common_widgets/payment_dialog.dart';
import 'package:quitanda_app/src/pages/cart/components/cart_tile.dart';
import 'package:quitanda_app/src/pages/cart/controllers/cart_controller.dart';

class CartTab extends StatefulWidget {
  const CartTab({super.key});

  @override
  State<CartTab> createState() => _CartTabState();
}

class _CartTabState extends State<CartTab> {
  double cartTotalPrice() {
    double total = 0;

    // for (var cartItem in app_data.cartItems) {
    //   total += cartItem.totalPrice();
    // }

    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrinho'),
      ),
      body: Column(
        children: [
          Expanded(
            child: GetBuilder<CartController>(
              builder: (controller) {
                return ListView.builder(
                  itemCount: controller.cartItems.length,
                  itemBuilder: (_, index) {
                    return CartTile(
                      cartItem: controller.cartItems[index],
                    );
                  },
                );
              },
            ),
          ),
          Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(50),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300,
                    blurRadius: 3,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Total geral',
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                  GetBuilder<CartController>(
                    builder: (controller) {
                      return Text(
                        Formatters.priceToCurrency(controller.cartTotalPrice()),
                        style: TextStyle(
                          fontSize: 23,
                          color: CustomColors.customSwatchColor,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: CustomColors.customSwatchColor,
                      ),
                      onPressed: () async {
                        _showOrderConfirmation().then((result) {
                          if (result ?? false) {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return PaymentDialog(
                                  order: OrderModel(
                                    id: '',
                                    createdDateTime: DateTime.now(),
                                    overdueDateTime: DateTime.now()
                                        .add(const Duration(hours: 1)),
                                    items: [],
                                    status: 'pending_payment',
                                    copyAndPaste: '',
                                    total: cartTotalPrice(),
                                  ),
                                );
                              },
                            );
                          } else {
                            FlutterToastUtil.show(
                                message: 'Order not confirmed!', isError: true);
                          }
                        });
                      },
                      child: const Text(
                        'Finish Order',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                  )
                ],
              ))
        ],
      ),
    );
  }

  Future<bool?> _showOrderConfirmation() {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text('Confirmation'),
          content: const Text('Finish order?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('CANCEL'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: CustomColors.customSwatchColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: () => Navigator.pop(context, true),
              child: const Text('CONFIRM'),
            ),
          ],
        );
      },
    );
  }
}
