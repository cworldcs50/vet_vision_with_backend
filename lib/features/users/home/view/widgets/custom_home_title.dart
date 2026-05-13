import 'package:flutter/material.dart';
import '../../../../../core/classes/adaptive_layout.dart';
import '../../../../../core/theme/app_colors.dart';

class CustomHomeTitle extends StatelessWidget {
  const CustomHomeTitle({required this.onTap, super.key});

  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          child: Padding(
            padding: EdgeInsets.only(
              top: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 8.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: onTap,
                  child: Container(
                    width: AdaptiveLayout.getResponsiveFontSize(
                      context,
                      fontSize: 35,
                    ),
                    height: AdaptiveLayout.getResponsiveFontSize(
                      context,
                      fontSize: 35,
                    ),
                    margin: EdgeInsets.only(
                      left: AdaptiveLayout.getResponsiveFontSize(
                        context,
                        fontSize: 10,
                      ),
                    ),
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0XFF40D9C8),
                    ),
                    child: Icon(
                      Icons.pets,
                      color: Colors.red,
                      size: AdaptiveLayout.getResponsiveFontSize(
                        context,
                        fontSize: 21,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: AdaptiveLayout.getResponsiveFontSize(
                    context,
                    fontSize: 5,
                  ),
                ),
                Text(
                  "VetVision",
                  style: TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: AdaptiveLayout.getResponsiveFontSize(
                      context,
                      fontSize: 15,
                    ),
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: onTap,
                  icon: Icon(
                    Icons.settings_outlined,
                    size: AdaptiveLayout.getResponsiveFontSize(
                      context,
                      fontSize: 25,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const Divider(),
      ],
    );
  }
}
