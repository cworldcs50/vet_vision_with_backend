import 'dart:async';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import '../../../../core/classes/failure_model.dart';
import '../../../../core/classes/search_criteria.dart';
import '../../../../core/constants/caching_keys_constants.dart';
import '../../../../core/network/request_status.dart';
import '../../../../core/routes/app_routes_name.dart';
import '../../../../core/services/app_service.dart';
import '../../../../core/theme/app_colors.dart';
import '../../booking/model/doctor_model.dart';
import '../data/models/user_dashboard_model.dart';
import '../data/repository/home_data_repository.dart';

class HomeController extends GetxController {
  HomeController({required IHomeRepository repository})
    : _homeRepository = repository;

  final IHomeRepository _homeRepository;

  int currentNavIndex = 0;
  String selectedCategory = 'All';

  RequestStatus doctorsStatus = RequestStatus.noData;
  RequestStatus specializationsStatus = RequestStatus.noData;
  RequestStatus dashboardStatus = RequestStatus.noData;

  String? userDisplayName;
  String? dashboardErrorMessage;
  UserDashboardModel? userDashboard;

  Timer? _searchDebounce;

  /// Empty = match typed text against doctor name OR specialization (`search` on API).
  /// [name] only / [specialization] only = narrow to that column.
  List<SearchCriteria> activeSearchCriteria = [];

  final TextEditingController searchController = TextEditingController();
  final TextEditingController minPriceController = TextEditingController();
  final TextEditingController maxPriceController = TextEditingController();
  final TextEditingController experienceController = TextEditingController();
  List<String> categories = [];
  List<DoctorModel> allDoctors = [];
  List<SearchCriteria> selectedCriteria = [];
  List<DoctorModel> filteredDoctors = [];
  String selectedSortBy = 'rating';
  String selectedSessionType = 'both';

  double? lat = 30.0444;
  double? lng = 31.2357;

  @override
  void onInit() {
    super.onInit();
    _readCachedUserName();
    unawaited(_loadHomeData());
  }

  void _readCachedUserName() {
    try {
      final prefs = Get.find<AppServices>().appSharedPrefs;
      final name = prefs.getString(CachingKeysConstants.kUserFullName);
      userDisplayName = (name != null && name.trim().isNotEmpty)
          ? name.trim()
          : null;
    } catch (_) {
      userDisplayName = null;
    }
  }

  Future<void> _loadHomeData() async {
    await Future.wait([
      fetchUserDashboard(),
      fetchSpecialization(),
      fetchDoctors(params: buildDoctorListQueryParams()),
    ]);
  }

  /// Same filters as the debounced search (for pull-to-refresh).
  Map<String, dynamic> buildDoctorListQueryParams() {
    final query = searchController.text.trim();
    final Map<String, dynamic> params = {};

    addDoctorTextSearchParams(query, params);

    if (minPriceController.text.isNotEmpty) {
      params['price_min'] = minPriceController.text;
    }

    if (maxPriceController.text.isNotEmpty) {
      params['price_max'] = maxPriceController.text;
    }

    if (experienceController.text.isNotEmpty) {
      params['experience_min'] = experienceController.text;
    }

    if (selectedSessionType != 'both') {
      params['available'] = selectedSessionType == 'online'
          ? 'true'
          : 'false';
    }

    params['sort_by'] = selectedSortBy;
    if (selectedSortBy == 'distance' ||
        selectedSortBy == 'rating_and_distance') {
      if (lat != null && lng != null) {
        params['location_lat'] = lat.toString();
        params['location_lng'] = lng.toString();
      }
    }

    if (selectedCategory != 'All' &&
        !activeSearchCriteria.contains(SearchCriteria.specialization) &&
        !params.containsKey('specialization')) {
      params['specialization'] = selectedCategory;
    }

    return params;
  }

  Future<void> refreshHomePull() async {
    await Future.wait([
      fetchUserDashboard(),
      fetchSpecialization(),
      fetchDoctors(params: buildDoctorListQueryParams()),
    ]);
  }

  void onToggleCriteria(SearchCriteria searchCriteria) {}

  Future<void> fetchUserDashboard() async {
    dashboardStatus = RequestStatus.loading;
    dashboardErrorMessage = null;
    update();

    final Either<FailureModel, UserDashboardModel> result =
        await _homeRepository.getUserDashboard();

    result.fold(
      (failure) {
        dashboardStatus = failure.status;
        dashboardErrorMessage = failure.message;
        userDashboard = null;
      },
      (model) {
        dashboardStatus = RequestStatus.success;
        userDashboard = model;
        dashboardErrorMessage = null;
      },
    );
    update();
  }

