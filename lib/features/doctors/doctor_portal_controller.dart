import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../core/routes/app_routes_name.dart';
import 'portal/appointments/data/models/doctor_appointment_model.dart';
import 'portal/dashboard/data/repository/doctor_dashboard_repository.dart';
import 'portal/dashboard/data/models/doctor_analytics_model.dart';
import 'portal/profile/data/models/doctor_profile_model.dart';
import '../../core/network/request_status.dart';

class DoctorPortalController extends GetxController {
  final DoctorDashboardRepository _repository = DoctorDashboardRepository();
  String doctorName = "";
  // Navigation
  var selectedIndex = 0.obs;

  // Status
  var status = RequestStatus.success.obs;

  void getDoctorName() {
    doctorName = fullNameController.text.isNotEmpty
        ? (fullNameController.text.startsWith("Dr.")
              ? fullNameController.text
              : "Dr. ${fullNameController.text}")
        : "Dr. Doctor";
    update();
  }

  // Profile Controllers
  late TextEditingController fullNameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController specializationController;
  late TextEditingController experienceController;
  late TextEditingController licenseController;
  late TextEditingController bioController;
  late TextEditingController sessionCostController;
  late TextEditingController clinicAddressController;

  @override
  void onInit() {
    super.onInit();
    fullNameController = TextEditingController();
    emailController = TextEditingController();
    phoneController = TextEditingController();
    specializationController = TextEditingController();
    experienceController = TextEditingController();
    licenseController = TextEditingController();
    bioController = TextEditingController();
    sessionCostController = TextEditingController();
    clinicAddressController = TextEditingController();
    getDoctorName();

    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    status.value = RequestStatus.loading;
    update();
    try {
      await Future.wait([
        fetchAnalytics(),
        fetchAppointments(),
        fetchProfile(),
      ]);
      status.value = RequestStatus.success;
    } catch (e) {
      status.value = RequestStatus.failure;
      Get.snackbar("Error", "Failed to load dashboard data");
    }
    update();
  }

  // =========================
  // Image Picker
  // =========================
  final ImagePicker imagePicker = ImagePicker();

  XFile? profileImage;
  bool _imgPickerIsOpened = false;

  // =========================
  // Methods
  // =========================

  Future<void> pickImage() async {
    if (_imgPickerIsOpened) {
      return;
    }

    _imgPickerIsOpened = true;

    final XFile? image = await imagePicker.pickImage(
      source: ImageSource.gallery,
    );

    if (image != null) {
      profileImage = image;
      update();
    }

    _imgPickerIsOpened = false;
  }

  // Dashboard Statistics
  var todayAppointmentsCount = 0.obs;
  var totalPatientsCount = 0.obs;
  var monthlyEarnings = 0.0.obs;
  var growthPercentage = "0%".obs;

  Future<void> fetchAnalytics() async {
    try {
      final response = await _repository.getAnalytics();
      if (response.statusCode == 200) {
        final analytics = DoctorAnalyticsModel.fromMap(response.data['data']);
        monthlyEarnings.value = analytics.monthlyEarnings;
        growthPercentage.value = analytics.growthPercentage;
        totalPatientsCount.value = analytics.totalPatients;
        todayAppointmentsCount.value = analytics.todayAppointmentsCount;
      }
    } catch (e) {
      log("Error fetching analytics: $e");
    }
    update();
  }

  // Appointments
  var appointments = <DoctorAppointmentModel>[].obs;

  Future<void> fetchAppointments() async {
    try {
      final response = await _repository.getAllAppointments();
      if (response.statusCode == 200) {
        final List data =
            response.data['data']['data'] ?? response.data['data'];
        appointments.value = data
            .map((e) => DoctorAppointmentModel.fromMap(e))
            .toList();
      }
    } catch (e) {
      log("Error fetching appointments: $e");
    }
    update();
  }

  // Profile
  var imageUrl = "".obs;
  var availabilities = <Map<String, dynamic>>[].obs;
  var latitude = 30.05.obs;
  var longitude = 31.233.obs;

