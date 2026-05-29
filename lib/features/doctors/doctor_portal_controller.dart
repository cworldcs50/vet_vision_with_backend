import 'dart:developer';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../core/services/app_service.dart';
import 'package:image_picker/image_picker.dart';
import '../../core/routes/app_routes_name.dart';
import '../../core/network/request_status.dart';
import '../../core/constants/caching_keys_constants.dart';
import 'portal/profile/data/models/doctor_profile_model.dart';
import 'portal/dashboard/data/models/doctor_analytics_model.dart';
import 'portal/appointments/data/models/doctor_appointment_model.dart';
import 'portal/dashboard/data/repository/doctor_dashboard_repository.dart';

class DoctorPortalController extends GetxController {
  String doctorName = "";

  // Navigation
  var selectedIndex = 0.obs;

  // Status
  var status = RequestStatus.success.obs;

  // Profile Text Controllers
  late TextEditingController bioController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController licenseController;
  late TextEditingController fullNameController;
  late TextEditingController experienceController;
  late TextEditingController sessionCostOnlineController;
  late TextEditingController sessionCostOfflineController;
  late TextEditingController clinicAddressController;
  late TextEditingController specializationController;

  final DoctorDashboardRepository _repository = DoctorDashboardRepository();

  @override
  void onInit() async {
    super.onInit();
    bioController = TextEditingController();
    emailController = TextEditingController();
    phoneController = TextEditingController();
    licenseController = TextEditingController();
    fullNameController = TextEditingController();
    experienceController = TextEditingController();
    sessionCostOnlineController = TextEditingController();
    sessionCostOfflineController = TextEditingController();
    clinicAddressController = TextEditingController();
    specializationController = TextEditingController();

    await loadDashboardData();
  }

  void getDoctorName() {
    doctorName = fullNameController.text.isNotEmpty
        ? (fullNameController.text.startsWith("Dr.")
              ? fullNameController.text
              : "Dr. ${fullNameController.text}")
        : "";
    update();
  }

  /// Loads all dashboard data sequentially.
  /// Profile is fetched first to ensure the UI updates as quickly as possible.
  Future<void> loadDashboardData() async {
    status.value = RequestStatus.loading;
    update();

    // Fetch profile first to instantly update the portal with endpoint data
    await fetchProfile();
    await fetchAnalytics();
    await fetchAppointments();

    status.value = RequestStatus.success;
    update();
  }

  // =========================
  // Image Picker
  // =========================
  final ImagePicker imagePicker = ImagePicker();
  XFile? profileImage;
  bool _imgPickerIsOpened = false;

  Future<void> pickImage() async {
    if (_imgPickerIsOpened) return;
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

  // =========================
  // Dashboard Statistics
  // =========================
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

  // =========================
  // Appointments
  // =========================
  var appointments = <DoctorAppointmentModel>[].obs;

  Future<void> fetchAppointments() async {
    try {
      final response = await _repository.getAllAppointments();
      if (response.statusCode == 200) {
        final list = DoctorDashboardRepository.extractAppointmentList(
          response.data as Map<String, dynamic>,
        );
        appointments.value = list
            .map((e) => DoctorAppointmentModel.fromMap(e))
            .toList();
      }
    } catch (e) {
      log("Error fetching appointments: $e");
    }
    update();
  }

  // =========================
  // Profile
  // =========================
  var imageUrl = "".obs;
  var availabilities = <Map<String, dynamic>>[].obs;
  var latitude = 30.05.obs;
  var longitude = 31.233.obs;
  var isOnlineConsultation = true.obs;
  var isInPersonConsultation = true.obs;

  /// Always fetches the doctor profile fresh from the backend API.
  /// Updates all controllers and caches only for offline resilience.
  Future<void> fetchProfile() async {
    try {
      final response = await _repository.getProfile();
      if (response.statusCode == 200) {
        final profile = DoctorProfileModel.fromMap(response.data['data']);

        // Update all UI controllers with fresh API data
        fullNameController.text = profile.fullName;
        emailController.text = profile.email;
        phoneController.text = profile.phone;
        specializationController.text = profile.specialization;
        experienceController.text = profile.experienceYears.toString();
        licenseController.text = profile.licenseNumber;
        bioController.text = profile.bio;
        // Backend returns a single consultation_fee — populate the single field
        sessionCostOnlineController.text = profile.consultationFeeOnline
            .toStringAsFixed(0);
        sessionCostOfflineController.text = profile.consultationFeeOffline
            .toStringAsFixed(0);
        clinicAddressController.text = profile.clinicAddress;
        isOnlineConsultation.value = profile.isOnline;
        isInPersonConsultation.value = profile.isInPerson;
        imageUrl.value = profile.imageUrl;
        availabilities.value = profile.availabilities;
        latitude.value = profile.latitude;
        longitude.value = profile.longitude;

        // Cache values for offline resilience only
        final prefs = Get.find<AppServices>().appSharedPrefs;
        if (profile.fullName.isNotEmpty) {
          prefs.setString(CachingKeysConstants.kUserFullName, profile.fullName);
        }
        if (profile.email.isNotEmpty) {
          prefs.setString(CachingKeysConstants.kUserEmail, profile.email);
        }
        if (profile.phone.isNotEmpty) {
          prefs.setString(CachingKeysConstants.kUserPhone, profile.phone);
        }
        prefs.setString(
          CachingKeysConstants.kDocSpecialization,
          profile.specialization,
        );
        prefs.setString(
          CachingKeysConstants.kDocExperience,
          profile.experienceYears.toString(),
        );
        prefs.setString(
          CachingKeysConstants.kDocLicense,
          profile.licenseNumber,
        );
        prefs.setString(CachingKeysConstants.kDocBio, profile.bio);
        prefs.setString(
          CachingKeysConstants.kDocSessionCostOnline,
          profile.consultationFeeOnline.toStringAsFixed(0),
        );
        prefs.setString(
          CachingKeysConstants.kDocSessionCostOffline,
          profile.consultationFeeOffline.toStringAsFixed(0),
        );
        prefs.setString(
          CachingKeysConstants.kDocClinicAddress,
          profile.clinicAddress,
        );
        prefs.setBool(CachingKeysConstants.kDocIsOnline, profile.isOnline);
        prefs.setBool(CachingKeysConstants.kDocIsInPerson, profile.isInPerson);
        prefs.setDouble(CachingKeysConstants.kDocLatitude, profile.latitude);
        prefs.setDouble(CachingKeysConstants.kDocLongitude, profile.longitude);

        if (profile.imageUrl.isNotEmpty) {
          prefs.setString(
            CachingKeysConstants.kDoctorImageUrl,
            profile.imageUrl,
          );
          imageUrl.value = profile.imageUrl;
        }

        getDoctorName();
      }
    } catch (e) {
      log('ERROR FETCHING PROFILE: $e');
      try {
        log('RESPONSE DATA: ${(e as dynamic).response?.data}');
      } catch (_) {}
    }
    update();
  }

  void addAvailability(String day, String startTime, String endTime) {
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
      availabilities.refresh();
      update();
    }
  }

