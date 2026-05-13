import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../controller/home_controller.dart';
import '../../../../../core/classes/adaptive_layout.dart';

class CustomHomeCategories extends StatelessWidget {
  const CustomHomeCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AdaptiveLayout.getResponsiveFontSize(
              context,
              fontSize: 20,
            ),
          ),
          child: Text(
            "Categories",
            style: TextStyle(
              fontSize: AdaptiveLayout.getResponsiveFontSize(
                context,
                fontSize: 18,
              ),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          height: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 10),
        ),
        SizedBox(
          height: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 40),
          child: GetBuilder<HomeController>(
            builder: (controller) {
              return ListView.separated(
                padding: EdgeInsets.symmetric(
                  horizontal: AdaptiveLayout.getResponsiveFontSize(
                    context,
                    fontSize: 5,
                  ),
                ),
                scrollDirection: Axis.horizontal,
                itemCount: controller.categories.length,
                separatorBuilder: (context, index) => SizedBox(
                  width: AdaptiveLayout.getResponsiveFontSize(
                    context,
                    fontSize: 10,
                  ),
                ),
                itemBuilder: (context, index) {
                  final category = controller.categories[index];
                  final isSelected = controller.selectedCategory == category;
                  return GestureDetector(
                    onTap: () => controller.selectCategory(category),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: AdaptiveLayout.getResponsiveFontSize(
                          context,
                          fontSize: 20,
                        ),
                        vertical: AdaptiveLayout.getResponsiveFontSize(
                          context,
                          fontSize: 8,
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color(0xFF009689)
                            : Colors.white,
                        border: isSelected
                            ? null
                            : Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(
                          AdaptiveLayout.getResponsiveFontSize(
                            context,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        category,
                        style: TextStyle(
                          color: isSelected
                              ? Colors.white
                              : Colors.grey.shade700,
                          fontWeight: isSelected
                              ? FontWeight.bold
                              : FontWeight.w500,
                          fontSize: AdaptiveLayout.getResponsiveFontSize(
                            context,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
