import 'package:flutter/material.dart';
import 'package:quitanda_app/src/core/theme/colors.dart';
import 'package:quitanda_app/src/core/utils/app_data.dart' as app_data;
import 'package:quitanda_app/src/pages/home/components/category_tile.dart';
import 'package:quitanda_app/src/pages/home/components/item_tile.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  String selectedCategory = 'Frutas';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text.rich(
          TextSpan(
            style: const TextStyle(fontSize: 30),
            children: [
              TextSpan(
                text: 'Green',
                style: TextStyle(color: CustomColors.customSwatchColor),
              ),
              TextSpan(
                text: 'Grocer',
                style: TextStyle(color: CustomColors.customContrastColor),
              ),
            ],
          ),
        ),
        actions: [
          Badge(
            backgroundColor: CustomColors.customContrastColor,
            offset: const Offset(-7, 7),
            label: const Text(
              '2',
              style: TextStyle(fontSize: 12),
            ),
            child: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.shopping_cart,
                color: CustomColors.customSwatchColor,
              ),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: TextFormField(
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
                hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
                prefixIcon: Icon(
                  Icons.search,
                  color: CustomColors.customContrastColor,
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 25),
            height: 40,
            child: ListView.separated(
              // Categories
              separatorBuilder: (_, __) => const SizedBox(width: 10),
              itemCount: app_data.categories.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return CategoryTile(
                  categoryName: app_data.categories[index],
                  isSelected: app_data.categories[index] == selectedCategory,
                  onTap: () {
                    setState(
                        () => selectedCategory = app_data.categories[index]);
                  },
                );
              },
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              physics: const BouncingScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 9 / 11.5,
              ),
              itemCount: app_data.items.length,
              itemBuilder: (_, index) { 
                return ItemTile(item: app_data.items[index]);
              },
            ),
          )
        ],
      ),
    );
  }
}
