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
  // Profile Controllers
  // Navigation
  var selectedIndex = 0.obs;
  // Status
  var status = RequestStatus.success.obs;
  late TextEditingController bioController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController licenseController;
  late TextEditingController fullNameController;
  late TextEditingController experienceController;
  late TextEditingController sessionCostController;
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
    sessionCostController = TextEditingController();
    clinicAddressController = TextEditingController();
    specializationController = TextEditingController();
    loadCachedUserData();
    await loadDashboardData();
  }

  void getDoctorName() {
    doctorName = fullNameController.text.isNotEmpty
        ? (fullNameController.text.startsWith("Dr.")
              ? fullNameController.text
              : "Dr. ${fullNameController.text}")
        : "Dr. Doctor";
    update();
  }

  void loadCachedUserData() {
    final prefs = Get.find<AppServices>().appSharedPrefs;
    final cachedName =
        prefs.getString(CachingKeysConstants.kUserFullName) ?? "";
    final cachedEmail = prefs.getString(CachingKeysConstants.kUserEmail) ?? "";
    final cachedPhone = prefs.getString(CachingKeysConstants.kUserPhone) ?? "";

    if (cachedName.isNotEmpty) fullNameController.text = cachedName;
    if (cachedEmail.isNotEmpty) emailController.text = cachedEmail;
    if (cachedPhone.isNotEmpty) phoneController.text = cachedPhone;

    specializationController.text =
        prefs.getString(CachingKeysConstants.kDocSpecialization) ?? "";
    experienceController.text =
        prefs.getString(CachingKeysConstants.kDocExperience) ?? "";
    licenseController.text =
        prefs.getString(CachingKeysConstants.kDocLicense) ?? "";
    bioController.text = prefs.getString(CachingKeysConstants.kDocBio) ?? "";
    sessionCostController.text =
        prefs.getString(CachingKeysConstants.kDocSessionCost) ?? "";
    clinicAddressController.text =
        prefs.getString(CachingKeysConstants.kDocClinicAddress) ?? "";

    if (prefs.containsKey(CachingKeysConstants.kDocIsOnline)) {
      isOnlineConsultation.value =
          prefs.getBool(CachingKeysConstants.kDocIsOnline) ?? true;
    }
    if (prefs.containsKey(CachingKeysConstants.kDocIsInPerson)) {
      isInPersonConsultation.value =
          prefs.getBool(CachingKeysConstants.kDocIsInPerson) ?? true;
    }
    if (prefs.containsKey(CachingKeysConstants.kDocLatitude)) {
      latitude.value =
          prefs.getDouble(CachingKeysConstants.kDocLatitude) ?? 30.05;
    }
    if (prefs.containsKey(CachingKeysConstants.kDocLongitude)) {
      longitude.value =
          prefs.getDouble(CachingKeysConstants.kDocLongitude) ?? 31.233;
    }

    // Fix 8 — Restore cached doctor image so avatar shows instantly on cold start
    final cachedImg =
        prefs.getString(CachingKeysConstants.kDoctorImageUrl) ?? '';
    if (cachedImg.isNotEmpty) imageUrl.value = cachedImg;

    getDoctorName();
  }

  /// Fix 5 — Sequential calls with individual try-catch error isolation.
  /// Each method already catches its own errors, so a single failure will NOT
  /// abort the remaining fetches (unlike Future.wait which short-circuits).
  Future<void> loadDashboardData() async {
    status.value = RequestStatus.loading;
    update();
    await fetchAnalytics();
    await fetchAppointments();
    await fetchProfile();
    status.value = RequestStatus.success;
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

  /// Fix 2 — Safe list extraction via the repository's static helper.
  /// Prevents NoSuchMethodError when the response shape differs.
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

        // Updates the UI controllers
        fullNameController.text = profile.fullName;
        emailController.text = profile.email;
        phoneController.text = profile.phone;
        specializationController.text = profile.specialization;
        bioController.text = profile.bio;
        licenseController.text = profile.licenseNumber;
        experienceController.text = profile.experienceYears.toString();
        sessionCostController.text = profile.consultationFee.toString();
        clinicAddressController.text = profile.clinicAddress;
        isOnlineConsultation.value = profile.isOnline;
        isInPersonConsultation.value = profile.isInPerson;
        // ... and so on for all fields, then calls update() to refresh the UI
      }
    } catch (e) {
      log("ERROR FETCHING PROFILE: $e");
    }
    update();
  }

  // Future<void> fetchProfile() async {
  //   try {
  //     final response = await _repository.getProfile();
  //     if (response.statusCode == 200) {
  //       final profile = DoctorProfileModel.fromMap(response.data['data']);
  //       fullNameController.text = profile.fullName;
  //       emailController.text = profile.email;
  //       phoneController.text = profile.phone;
  //       specializationController.text = profile.specialization;
  //       experienceController.text = profile.experienceYears.toString();
  //       licenseController.text = profile.licenseNumber;
  //       bioController.text = profile.bio;
  //       sessionCostController.text = profile.consultationFee.toStringAsFixed(0);
  //       clinicAddressController.text = profile.clinicAddress;
  //       isOnlineConsultation.value = profile.isOnline;
  //       isInPersonConsultation.value = profile.isInPerson;
  //       imageUrl.value = profile.imageUrl;
  //       availabilities.value = profile.availabilities;
  //       latitude.value = profile.latitude;
  //       longitude.value = profile.longitude;

  //       final prefs = Get.find<AppServices>().appSharedPrefs;
  //       if (profile.fullName.isNotEmpty) {
  //         prefs.setString(CachingKeysConstants.kUserFullName, profile.fullName);
  //       }
  //       if (profile.email.isNotEmpty) {
  //         prefs.setString(CachingKeysConstants.kUserEmail, profile.email);
  //       }
  //       if (profile.phone.isNotEmpty) {
  //         prefs.setString(CachingKeysConstants.kUserPhone, profile.phone);
  //       }

  //       prefs.setString(
  //         CachingKeysConstants.kDocSpecialization,
  //         profile.specialization,
  //       );
  //       prefs.setString(
  //         CachingKeysConstants.kDocExperience,
  //         profile.experienceYears.toString(),
  //       );
  //       prefs.setString(
  //         CachingKeysConstants.kDocLicense,
  //         profile.licenseNumber,
  //       );
  //       prefs.setString(CachingKeysConstants.kDocBio, profile.bio);
  //       prefs.setString(
  //         CachingKeysConstants.kDocSessionCost,
  //         profile.consultationFee.toStringAsFixed(0),
  //       );
  //       prefs.setString(
  //         CachingKeysConstants.kDocClinicAddress,
  //         profile.clinicAddress,
  //       );

  //       prefs.setBool(CachingKeysConstants.kDocIsOnline, profile.isOnline);
  //       prefs.setBool(CachingKeysConstants.kDocIsInPerson, profile.isInPerson);
  //       prefs.setDouble(CachingKeysConstants.kDocLatitude, profile.latitude);
  //       prefs.setDouble(CachingKeysConstants.kDocLongitude, profile.longitude);

  //       // Fix 8 — Persist image URL so avatar loads instantly on next cold start
  //       if (profile.imageUrl.isNotEmpty) {
  //         prefs.setString(
  //           CachingKeysConstants.kDoctorImageUrl,
  //           profile.imageUrl,
  //         );
  //       }

  //       getDoctorName();
  //       update(); // Fix 4 — ensure GetBuilder<WelcomeBox> rebuilds after name is set
  //     }
  //   } catch (e) {
  //     log("ERROR FETCHING PROFILE: $e");
  //     try {
  //       log("RESPONSE DATA: ${(e as dynamic).response?.data}");
  //     } catch (_) {}
  //   }
  //   update();
  // }

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

      // Fix 3 — Cast booleans to int (0/1); FormData cannot reliably encode Dart bools
      final profileData = {
        'name': fullNameController.text,
        'email': emailController.text,
        'phone': phoneController.text,
        'specialization': specializationController.text.isEmpty ? 'General' : specializationController.text,
        'experience_years': int.tryParse(experienceController.text.trim()) ?? 0,
        'license_number': licenseController.text,
        'bio': bioController.text,
        'consultation_fee': double.tryParse(sessionCostController.text.trim()) ?? 0.0,
        'clinic_address': clinicAddressController.text,
        'is_online': isOnlineConsultation.value ? 1 : 0,
        'is_in_person': isInPersonConsultation.value ? 1 : 0,
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

  /// Fix 9 — Update appointment status with optimistic local update.
  /// Updates the local list instantly on success without re-fetching everything.
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
        // Optimistic local update — no full reload needed
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
        // 'upcoming' is already the normalized value for 'pending'
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

  /// Fix 1 — Clears all auth tokens/keys before navigating away.
  /// Without this a logged-out user's token stays valid for subsequent requests.
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
