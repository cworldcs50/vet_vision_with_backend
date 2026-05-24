import 'package:get/get.dart';
import '../custom_search_bar.dart';
import '../custom_doctor_card.dart';
import '../custom_home_header.dart';
import 'package:flutter/material.dart';
import '../custom_home_categories.dart';
import '../home_dashboard_overview.dart';
import '../../../controller/home_controller.dart';
import '../../../../../../core/network/request_status.dart';
import '../../../../../../core/classes/adaptive_layout.dart';
import '../../../../../../core/widgets/users_liquid_pull_to_refresh.dart';

class MobileHomeLayout extends GetView<HomeController> {
  const MobileHomeLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) {
        return UsersLiquidPullToRefresh(
          onRefresh: controller.refreshHomePull,
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: Container(
                  padding: EdgeInsets.all(
                    AdaptiveLayout.getResponsiveFontSize(
                      context,
                      fontSize: 20,
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF009689),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(
                        AdaptiveLayout.getResponsiveFontSize(
                          context,
                          fontSize: 10,
                        ),
                      ),
                      bottomRight: Radius.circular(
                        AdaptiveLayout.getResponsiveFontSize(
                          context,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomHomeHeader(
                        userDisplayName: controller.userDisplayName,
                      ),
                      SizedBox(
                        height: AdaptiveLayout.getResponsiveFontSize(
                          context,
                          fontSize: 20,
                        ),
                      ),
                      CustomSearchBar(
                        onFilterPressed: () {},
                        onChanged: controller.onSearch,
                        controller: controller.searchController,
                        selectedCriteria: controller.selectedCriteria,
                        onToggleCriteria:
                            controller.toggleSearchCriteria,
                        keyboardType: controller.keyboardType,
                        onSearchPressed: () {
                          controller.onSearch(
                            controller.searchController.text,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),

              const SliverToBoxAdapter(
                child: HomeDashboardOverview(),
              ),

              SliverToBoxAdapter(
                child: SizedBox(
                  height: AdaptiveLayout.getResponsiveFontSize(
                    context,
                    fontSize: 16,
                  ),
                ),
              ),

              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: AdaptiveLayout.getResponsiveFontSize(
                      context,
                      fontSize: 20,
                    ),
                  ),
                  child: GestureDetector(
                    onTap: () => Get.toNamed('/cvScan'),
                    child: Container(
                      padding: EdgeInsets.all(
                        AdaptiveLayout.getResponsiveFontSize(
                          context,
                          fontSize: 16,
                        ),
                      ),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFF00BBA7),
                            Color(0xFF00796B),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(
                              0xFF009689,
                            ).withValues(alpha: 0.3),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.2),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.biotech,
                              color: Colors.white,
                              size: 28,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'AI Disease Scan',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Identify pet diseases with one photo',
                                  style: TextStyle(
                                    color: Colors.white.withValues(
                                      alpha: 0.9,
                                    ),
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white,
                            size: 16,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              SliverToBoxAdapter(
                child: SizedBox(
                  height: AdaptiveLayout.getResponsiveFontSize(
                    context,
                    fontSize: 24,
                  ),
                ),
              ),

              const SliverToBoxAdapter(
                child: CustomHomeCategories(),
              ),

              SliverToBoxAdapter(
                child: SizedBox(
                  height: AdaptiveLayout.getResponsiveFontSize(
                    context,
                    fontSize: 20,
                  ),
                ),
              ),

              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: AdaptiveLayout.getResponsiveFontSize(
                      context,
                      fontSize: 20,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "All Doctors (${controller.allDoctors.length})",
                        style: TextStyle(
                          fontSize:
                              AdaptiveLayout.getResponsiveFontSize(
                            context,
                            fontSize: 18,
                          ),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SliverToBoxAdapter(
                child: SizedBox(
                  height: AdaptiveLayout.getResponsiveFontSize(
                    context,
                    fontSize: 10,
                  ),
                ),
              ),

              if (controller.doctorsStatus ==
                  RequestStatus.loading)
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical:
                          AdaptiveLayout.getResponsiveFontSize(
                        context,
                        fontSize: 40,
                      ),
                    ),
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                )
              else if (controller.allDoctors.isEmpty)
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical:
                          AdaptiveLayout.getResponsiveFontSize(
                        context,
                        fontSize: 24,
                      ),
                    ),
                    child: const Center(
                      child: Text("No doctors found"),
                    ),
                  ),
                )
              else
                SliverPadding(
                  padding: EdgeInsets.symmetric(
                    horizontal:
                        AdaptiveLayout.getResponsiveFontSize(
                      context,
                      fontSize: 20,
                    ),
                    vertical:
                        AdaptiveLayout.getResponsiveFontSize(
                      context,
                      fontSize: 10,
                    ),
                  ),
                  sliver: SliverList.separated(
                    itemCount:
                        controller.filteredDoctors.length,
                    itemBuilder: (context, index) {
                      final doctor =
                          controller.filteredDoctors[index];
                      return CustomDoctorCard(
                        doctor: doctor,
                      );
                    },
                    separatorBuilder: (context, index) =>
                        SizedBox(
                      height:
                          AdaptiveLayout.getResponsiveFontSize(
                        context,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),

              SliverToBoxAdapter(
                child: SizedBox(
                  height: AdaptiveLayout.getResponsiveFontSize(
                    context,
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}