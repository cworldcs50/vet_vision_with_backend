import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../controller/home_controller.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/classes/adaptive_layout.dart';
import '../../../../../core/classes/search_criteria.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({
    super.key,
    required this.onSearchPressed,
    required this.onFilterPressed,
    this.onChanged,
    this.controller,
    required this.selectedCriteria,
    required this.onToggleCriteria,
    this.keyboardType = TextInputType.text,
  });

  final TextInputType keyboardType;
  final void Function() onSearchPressed;
  final void Function() onFilterPressed;
  final void Function(String)? onChanged;
  final TextEditingController? controller;
  final List<SearchCriteria> selectedCriteria;
  final void Function(SearchCriteria) onToggleCriteria;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadiusGeometry.circular(
              AdaptiveLayout.getResponsiveFontSize(context, fontSize: 12),
            ),
            child: TextField(
              onChanged: onChanged,
              controller: controller,
              keyboardType: keyboardType,
              textAlign: TextAlign.left,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                hintText: "Search by name, specialization...",
                hintStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: AdaptiveLayout.getResponsiveFontSize(
                    context,
                    fontSize: 12,
                  ),
                  fontWeight: FontWeight.bold,
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    Icons.tune,
                    size: AdaptiveLayout.getResponsiveFontSize(
                      context,
                      fontSize: 22,
                    ),
                    color: AppColors.accent,
                  ),
                  onPressed: () => _showAdvancedFilterSheet(context),
                ),
                prefixIcon: IconButton(
                  onPressed: onSearchPressed,
                  icon: Icon(
                    Icons.search,
                    color: AppColors.accent,
                    size: AdaptiveLayout.getResponsiveFontSize(
                      context,
                      fontSize: 22,
                    ),
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    AdaptiveLayout.getResponsiveFontSize(context, fontSize: 30),
                  ),
                ),
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                contentPadding: EdgeInsets.zero,
                disabledBorder: InputBorder.none,
              ),
              style: TextStyle(
                fontSize: AdaptiveLayout.getResponsiveFontSize(
                  context,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ),
        // Container(
        //   padding: EdgeInsets.all(
        //     AdaptiveLayout.getResponsiveFontSize(context, fontSize: 6),
        //   ),
        //   decoration: BoxDecoration(
        //     color: const Color(0xFF009689).withValues(alpha: 0.1),
        //     borderRadius: BorderRadius.circular(
        //       AdaptiveLayout.getResponsiveFontSize(context, fontSize: 8),
        //     ),
        //   ),
        //   child: IconButton(
        //     onPressed: onFilterPressed,
        //     style: IconButton.styleFrom(
        //       backgroundColor: const Color(0xFF009689),
        //       shape: RoundedRectangleBorder(
        //         borderRadius: BorderRadius.circular(
        //           AdaptiveLayout.getResponsiveFontSize(context, fontSize: 12),
        //         ),
        //       ),
        //     ),
        //     icon: Icon(
        //       Icons.tune,
        //       color: Colors.white,
        //       size: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 18),
        //     ),
        //   ),
        // ),
      ],
    );
  }

  void _showAdvancedFilterSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(
            AdaptiveLayout.getResponsiveFontSize(context, fontSize: 30),
          ),
        ),
      ),
      builder: (context) {
        return GetBuilder<HomeController>(
          builder: (controller) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Container(
                padding: EdgeInsets.all(
                  AdaptiveLayout.getResponsiveFontSize(context, fontSize: 24),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          width: 50,
                          height: 5,
                          margin: EdgeInsets.only(
                            bottom: AdaptiveLayout.getResponsiveFontSize(
                              context,
                              fontSize: 20,
                            ),
                          ),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(
                              AdaptiveLayout.getResponsiveFontSize(
                                context,
                                fontSize: 10,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Filters & Sorting",
                            style: TextStyle(
                              fontSize: AdaptiveLayout.getResponsiveFontSize(
                                context,
                                fontSize: 22,
                              ),
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              controller.minPriceController.clear();
                              controller.maxPriceController.clear();
                              controller.experienceController.clear();
                              controller.selectedSortBy = "rating";
                              controller.selectedSessionType = "both";
                              controller.update();
                            },
                            child: const Text("Reset All"),
                          ),
                        ],
                      ),
                      const Divider(),
                      _buildSectionHeader(context, "Search In"),
                      Wrap(
                        spacing: 10,
                        children: SearchCriteria.values
                            .where(
                              (e) =>
                                  e == SearchCriteria.name ||
                                  e == SearchCriteria.specialization,
                            )
                            .map((criteria) {
                              final isSelected = controller.activeSearchCriteria
                                  .contains(criteria);
                              return FilterChip(
                                label: Text(criteria.name.capitalizeFirst!),
                                selected: isSelected,
                                onSelected: (_) =>
                                    controller.toggleSearchCriteria(criteria),
                                selectedColor: AppColors.accent.withValues(
                                  alpha: 0.2,
                                ),
                                checkmarkColor: AppColors.accent,
                              );
                            })
                            .toList(),
                      ),
                      _buildSectionHeader(context, "Price Range"),
                      Row(
                        children: [
                          Expanded(
                            child: _buildTextField(
                              context,
                              controller.minPriceController,
                              "Min Price",
                              prefixText: "",
                            ),
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            child: _buildTextField(
                              context,
                              controller.maxPriceController,
                              "Max Price",
                              prefixText: "",
                            ),
                          ),
                        ],
                      ),
                      _buildSectionHeader(
                        context,
                        "Minimum Experience (Years)",
                      ),
                      _buildTextField(
                        context,
                        controller.experienceController,
                        "Years of experience",
                        icon: Icons.history_edu,
                      ),
                      _buildSectionHeader(context, "Sort By"),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: controller.selectedSortBy,
                            isExpanded: true,
                            onChanged: (v) => controller.updateSortBy(v!),
                            items: const [
                              DropdownMenuItem(
                                value: "rating",
                                child: Text("Highest Rating First"),
                              ),
                              DropdownMenuItem(
                                value: "distance",
                                child: Text("Closest Doctor First"),
                              ),
                              DropdownMenuItem(
                                value: "rating_and_distance",
                                child: Text("Best & Closest"),
                              ),
                              DropdownMenuItem(
                                value: "experience",
                                child: Text("Most Experience First"),
                              ),
                              DropdownMenuItem(
                                value: "price",
                                child: Text("Cheapest Fee First"),
                              ),
                            ],
                          ),
                        ),
                      ),
                      _buildSectionHeader(context, "Session Type"),
                      Row(
                        children: [
                          _buildSessionChip(controller, "online", "Online"),
                          const SizedBox(width: 10),
                          _buildSessionChip(controller, "offline", "Offline"),
                          const SizedBox(width: 10),
                          _buildSessionChip(controller, "both", "Both"),
                        ],
                      ),
                      const SizedBox(height: 35),
                      ElevatedButton(
                        onPressed: () {
                          controller.applyAdvancedFilters();
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.accent,
                          minimumSize: const Size(double.infinity, 60),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          "Apply Filters",
                          style: TextStyle(
                            fontSize: AdaptiveLayout.getResponsiveFontSize(
                              context,
                              fontSize: 18,
                            ),
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 10),
      child: Text(
        title,
        style: TextStyle(
          fontSize: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 16),
          fontWeight: FontWeight.bold,
          color: AppColors.primary,
        ),
      ),
    );
  }

  Widget _buildTextField(
    BuildContext context,
    TextEditingController controller,
    String hint, {
    String? prefixText,
    IconData? icon,
  }) {
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

  Widget _buildSessionChip(
    HomeController controller,
    String value,
    String label,
  ) {
    final isSelected = controller.selectedSessionType == value;
    return Expanded(
      child: ChoiceChip(
        label: Center(
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
        selected: isSelected,
        onSelected: (selected) {
          if (selected) controller.updateSessionType(value);
        },
        selectedColor: AppColors.accent,
        backgroundColor: Colors.grey.shade100,
      ),
    );
  }
}
