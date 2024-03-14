import 'package:flutter/material.dart';
import 'package:quitanda_app/src/core/theme/colors.dart';

class QuantityWidget extends StatefulWidget {
  final int quantity;
  final String unityText;
  final Function(int quantity) updateQuantity;
  final bool isRemovable;

  const QuantityWidget({
    super.key,
    required this.quantity,
    required this.unityText,
    required this.updateQuantity,
    this.isRemovable = false,
  });

  @override
  State<QuantityWidget> createState() => _QuantityWidgetState();
}

class _QuantityWidgetState extends State<QuantityWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(50),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            spreadRadius: 1,
            blurRadius: 2,
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _QuantityButton(
            icon: !widget.isRemovable || widget.quantity> 1 ? Icons.remove : Icons.delete_forever,
            color: !widget.isRemovable || widget.quantity> 1 ? Colors.grey : Colors.red,
            onTap: () {
              if (widget.quantity == 1 && !widget.isRemovable) return;

              int updatedQuantity = widget.quantity - 1;
              widget.updateQuantity(updatedQuantity);
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: Text(
              '${widget.quantity}${widget.unityText}',
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          _QuantityButton(
            icon: Icons.add,
            color: CustomColors.customSwatchColor,
            onTap: () {
              int updatedQuantity = widget.quantity + 1;
              widget.updateQuantity(updatedQuantity);
            },
          ),
        ],
      ),
    );
  }
}

class _QuantityButton extends StatelessWidget {
  final Color color;
  final IconData icon;
  final VoidCallback onTap;

  const _QuantityButton({required this.color, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        borderRadius: BorderRadius.circular(50),
        onTap: onTap,
        child: Ink(
          height: 25,
          width: 25,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: Colors.white,
            size: 16,
          ),
        ),
      ),
    );
  }
}