  void addAvailability(String day, String startTime, String endTime) {
    // Prevent duplicate entries of the same day and time
    final exists = availabilities.any(
      (e) =>
          e['day'] == day &&
          e['start_time'] == startTime &&
          e['end_time'] == endTime,
    );
    if (!exists) {
      availabilities.add({
        'day': day,
        'start_time': startTime,
        'end_time': endTime,
      });
      update();
    }
  }

  void removeAvailability(int index) {
    availabilities.removeAt(index);
    update();
  }

  Future<void> fetchProfile() async {
    try {
      final response = await _repository.getProfile();
      if (response.statusCode == 200) {
        final profile = DoctorProfileModel.fromMap(response.data['data']);
        fullNameController.text = profile.fullName;
        emailController.text = profile.email;
        phoneController.text = profile.phone;
        specializationController.text = profile.specialization;
        experienceController.text = profile.experienceYears.toString();
        bioController.text = profile.bio;
        sessionCostController.text = profile.consultationFee.toStringAsFixed(0);
        clinicAddressController.text = profile.clinicAddress;
        isOnlineConsultation.value = profile.isOnline;
        isInPersonConsultation.value = profile.isInPerson;
        imageUrl.value = profile.imageUrl;
        availabilities.value = profile.availabilities;
        latitude.value = profile.latitude;
        longitude.value = profile.longitude;
      }
    } catch (e) {
      log("Error fetching profile: $e");
    }
    update();
  }

  Future<void> updateProfile() async {
    try {
      Get.dialog(
        const Center(
          child: CircularProgressIndicator(color: Color(0xFF009689)),
        ),
        barrierDismissible: false,
      );

      // Save availabilities to backend
      await _repository.setAvailability(availabilities);

      final profileData = {
        'name': fullNameController.text,
        'email': emailController.text,
        'phone': phoneController.text,
        'specialization': specializationController.text,
        'experience_years': experienceController.text,
        'bio': bioController.text,
        'consultation_fee': sessionCostController.text,
        'clinic_address': clinicAddressController.text,
        'is_online': isOnlineConsultation.value,
        'is_in_person': isInPersonConsultation.value,
        'latitude': latitude.value,
        'longitude': longitude.value,
      };

      final response = await _repository.updateDoctorProfile(
        profileData,
        imagePath: profileImage?.path,
      );
      Get.back(); // Close loading dialog

      if (response.statusCode == 200) {
        profileImage = null; // Clear picked image on success
        Get.snackbar(
          "Success",
          "Profile updated successfully",
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
        await fetchProfile(); // Refresh data
      }
    } catch (e) {
      Get.back(); // Close loading dialog
      Get.snackbar(
        "Error",
        "Failed to update profile",
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
    update();
  }

  @override
  void onClose() {
    fullNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    specializationController.dispose();
    experienceController.dispose();
    licenseController.dispose();
    bioController.dispose();
    sessionCostController.dispose();
    clinicAddressController.dispose();
    super.onClose();
  }

  // Consultation Types
  var isOnlineConsultation = true.obs;
  var isInPersonConsultation = true.obs;

  // Search and Filters
  var searchQuery = "".obs;
  var selectedFilter = "All".obs;

  List<DoctorAppointmentModel> get filteredAppointments {
    return appointments.where((a) {
      bool matchesSearch =
          a.patientName.toLowerCase().contains(
            searchQuery.value.toLowerCase(),
          ) ||
          a.petName.toLowerCase().contains(searchQuery.value.toLowerCase());

      bool matchesFilter = true;
      if (selectedFilter.value == "Upcoming") {
        matchesFilter = a.status == "upcoming" || a.status == "confirmed";
      } else if (selectedFilter.value == "Completed") {
        matchesFilter = a.status == "completed";
      }

      return matchesSearch && matchesFilter;
    }).toList();
  }

  List<DoctorAppointmentModel> get todaySchedule {
    final today = DateTime.now();
    return appointments.where((a) {
      return a.date.year == today.year &&
          a.date.month == today.month &&
          a.date.day == today.day &&
          (a.status == "upcoming" || a.status == "confirmed");
    }).toList();
  }

  void updateIndex(int index) {
    selectedIndex.value = index;
  }

  void logout() {
    Get.offAllNamed(AppRoutesName.rRoleSelection);
  }
}
