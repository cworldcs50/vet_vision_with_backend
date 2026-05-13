import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'portal/appointments/data/models/doctor_appointment_model.dart';

class DoctorPortalController extends GetxController {
  // Navigation
  var selectedIndex = 0.obs;

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
    fullNameController = TextEditingController(text: "Dr. Ahmed Hassan");
    emailController = TextEditingController(text: "ahmed.hassan@example.com");
    phoneController = TextEditingController(text: "+20 123 456 7890");
    specializationController = TextEditingController(text: "Small Animal Internist");
    experienceController = TextEditingController(text: "12");
    licenseController = TextEditingController(text: "VET-987654");
    bioController = TextEditingController(text: "Experienced veterinarian with a focus on small animal internal medicine and surgery.");
    sessionCostController = TextEditingController(text: "50");
    clinicAddressController = TextEditingController(text: "123 Vet Clinic St, Cairo, Egypt");
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

  // Mock Data for Dashboard
  var todayAppointmentsCount = 2.obs;
  var totalPatientsCount = 5.obs;
  var monthlyEarnings = 2450.0.obs;
  var growthPercentage = 18.obs;

  // Mock Appointments
  var appointments = <DoctorAppointmentModel>[
    DoctorAppointmentModel(
      id: "1",
      patientName: "Sarah Johnson",
      petName: "Max",
      petType: "Dog",
      date: DateTime.now(),
      time: "09:30 AM",
      isOnline: false,
      isPaid: true,
      status: "upcoming",
      notes: "Annual checkup and vaccination",
    ),
    DoctorAppointmentModel(
      id: "2",
      patientName: "Mohammed Ali",
      petName: "Luna",
      petType: "Cat",
      date: DateTime.now(),
      time: "10:30 AM",
      isOnline: true,
      isPaid: true,
      status: "upcoming",
      notes: "Follow-up consultation for skin condition",
    ),
    DoctorAppointmentModel(
      id: "3",
      patientName: "Lisa Brown",
      petName: "Charlie",
      petType: "Rabbit",
      date: DateTime.now().subtract(const Duration(days: 9)),
      time: "01:30 PM",
      isOnline: false,
      isPaid: false,
      status: "completed",
      notes: "In-Person consultation",
    ),
    DoctorAppointmentModel(
      id: "4",
      patientName: "Ahmed Hassan",
      petName: "Whiskers",
      petType: "Cat",
      date: DateTime.now().subtract(const Duration(days: 10)),
      time: "11:00 AM",
      isOnline: true,
      isPaid: true,
      status: "completed",
      notes: "Dietary consultation",
    ),
    DoctorAppointmentModel(
      id: "5",
      patientName: "Emily Chen",
      petName: "Buddy",
      petType: "Dog",
      date: DateTime.now().add(const Duration(days: 1)),
      time: "02:00 PM",
      isOnline: false,
      isPaid: false,
      status: "upcoming",
      notes: "Limping in right leg, needs examination",
    ),
  ].obs;

  List<DoctorAppointmentModel> get filteredAppointments {
    return appointments.where((a) {
      bool matchesSearch = a.patientName.toLowerCase().contains(searchQuery.value.toLowerCase()) ||
          a.petName.toLowerCase().contains(searchQuery.value.toLowerCase());
      
      bool matchesFilter = true;
      if (selectedFilter.value == "Upcoming") {
        matchesFilter = a.status == "upcoming";
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
          a.status == "upcoming";
    }).toList();
  }

  void updateIndex(int index) {
    selectedIndex.value = index;
  }

  void logout() {
    // Implement logout logic
    Get.offAllNamed('/role-selection');
  }
}
