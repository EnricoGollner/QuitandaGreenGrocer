import 'package:flutter/material.dart';
import 'package:quitanda_app/src/core/theme/colors.dart';
import 'package:quitanda_app/src/core/utils/formatters.dart';
import 'package:quitanda_app/src/models/cart_item_model.dart';
import 'package:quitanda_app/src/pages/base/common_widgets/quantity_widget.dart';

class CartTile extends StatefulWidget {
  final CartItemModel cartItem;
  final Function(CartItemModel cartItem) removeItem;

  const CartTile({
    super.key,
    required this.cartItem,
    required this.removeItem,
  });

  @override
  State<CartTile> createState() => _CartTileState();
}

class _CartTileState extends State<CartTile> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        leading: Image.asset(
          widget.cartItem.item.imgUrl,
          height: 60,
          width: 60,
        ),
        title: Text(
          widget.cartItem.item.itemName,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: Text(
          Formatters.priceToCurrency(widget.cartItem.totalPrice()),
          style: TextStyle(
            color: CustomColors.customSwatchColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: QuantityWidget(
          quantity: widget.cartItem.quantity,
          unityText: widget.cartItem.item.unit,
          isRemovable: true,
          updateQuantity: (newQuantity) {
            setState(() {
              widget.cartItem.quantity = newQuantity;

              if (newQuantity == 0) {
                widget.removeItem(widget.cartItem);
              }
            });
          },
        ),
      ),
    );
  }
}
