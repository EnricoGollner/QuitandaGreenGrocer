import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatefulWidget {
  final IconData icon;
  final String labelText;
  final bool isSecret;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;

  const CustomTextField({
    super.key,
    required this.icon,
    required this.labelText,
    this.isSecret = false,
    this.keyboardType,
    this.inputFormatters,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool _isVisible;

  @override
  void initState() {
    _isVisible = widget.isSecret;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextFormField(
        onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
        obscureText: _isVisible,
        decoration: InputDecoration(
          isDense: true,
          prefixIcon: Icon(widget.icon),
          suffixIcon: widget.isSecret
              ? IconButton(
                  onPressed: () {
                    setState(() => _isVisible = !_isVisible);
                  },
                  icon: Icon(
                      _isVisible ? Icons.visibility : Icons.visibility_off),
                )
              : null,
          labelText: widget.labelText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
        keyboardType: widget.keyboardType,
        inputFormatters: widget.inputFormatters,
      ),
    );
  }
}
