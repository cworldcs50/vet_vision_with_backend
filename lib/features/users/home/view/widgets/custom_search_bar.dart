import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../controller/home_controller.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/classes/adaptive_layout.dart';
import '../../../../../core/classes/search_criteria.dart';

String _homeSearchNarrowChipLabel(SearchCriteria criteria) {
  switch (criteria) {
    case SearchCriteria.name:
      return 'Doctor name only';
    case SearchCriteria.specialization:
      return 'Specialization only';
    default:
      return '';
  }
}

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
                filled: true,
                fillColor: Colors.white,
                hintText: 'Search by name, specialization...',
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
      ],
    );
  }

  void _showAdvancedFilterSheet(BuildContext context) {
    showModalBottomSheet<void>(
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
      builder: (sheetContext) {
        return GetBuilder<HomeController>(
          builder: (controller) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(sheetContext).viewInsets.bottom,
              ),
              child: Container(
                padding: EdgeInsets.all(
                  AdaptiveLayout.getResponsiveFontSize(
                    sheetContext,
                    fontSize: 24,
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          width: AdaptiveLayout.getResponsiveFontSize(
                            context,
                            fontSize: 50,
                          ),
                          height: AdaptiveLayout.getResponsiveFontSize(
                            context,
                            fontSize: 5,
                          ),
                          margin: EdgeInsets.only(
                            bottom: AdaptiveLayout.getResponsiveFontSize(
                              sheetContext,
                              fontSize: 20,
                            ),
                          ),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(
                              AdaptiveLayout.getResponsiveFontSize(
                                sheetContext,
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
                            'Filters & Sorting',
                            style: TextStyle(
                              fontSize: AdaptiveLayout.getResponsiveFontSize(
                                sheetContext,
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
                              controller.selectedSortBy = 'rating';
                              controller.selectedSessionType = 'both';
                              controller.activeSearchCriteria.clear();
                              controller.update();
                            },
                            child: const Text('Reset All'),
                          ),
                        ],
                      ),
                      const Divider(),
                      const HomeFilterSheetSectionHeader(
                        title: 'Search text (main bar)',
                      ),
                      Text(
                        'Typing in the search bar matches doctor name or specialization. '
                        'You do not need to pick anything here unless you want to narrow '
                        'to one field only.',
                        style: TextStyle(
                          fontSize: AdaptiveLayout.getResponsiveFontSize(
                            sheetContext,
                            fontSize: 13,
                          ),
                          color: AppColors.textSecondary,
                          height: 1.35,
                        ),
                      ),
                      SizedBox(
                        height: AdaptiveLayout.getResponsiveFontSize(
                          sheetContext,
                          fontSize: 12,
                        ),
                      ),
                      const HomeFilterSheetSectionHeader(
                        title: 'Optional: narrow search',
                      ),
                      Wrap(
                        spacing: AdaptiveLayout.getResponsiveFontSize(
                          sheetContext,
                          fontSize: 10,
                        ),
                        runSpacing: AdaptiveLayout.getResponsiveFontSize(
                          sheetContext,
                          fontSize: 8,
                        ),
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
                                label: Text(
                                  _homeSearchNarrowChipLabel(criteria),
                                  style: TextStyle(
                                    fontSize:
                                        AdaptiveLayout.getResponsiveFontSize(
                                          sheetContext,
                                          fontSize: 13,
                                        ),
                                  ),
                                ),
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
                      const HomeFilterSheetSectionHeader(title: 'Price Range'),
                      Row(
                        children: [
                          Expanded(
                            child: HomeFilterSheetNumericTextField(
                              controller: controller.minPriceController,
                              hint: 'Min Price',
                            ),
                          ),
                          SizedBox(
                            width: AdaptiveLayout.getResponsiveFontSize(
                              sheetContext,
                              fontSize: 15,
                            ),
                          ),
                          Expanded(
                            child: HomeFilterSheetNumericTextField(
                              controller: controller.maxPriceController,
                              hint: 'Max Price',
                            ),
                          ),
                        ],
                      ),
                      const HomeFilterSheetSectionHeader(
                        title: 'Minimum Experience (Years)',
                      ),
                      HomeFilterSheetNumericTextField(
                        controller: controller.experienceController,
                        hint: 'Years of experience',
                        icon: Icons.history_edu,
                      ),
                      const HomeFilterSheetSectionHeader(title: 'Sort By'),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: AdaptiveLayout.getResponsiveFontSize(
                            sheetContext,
                            fontSize: 12,
                          ),
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(
                            AdaptiveLayout.getResponsiveFontSize(
                              sheetContext,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: controller.selectedSortBy,
                            isExpanded: true,
                            onChanged: (v) {
                              if (v != null) controller.updateSortBy(v);
                            },
                            items: const [
                              DropdownMenuItem(
                                value: 'rating',
                                child: Text('Highest Rating First'),
                              ),
                              DropdownMenuItem(
                                value: 'distance',
                                child: Text('Closest Doctor First'),
                              ),
                              DropdownMenuItem(
                                value: 'rating_and_distance',
                                child: Text('Best & Closest'),
                              ),
                              DropdownMenuItem(
                                value: 'experience',
                                child: Text('Most Experience First'),
                              ),
                              DropdownMenuItem(
                                value: 'price',
                                child: Text('Cheapest Fee First'),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const HomeFilterSheetSectionHeader(title: 'Session Type'),
                      Row(
                        children: [
                          HomeFilterSheetSessionChip(
                            controller: controller,
                            value: 'online',
                            label: 'Online',
                          ),
                          SizedBox(
                            width: AdaptiveLayout.getResponsiveFontSize(
                              sheetContext,
                              fontSize: 10,
                            ),
                          ),
                          HomeFilterSheetSessionChip(
                            controller: controller,
                            value: 'offline',
                            label: 'Offline',
                          ),
                          SizedBox(
                            width: AdaptiveLayout.getResponsiveFontSize(
                              sheetContext,
                              fontSize: 10,
                            ),
                          ),
                          HomeFilterSheetSessionChip(
                            controller: controller,
                            value: 'both',
                            label: 'Both',
                          ),
                        ],
                      ),
                      SizedBox(
                        height: AdaptiveLayout.getResponsiveFontSize(
                          sheetContext,
                          fontSize: 35,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          controller.applyAdvancedFilters();
                          Navigator.pop(sheetContext);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.accent,
                          minimumSize: Size(
                            double.infinity,
                            AdaptiveLayout.getResponsiveFontSize(
                              context,
                              fontSize: 60,
                            ),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              AdaptiveLayout.getResponsiveFontSize(
                                context,
                                fontSize: 15,
                              ),
                            ),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          'Apply Filters',
                          style: TextStyle(
                            fontSize: AdaptiveLayout.getResponsiveFontSize(
                              sheetContext,
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
}

class HomeFilterSheetSectionHeader extends StatelessWidget {
  const HomeFilterSheetSectionHeader({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 20),
        bottom: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 10),
      ),
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
}

class HomeFilterSheetNumericTextField extends StatelessWidget {
  const HomeFilterSheetNumericTextField({
    super.key,
    required this.controller,
    required this.hint,
    this.icon,
  });

  final TextEditingController controller;
  final String hint;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: icon != null
            ? Icon(
                icon,
                size: AdaptiveLayout.getResponsiveFontSize(
                  context,
                  fontSize: 20,
                ),
              )
            : null,
        filled: true,
        fillColor: Colors.grey.shade100,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            AdaptiveLayout.getResponsiveFontSize(context, fontSize: 12),
          ),
          borderSide: BorderSide.none,
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: AdaptiveLayout.getResponsiveFontSize(
            context,
            fontSize: 15,
          ),
          vertical: AdaptiveLayout.getResponsiveFontSize(context, fontSize: 15),
        ),
      ),
    );
  }
}

class HomeFilterSheetSessionChip extends StatelessWidget {
  const HomeFilterSheetSessionChip({
    super.key,
    required this.controller,
    required this.value,
    required this.label,
  });

  final HomeController controller;
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    final isSelected = controller.selectedSessionType == value;
    return Expanded(
      child: ChoiceChip(
        label: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: AdaptiveLayout.getResponsiveFontSize(
                context,
                fontSize: 13,
              ),
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
