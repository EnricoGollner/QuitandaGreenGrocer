import 'package:add_to_cart_animation/add_to_cart_animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quitanda_app/src/core/theme/colors.dart';
import 'package:quitanda_app/src/models/category_model.dart';
import 'package:quitanda_app/src/models/item_model.dart';
import 'package:quitanda_app/src/pages/base/common_widgets/custom_shimmer.dart';
import 'package:quitanda_app/src/pages/base/controllers/navigation_controller.dart';
import 'package:quitanda_app/src/pages/cart/controllers/cart_controller.dart';
import 'package:quitanda_app/src/pages/home/components/app_name_widget.dart';
import 'package:quitanda_app/src/pages/home/components/category_tile.dart';
import 'package:quitanda_app/src/pages/home/components/item_tile.dart';
import 'package:quitanda_app/src/pages/home/controllers/home_controller.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  final GlobalKey<CartIconKey> globalKeyCartItems = GlobalKey();
  late Function(GlobalKey) runAddToCardAnimation;

  final TextEditingController _searchController = TextEditingController();

  void itemSelectedCartAnimations(GlobalKey gkImage) {
    runAddToCardAnimation(gkImage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AddToCartAnimation(
        cartKey: globalKeyCartItems,
        jumpAnimation: const JumpAnimationOptions(
          duration: Duration(milliseconds: 100),
          curve: Curves.ease,
        ),
        createAddToCartAnimation: (addToCartAnimation) {
          runAddToCardAnimation = addToCartAnimation;
        },
        child: Column(
          children: [
            AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              centerTitle: true,
              title: const AppNameWidget(),
              actions: [
                GetBuilder<CartController>(
                  builder: (cartController) {
                    return Badge(
                      backgroundColor: CustomColors.customContrastColor,
                      offset: const Offset(-14, 7),
                      label: Text(
                        cartController.cartItems.length.toString(),
                        style: const TextStyle(fontSize: 12),
                      ),
                      child: IconButton(
                        onPressed: () {
                          Get.find<NavigationController>().navigatePageView(NavigationTabs.cart);
                        },
                        icon: AddToCartIcon(
                          key: globalKeyCartItems,
                          badgeOptions: const BadgeOptions(active: false),
                          icon: Icon(
                            Icons.shopping_cart,
                            color: CustomColors.customSwatchColor,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
            //Campo de Pesquisa
            GetBuilder<HomeController>(
              builder: (homeController) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: TextFormField(
                    controller: _searchController,
                    onTapOutside: (_) =>
                        FocusManager.instance.primaryFocus!.unfocus(),
                    onChanged: (value) {
                      homeController.searchTitle.value = value;
                    },
                    decoration: InputDecoration(
                      filled: true,
                      isDense: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(60),
                        borderSide: const BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                      ),
                      hintText: 'Pesquise aqui...',
                      hintStyle:
                          TextStyle(color: Colors.grey.shade400, fontSize: 14),
                      prefixIcon: Icon(
                        Icons.search,
                        color: CustomColors.customContrastColor,
                      ),
                      suffixIcon: homeController.searchTitle.isNotEmpty
                          ? IconButton(
                              onPressed: () {
                                _searchController.clear();
                                homeController.searchTitle.value = '';
                                FocusManager.instance.primaryFocus!.unfocus();
                              },
                              icon: Icon(
                                Icons.close,
                                color: CustomColors.customContrastColor,
                                size: 21,
                              ),
                            )
                          : null,
                    ),
                  ),
                );
              },
            ),
            GetBuilder<HomeController>(builder: (controller) {
              return Container(
                  padding: const EdgeInsets.only(left: 25),
                  height: 40,
                  child: !controller.isCategoryLoading
                      ? ListView.separated(
                          separatorBuilder: (_, __) =>
                              const SizedBox(width: 10),
                          itemCount: controller.allCategories.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            final CategoryModel category =
                                controller.allCategories[index];
                            return CategoryTile(
                              categoryName: category.title,
                              isSelected:
                                  category == controller.currentCategory,
                              onTap: () => controller.selectCategory(category),
                            );
                          },
                        )
                      : ListView.separated(
                          separatorBuilder: (_, __) =>
                              const SizedBox(width: 10),
                          itemCount: 5,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Align(
                              alignment: Alignment.center,
                              child: CustomShimmer(
                                height: 22,
                                width: 80,
                                borderRadius: BorderRadius.circular(20),
                              ),
                            );
                          },
                        ));
            }),
            GetBuilder<HomeController>(builder: (homeController) {
              return Expanded(
                child: !homeController.isProductLoading
                    ? Visibility(
                        visible: (homeController.currentCategory?.items ?? [])
                            .isNotEmpty,
                        replacement: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.search_off,
                              size: 40,
                              color: CustomColors.customSwatchColor,
                            ),
                            const Text('Não há itens para apresentar'),
                          ],
                        ),
                        child: GridView.builder(
                          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                          physics: const BouncingScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                            childAspectRatio: 9 / 11.5,
                          ),
                          itemCount: homeController.allProducts.length,
                          itemBuilder: (_, index) {
                            if (index + 1 ==
                                    homeController.allProducts.length &&
                                !homeController.isLastPage) {
                              // last product of the list
                              homeController.loadMoreProducts();
                            }

                            final ItemModel item =
                                homeController.allProducts[index];
                            return ItemTile(
                              item: item,
                              cartAnimationMethod: itemSelectedCartAnimations,
                            );
                          },
                        ),
                      )
                    : GridView.count(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                        physics: const BouncingScrollPhysics(),
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        childAspectRatio: 9 / 11.5,
                        children: List.generate(
                          10,
                          (index) => CustomShimmer(
                            height: double.infinity,
                            width: double.infinity,
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
              );
            })
          ],
        ),
      ),
    );
  }
}
