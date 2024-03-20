import 'package:add_to_cart_animation/add_to_cart_icon.dart';
import 'package:flutter/material.dart';
import 'package:quitanda_app/src/core/theme/colors.dart';
import 'package:quitanda_app/src/core/utils/formatters.dart';
import 'package:quitanda_app/src/models/item_model.dart';
import 'package:quitanda_app/src/pages/product/screens/product_screen.dart';

class ItemTile extends StatelessWidget {
  final ItemModel item;
  final Function(GlobalKey<State<StatefulWidget>> gkImage) cartAnimationMethod;
  final GlobalKey<CartIconKey> imageGk = GlobalKey();

  ItemTile({
    super.key,
    required this.item,
    required this.cartAnimationMethod,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InkWell(
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ProductScreen(item: item))),
          child: Card(
            color: Colors.white,
            elevation: 1,
            shadowColor: Colors.grey.shade300,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Hero(
                      tag: item.imgUrl,
                      child: Container(
                        key: imageGk,
                        child: Image.asset(
                          item.imgUrl,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    item.itemName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        Formatters.priceToCurrency(item.price),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: CustomColors.customSwatchColor,
                        ),
                      ),
                      Text(
                        '/${item.unit}',
                        style: TextStyle(
                          color: Colors.grey.shade500,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: 4,
          right: 4,
          child: InkWell(
            onTap: () => cartAnimationMethod(imageGk),
            child: Container(
              decoration: BoxDecoration(
                color: CustomColors.customSwatchColor,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(20),
                  bottomLeft: Radius.circular(15),
                ),
              ),
              height: 40,
              width: 35,
              child: const Icon(
                Icons.add_shopping_cart,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
