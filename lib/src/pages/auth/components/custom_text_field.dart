import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatefulWidget {
  final String? initialValue;
  final TextEditingController? controller;
  final void Function(String? value)? onSaved;
  final IconData icon;
  final String labelText;
  final bool isSecret;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final bool isReadOnly;
  final String? Function(String?)? validator;

  const CustomTextField({
    super.key,
    this.controller,
    this.onSaved,
    this.initialValue,
    required this.icon,
    required this.labelText,
    this.isSecret = false,
    this.keyboardType,
    this.inputFormatters,
    this.isReadOnly = false,
    this.validator,
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
        controller: widget.controller,
        onSaved: widget.onSaved,
        readOnly: widget.isReadOnly,
        initialValue: widget.initialValue,
        obscureText: _isVisible,
        validator: widget.validator,
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
