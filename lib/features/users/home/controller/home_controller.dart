import 'dart:async';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import '../../../../core/classes/failure_model.dart';
import '../../../../core/classes/search_criteria.dart';
import '../../../../core/network/request_status.dart';
import '../../../../core/routes/app_routes_name.dart';
import '../../../../core/theme/app_colors.dart';
import '../../booking/model/doctor_model.dart';
import '../data/repository/home_data_repository.dart';


class HomeController extends GetxController {
  final IHomeRepository _homeRepository;

  HomeController({required IHomeRepository repository})
    : _homeRepository = repository;

  int currentNavIndex = 0;
  String selectedCategory = "All";
  RequestStatus requestStatus = RequestStatus.noData;
  Timer? _searchDebounce;
  // Selected search criteria for the search bar (name or specialization)
  List<SearchCriteria> activeSearchCriteria = [SearchCriteria.name];

  // Advanced Filter States
  final TextEditingController searchController = TextEditingController();
  final TextEditingController minPriceController = TextEditingController();
  final TextEditingController maxPriceController = TextEditingController();
  final TextEditingController experienceController = TextEditingController();
  List<String> categories = [];
  List<DoctorModel> allDoctors = [];
  List<SearchCriteria> selectedCriteria = [];
  List<DoctorModel> filteredDoctors = [];
  String selectedSortBy = "rating";
  String selectedSessionType = "both"; // online, offline, both

  // Mock location for distance-based sorting
  double? lat = 30.0444;
  double? lng = 31.2357;

  @override
  void onInit() async {
    super.onInit();
    await fetchDoctors();
    await fetchSpecialization();
  }

  void onToggleCriteria(SearchCriteria searchCriteria) {}

  Future<void> fetchSpecialization() async {
    requestStatus = RequestStatus.loading;

    update();
    final Either<FailureModel, Map<dynamic, dynamic>> result =
        await _homeRepository.getSpecialization();

    result.fold(
      (failureModel) {
        requestStatus = failureModel.status;
        Get.snackbar(
          "Warning!",
          failureModel.message,
          backgroundColor: AppColors.accent,
        );
      },
      (response) {
        if (response["status"]) {
          requestStatus = RequestStatus.success;
          categories = ["All", ...response["data"]];
        } else {
          requestStatus = RequestStatus.failure;
          Get.snackbar(
            "Warning!",
            response["message"],
            backgroundColor: AppColors.accent,
          );
        }
      },
    );

    update();
  }

  Future<void> fetchDoctors({Map<String, dynamic>? params}) async {
    requestStatus = RequestStatus.loading;

    update();
    final result = await _homeRepository.getDoctors(queryParams: params);

    result.fold(
      (failureModel) {
        requestStatus = failureModel.status;
        Get.snackbar(
          "Warning!",
          failureModel.message,
          backgroundColor: AppColors.accent,
        );
      },
      (response) {
        if (response["status"]) {
          requestStatus = RequestStatus.success;
          // The API response for /doctors might have a paginated structure (response["data"]["data"])
          // or a direct list depending on the endpoint. Based on previous code, it's response["data"]["data"].
          final data = response["data"];
          List list;
          if (data is Map && data.containsKey("data")) {
            list = data["data"] as List;
          } else if (data is List) {
            list = data;
          } else {
            list = [];
          }

          allDoctors = list
              .map((doctor) => DoctorModel.fromJson(doctor))
              .toList();
          filteredDoctors = List.from(allDoctors);
        } else {
          requestStatus = RequestStatus.failure;
          Get.snackbar(
            "Warning!",
            response["message"],
            backgroundColor: AppColors.accent,
          );
        }
      },
    );

    update();
  }

  void changeNavIndex(int index) {
    currentNavIndex = index;
    update();
  }

  void selectCategory(String category) async {
    selectedCategory = category;
    log("Category selected: $category");
    Map<String, dynamic> params = {};
    if (category != "All") {
      params["specialization"] = category;
    }
    // Also include search query if present
    if (searchController.text.isNotEmpty) {
      params["name"] = searchController.text;
    }
    await fetchDoctors(params: params);
  }

  void toggleSearchCriteria(SearchCriteria criteria) {
    if (activeSearchCriteria.contains(criteria)) {
      if (activeSearchCriteria.length > 1) {
        activeSearchCriteria.remove(criteria);
      }
    } else {
      activeSearchCriteria.add(criteria);
    }
    update();
    if (searchController.text.isNotEmpty) {
      onSearch(searchController.text);
    }
  }

  void updateSortBy(String value) {
    selectedSortBy = value;
    update();
    applyAdvancedFilters();
  }

  void updateSessionType(String value) {
    selectedSessionType = value;
    update();
    applyAdvancedFilters();
  }

  void applyAdvancedFilters() {
    onSearch(searchController.text);
  }

  TextInputType get keyboardType {
    if (selectedCriteria.isEmpty) return TextInputType.text;

    // Numeric criteria
    final numericCriteria = [
      SearchCriteria.priceMin,
      SearchCriteria.priceMax,
      SearchCriteria.rating,
      SearchCriteria.experience,
      SearchCriteria.distance,
    ];

    // Check if all selected criteria are numeric
    final onlyNumeric = selectedCriteria.every(
      (c) => numericCriteria.contains(c),
    );

    return onlyNumeric ? TextInputType.number : TextInputType.text;
  }

  void onSearch(String query) async {
    if (_searchDebounce?.isActive ?? false) _searchDebounce!.cancel();
    _searchDebounce = Timer(const Duration(milliseconds: 500), () async {
      Map<String, dynamic> params = {};

      // 1. Text Search Criteria (from Search Bar)
      if (query.isNotEmpty) {
        for (var criteria in activeSearchCriteria) {
          if (criteria == SearchCriteria.name) params["name"] = query;
          if (criteria == SearchCriteria.specialization) {
            params["specialization"] = query;
          }
        }
      }

      // 2. Persistent Advanced Filters
      if (minPriceController.text.isNotEmpty) {
        params["price_min"] = minPriceController.text;
      }

      if (maxPriceController.text.isNotEmpty) {
        params["price_max"] = maxPriceController.text;
      }

      if (experienceController.text.isNotEmpty) {
        params["experience_min"] = experienceController.text;
      }

      // 3. Session Type
      if (selectedSessionType != "both") {
        params["available"] = selectedSessionType == "online"
            ? "true"
            : "false";
      }

      // 4. Sorting & Location
      params["sort_by"] = selectedSortBy;
      if (selectedSortBy == "distance" ||
          selectedSortBy == "rating_and_distance") {
        if (lat != null && lng != null) {
          params["location_lat"] = lat.toString();
          params["location_lng"] = lng.toString();
        }
      }

      // 5. Category (if not overridden by specialization search)
      if (selectedCategory != "All" &&
          !activeSearchCriteria.contains(SearchCriteria.specialization)) {
        params["specialization"] = selectedCategory;
      }

      await fetchDoctors(params: params);
    });
  }

  @override
  void onClose() {
    _searchDebounce?.cancel();
    searchController.dispose();
    super.onClose();
  }

  void goToDoctorProfile(DoctorModel doctor) {
    Get.toNamed(AppRoutesName.rDoctorDetails, arguments: doctor);
  }

  // Legacy mappings for buttons if we reuse them later, keeping for safety
  Future<void> goToBookAppointement() async =>
      await Get.toNamed(AppRoutesName.rBookAppointment);

  Future<void> goToHealthRecords() async =>
      await Get.toNamed(AppRoutesName.rHealthRecords);

  Future<void> goToMyPets() async => await Get.toNamed(AppRoutesName.rMyPets);
}