  Future<void> fetchSpecialization() async {
    specializationsStatus = RequestStatus.loading;
    update();

    final Either<FailureModel, Map<dynamic, dynamic>> result =
        await _homeRepository.getSpecialization();

    result.fold(
      (failureModel) {
        specializationsStatus = failureModel.status;
        Get.snackbar(
          'Warning!',
          failureModel.message,
          backgroundColor: AppColors.accent,
        );
      },
      (response) {
        if (response['status'] == true) {
          specializationsStatus = RequestStatus.success;
          final raw = response['data'];
          if (raw is List) {
            categories = ['All', ...raw.map((e) => e.toString())];
          } else {
            categories = ['All'];
          }
        } else {
          specializationsStatus = RequestStatus.failure;
          Get.snackbar(
            'Warning!',
            response['message']?.toString() ?? 'Failed to load categories',
            backgroundColor: AppColors.accent,
          );
        }
      },
    );

    update();
  }

  Future<void> fetchDoctors({Map<String, dynamic>? params}) async {
    doctorsStatus = RequestStatus.loading;
    update();

    final result = await _homeRepository.getDoctors(queryParams: params);

    result.fold(
      (failureModel) {
        doctorsStatus = failureModel.status;
        Get.snackbar(
          'Warning!',
          failureModel.message,
          backgroundColor: AppColors.accent,
        );
      },
      (response) {
        if (response['status'] == true) {
          doctorsStatus = RequestStatus.success;
          final data = response['data'];
          List<dynamic> list;
          if (data is Map && data.containsKey('data')) {
            list = data['data'] as List<dynamic>? ?? [];
          } else if (data is List) {
            list = data;
          } else {
            list = [];
          }

          allDoctors = list
              .map((doctor) => DoctorModel.fromJson(doctor as Map<String, dynamic>))
              .toList();
          filteredDoctors = List.from(allDoctors);
        } else {
          doctorsStatus = RequestStatus.failure;
          Get.snackbar(
            'Warning!',
            response['message']?.toString() ?? 'Failed to load doctors',
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
    log('Category selected: $category');
    await fetchDoctors(params: buildDoctorListQueryParams());
  }

  /// Maps the search bar text to Laravel `/doctors` query params.
  /// Backend: `search` = OR on user name and specialization; `name` / `specialization` = single-field filters.
  void addDoctorTextSearchParams(String query, Map<String, dynamic> params) {
    if (query.isEmpty) return;
    final hasName = activeSearchCriteria.contains(SearchCriteria.name);
    final hasSpec = activeSearchCriteria.contains(SearchCriteria.specialization);
    if (hasName && !hasSpec) {
      params['name'] = query;
    } else if (hasSpec && !hasName) {
      params['specialization'] = query;
    } else {
      params['search'] = query;
    }
  }

  void toggleSearchCriteria(SearchCriteria criteria) {
    if (criteria != SearchCriteria.name &&
        criteria != SearchCriteria.specialization) {
      return;
    }
    if (activeSearchCriteria.contains(criteria)) {
      activeSearchCriteria.remove(criteria);
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

    final numericCriteria = [
      SearchCriteria.priceMin,
      SearchCriteria.priceMax,
      SearchCriteria.rating,
      SearchCriteria.experience,
      SearchCriteria.distance,
    ];

    final onlyNumeric = selectedCriteria.every(
      (c) => numericCriteria.contains(c),
    );

    return onlyNumeric ? TextInputType.number : TextInputType.text;
  }

  void onSearch(String query) async {
    if (_searchDebounce?.isActive ?? false) _searchDebounce!.cancel();
    _searchDebounce = Timer(const Duration(milliseconds: 500), () async {
      await fetchDoctors(params: buildDoctorListQueryParams());
    });
  }

  @override
  void onClose() {
    _searchDebounce?.cancel();
    searchController.dispose();
    minPriceController.dispose();
    maxPriceController.dispose();
    experienceController.dispose();
    super.onClose();
  }

  void goToDoctorProfile(DoctorModel doctor) {
    Get.toNamed(AppRoutesName.rDoctorDetails, arguments: doctor);
  }

  Future<void> goToBookAppointement() async =>
      await Get.toNamed(AppRoutesName.rBookAppointment);

  Future<void> goToHealthRecords() async =>
      await Get.toNamed(AppRoutesName.rHealthRecords);

  Future<void> goToMyPets() async => await Get.toNamed(AppRoutesName.rMyPets);
}