  void removeAvailability(int index) {
    availabilities.removeAt(index);
    availabilities.refresh();
    update();
  }

  /// Sends all profile fields to the backend and refreshes from API on success.
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

      // Build profile payload with both fee fields
      final profileData = {
        'email': emailController.text,
        'phone': phoneController.text,
        'name': fullNameController.text,
        'specialization': specializationController.text.isEmpty
            ? 'General'
            : specializationController.text,
        'experience_years': int.tryParse(experienceController.text.trim()) ?? 0,
        'license_number': licenseController.text,
        'bio': bioController.text,
        'consultation_fee_online':
            (double.tryParse(sessionCostOnlineController.text.trim()) ?? 0.0)
                .toInt(),
        'consultation_fee_offline':
            (double.tryParse(sessionCostOfflineController.text.trim()) ?? 0.0)
                .toInt(),
        'clinic_address': clinicAddressController.text,
        'is_online_available': isOnlineConsultation.value ? 1 : 0,
        'is_offline_available': isInPersonConsultation.value ? 1 : 0,
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

        // Re-fetch from API to ensure UI shows actual saved data
        await fetchProfile();

        Get.snackbar(
          "Success",
          "Profile updated successfully",
          colorText: Colors.white,
          backgroundColor: Colors.green,
          snackPosition: SnackPosition.BOTTOM,
        );
      } else {
        Get.snackbar(
          "Error",
          "Failed to update profile. Please try again.",
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      Get.back(); // Close loading dialog
      log("ERROR UPDATING PROFILE: $e");
      try {
        log("RESPONSE DATA: ${(e as dynamic).response?.data}");
      } catch (_) {}
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

  Future<void> updateAppointmentStatus(
    String appointmentId,
    String newStatus,
  ) async {
    try {
      final response = await _repository.updateAppointmentStatus(
        appointmentId,
        newStatus,
      );
      if (response.statusCode == 200) {
        final index = appointments.indexWhere((a) => a.id == appointmentId);
        if (index != -1) {
          final old = appointments[index];
          appointments[index] = DoctorAppointmentModel(
            id: old.id,
            patientName: old.patientName,
            petName: old.petName,
            petType: old.petType,
            date: old.date,
            time: old.time,
            isOnline: old.isOnline,
            isPaid: old.isPaid,
            status: newStatus,
            notes: old.notes,
          );
          appointments.refresh();
        }
        Get.snackbar(
          "Success",
          "Appointment marked as $newStatus",
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      log("Error updating appointment status: $e");
      Get.snackbar(
        "Error",
        "Could not update appointment status",
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
    sessionCostOnlineController.dispose();
    sessionCostOfflineController.dispose();
    clinicAddressController.dispose();
    super.onClose();
  }

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

  void logout() async {
    final prefs = Get.find<AppServices>().appSharedPrefs;
    await prefs.remove(CachingKeysConstants.kUserToken);
    await prefs.remove(CachingKeysConstants.kUserEmail);
    await prefs.remove(CachingKeysConstants.kUserFullName);
    await prefs.remove(CachingKeysConstants.kUserPhone);
    await prefs.remove(CachingKeysConstants.kDoctorImageUrl);
    Get.offAllNamed(AppRoutesName.rRoleSelection);
  }
}
