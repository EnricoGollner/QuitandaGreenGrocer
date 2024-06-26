import 'package:add_to_cart_animation/add_to_cart_icon.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quitanda_app/src/core/theme/colors.dart';
import 'package:quitanda_app/src/core/utils/app_pages.dart';
import 'package:quitanda_app/src/core/utils/formatters.dart';
import 'package:quitanda_app/src/models/item_model.dart';
import 'package:quitanda_app/src/pages/cart/controllers/cart_controller.dart';

class ItemTile extends StatefulWidget {
  final ItemModel item;
  final Function(GlobalKey<State<StatefulWidget>> gkImage) cartAnimationMethod;

  const ItemTile({
    super.key,
    required this.item,
    required this.cartAnimationMethod,
  });

  @override
  State<ItemTile> createState() => _ItemTileState();
}

class _ItemTileState extends State<ItemTile> {
  final GlobalKey<CartIconKey> imageGk = GlobalKey();

  late CartController _cartController;

  IconData tileIcon = Icons.add_shopping_cart_outlined;

  Future<void> _switchIcon() async {
    setState(() => tileIcon = Icons.check);
    await Future.delayed(const Duration(milliseconds: 2000));
    setState(() => tileIcon = Icons.add_shopping_cart_outlined);
  }

  @override
  void initState() {
    _cartController = Get.find<CartController>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InkWell(
          onTap: () => Get.toNamed(PagesRoutes.product, arguments: widget.item),
          child: Card(
            elevation: 1,
            color: Colors.white,
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
                      tag: widget.item.imgUrl,
                      child: Container(
                        key: imageGk,
                        child: Image.network(
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                            );
                          },
                          widget.item.imgUrl,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    widget.item.itemName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        Formatters.priceToCurrency(widget.item.price),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: CustomColors.customSwatchColor,
                        ),
                      ),
                      Text(
                        '/${widget.item.unit}',
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
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(20),
              bottomLeft: Radius.circular(15),
            ),
            child: Material(
              child: InkWell(
                onTap: () async {
                  widget.cartAnimationMethod(imageGk);
                  await _cartController.addItemToCart(item: widget.item);
                  await _switchIcon();
                },
                child: Ink(
                  decoration: BoxDecoration(
                    color: CustomColors.customSwatchColor,
                  ),
                  height: 40,
                  width: 35,
                  child: Icon(
                    tileIcon,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
