import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quitanda_app/src/core/theme/colors.dart';
import 'package:quitanda_app/src/core/utils/formatters.dart';
import 'package:quitanda_app/src/models/item_model.dart';
import 'package:quitanda_app/src/pages/base/common_widgets/quantity_widget.dart';
import 'package:quitanda_app/src/pages/base/controllers/navigation_controller.dart';
import 'package:quitanda_app/src/pages/cart/controllers/cart_controller.dart';

class ProductScreen extends StatefulWidget {
  final ItemModel item;

  const ProductScreen({super.key, required this.item});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  int carItemQuantity = 1;

  final CartController _cartController = Get.find<CartController>(); 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withAlpha(230),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: Hero(
                  tag: widget.item.imgUrl,
                  child: Image.network(widget.item.imgUrl),
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(32),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(50),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade600,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              widget.item.itemName,
                              maxLines: 2,
                              style: const TextStyle(
                                fontSize: 27,
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          QuantityWidget(
                            quantity: carItemQuantity,
                            unityText: widget.item.unit,
                            updateQuantity: (newQuantity) {
                              setState(() => carItemQuantity = newQuantity);
                            },
                          ),
                        ],
                      ),
                      Text(
                        Formatters.priceToCurrency(widget.item.price),
                        style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                          color: CustomColors.customSwatchColor,
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: SingleChildScrollView(
                            child: Text(
                              widget.item.description,
                              style: const TextStyle(
                                height: 1.5,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white),
                          onPressed: () async {
                            Get.back();

                            await _cartController.addItemToCart(item: widget.item, quantity: carItemQuantity);

                            Get.find<NavigationController>().navigatePageView(NavigationTabs.cart);
                          },
                          label: const Text('Add to cart',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              )),
                          icon: const Icon(
                            Icons.shopping_cart_outlined,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            top: 10,
            left: 10,
            child: SafeArea(
              child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(
                  Icons.arrow_back_ios,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
