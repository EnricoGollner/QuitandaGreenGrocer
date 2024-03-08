import 'package:flutter/material.dart';
import 'package:quitanda_app/src/core/theme/colors.dart';

class CategoryTile extends StatelessWidget {
  final String categoryName;
  final bool isSelected;
  final VoidCallback onTap;

  const CategoryTile({
    super.key,
    required this.categoryName,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: InkWell(
        onTap: onTap,
        child: Ink(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: isSelected ? CustomColors.customSwatchColor : Colors.transparent,
            ),
            child: Text(
              categoryName,
              style: TextStyle(
                color: isSelected ? Colors.white : CustomColors.customContrastColor,
                fontWeight: FontWeight.bold,
                fontSize: isSelected ? 16 : 14,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
