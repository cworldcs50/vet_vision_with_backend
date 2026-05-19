import 'package:flutter/material.dart';
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
      children: [
        Row(
          children: [
            Text(
              label,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: AdaptiveLayout.getResponsiveFontSize(
                  context,
                  fontSize: 10,
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 5),
        ),
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          maxLines: maxLines,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: validator,
          style: TextStyle(
            color: Colors.black,
            fontSize: AdaptiveLayout.getResponsiveFontSize(
              context,
              fontSize: 12,
            ),
          ),
          cursorColor: Colors.black,
          cursorWidth: AdaptiveLayout.getResponsiveFontSize(
            context,
            fontSize: 2,
          ),
          decoration: InputDecoration(
            hintText: hint,
            suffixIcon: suffixIcon != null
                ? IconButton(
                    onPressed: onPressed,
                    icon: Icon(
                      suffixIcon,
                      size: AdaptiveLayout.getResponsiveFontSize(
                        context,
                        fontSize: 17,
                      ),
                      color: const Color(0XFF999AAF),
                    ),
                  )
                : null,
            alignLabelWithHint: true,
            focusColor: const Color(0XFF999AAF),
            prefixIcon: Icon(
              prefixIcon,
              size: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 20),
              color: const Color(0XFF999AAF),
            ),
            prefixIconColor: const Color(0XFF999AAF),
            contentPadding: maxLines! > 1
                ? EdgeInsets.all(
                    AdaptiveLayout.getResponsiveFontSize(context, fontSize: 12),
                  )
                : EdgeInsets.zero,
            filled: true,
            fillColor: const Color(0XFFf3f3f5),
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: const Color(0XFF999AAF),
                width: AdaptiveLayout.getResponsiveFontSize(
                  context,
                  fontSize: 2,
                ),
              ),
              borderRadius: BorderRadius.circular(
                AdaptiveLayout.getResponsiveFontSize(context, fontSize: 14),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(
                AdaptiveLayout.getResponsiveFontSize(context, fontSize: 14),
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Color(0XFF999AAF)),
              borderRadius: BorderRadius.circular(
                AdaptiveLayout.getResponsiveFontSize(context, fontSize: 14),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: const Color(0XFF999AAF),
                width: AdaptiveLayout.getResponsiveFontSize(
                  context,
                  fontSize: 2,
                ),
              ),
              borderRadius: BorderRadius.circular(
                AdaptiveLayout.getResponsiveFontSize(context, fontSize: 14),
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                AdaptiveLayout.getResponsiveFontSize(context, fontSize: 14),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
