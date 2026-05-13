import 'package:flutter/material.dart';
import '../../../../../../core/theme/app_spacing.dart';
import '../../../../../../core/classes/adaptive_layout.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.label,
    required this.hint,
    required this.prefixIcon,
    required this.validator,
    required this.controller,
    this.suffixIcon,
    this.obscureText = false,
    this.onPressed,
    this.keyboardType,
    this.maxLines = 1,
  });

  final bool obscureText;
  final String label, hint;
  final IconData prefixIcon;
  final IconData? suffixIcon;
  final void Function()? onPressed;
  final TextEditingController? controller;
  final String? Function(String?) validator;
  final TextInputType? keyboardType;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: AdaptiveLayout.getResponsiveFontSize(
              context,
              fontSize: 16,
            ),
          ),
        ),
        SizedBox(
          height: AdaptiveLayout.getResponsiveFontSize(
            context,
            fontSize: AppSpacing.xs,
          ),
        ),
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          maxLines: maxLines,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: validator,
          style: TextStyle(
            fontSize: AdaptiveLayout.getResponsiveFontSize(
              context,
              fontSize: 14,
            ),
          ),
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(
              prefixIcon,
              size: AdaptiveLayout.getResponsiveFontSize(
                context,
                fontSize: AppSpacing.iconM,
              ),
            ),
            suffixIcon: suffixIcon != null
                ? IconButton(
                    onPressed: onPressed,
                    icon: Icon(
                      suffixIcon,
                      size: AdaptiveLayout.getResponsiveFontSize(
                        context,
                        fontSize: AppSpacing.iconS,
                      ),
                    ),
                  )
                : null,
          ),
        ),
      ],
    );
  }
}
