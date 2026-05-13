import 'package:flutter/material.dart';

class FilterTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final String? prefixText;
  final IconData? icon;

  const FilterTextField({
    super.key,
    required this.controller,
    required this.hint,
    this.prefixText,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        hintText: hint,
        prefixText: prefixText,
        prefixIcon: icon != null ? Icon(icon, size: 20) : null,
        filled: true,
        fillColor: Colors.grey.shade100,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 15,
        ),
      ),
    );
  }
}
