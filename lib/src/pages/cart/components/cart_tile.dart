import 'package:flutter/material.dart';
import 'package:quitanda_app/src/models/cart_item_model.dart';

class CartTile extends StatelessWidget {
  final CartItemModel cartItem;

  const CartTile({super.key, required this.cartItem});

  @override
  Widget build(BuildContext context) {
    return Card(child: ListTile(
      leading: Image.asset(cartItem.item.imgUrl),
    ),);
  }
}
