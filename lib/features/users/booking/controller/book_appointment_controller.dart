import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/classes/crud.dart';
import '../../../../core/constants/link_api.dart';
import '../../../../core/network/request_status.dart';
import '../../../../core/routes/app_routes_name.dart';
import '../../../../core/services/app_service.dart';
import '../../../doctors/portal/appointments/data/datasource/appointment_datasource.dart';
import '../../../doctors/portal/appointments/data/models/animal_model.dart';
import '../model/doctor_model.dart';

class BookAppointmentController extends GetxController {
  // ── Tab state (About / Sessions / Reviews) ──────────────────────────────────
  RxInt selectedTabIndex = 0.obs;

  // ── Selected doctor (passed from Home via Get.arguments) ───────────────────
  DoctorModel? currentDoctor;

  // ── Availability calendar ──────────────────────────────────────────────────
  List<Map<String, dynamic>> availableDays = [];
  RequestStatus calendarStatus = RequestStatus.noData;

  // ── Time slots ─────────────────────────────────────────────────────────────
  List<String> availableSlots = [];
  RequestStatus slotsStatus = RequestStatus.noData;

  // ── User's animals (pets) ─────────────────────────────────────────────────
  List<AnimalModel> animals = [];
  RequestStatus animalsStatus = RequestStatus.noData;

  // ── User selections ────────────────────────────────────────────────────────
  String? selectedDate;
  String? selectedSlot;
  AnimalModel? selectedAnimal;
  String sessionType = 'online'; // online | clinic | home_visit
  String notes = '';

  // ── Booking submission ─────────────────────────────────────────────────────
  RequestStatus bookingStatus = RequestStatus.noData;

  late final AppointmentDatasource _appointmentDatasource;
  late final Crud _crud;
  final TextEditingController notesController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    _crud = Get.find<AppServices>().crud;
    _appointmentDatasource = AppointmentDatasource(crud: _crud);

    // Read doctor passed from home screen
    if (Get.arguments is DoctorModel) {
      currentDoctor = Get.arguments as DoctorModel;
      _loadInitialData();
    }
  }

  Future<void> _loadInitialData() async {
    await Future.wait([fetchAvailabilityCalendar(), fetchAnimals()]);
  }

  // ── Tab ────────────────────────────────────────────────────────────────────
  void changeTab(int index) {
    selectedTabIndex.value = index;
  }

  // ── Availability calendar ──────────────────────────────────────────────────
  Future<void> fetchAvailabilityCalendar() async {
    if (currentDoctor == null) return;
    calendarStatus = RequestStatus.loading;
    update();

    // Reuse HomeDatasource logic via Crud
    final uri = Uri.parse(
      AppLink.availabilityCalendar(currentDoctor!.id.toString()),
    );
    final result = await _crud.get(uri.toString());
    result.fold((failure) => calendarStatus = failure.status, (json) {
      calendarStatus = RequestStatus.success;
      final list = json['data'] as List? ?? [];
      availableDays = list
          .map((e) => Map<String, dynamic>.from(e as Map))
          .toList();
    });
    update();
  }

  // ── Slots for selected date ────────────────────────────────────────────────
  Future<void> onDateSelected(String date) async {
    if (currentDoctor == null) return;
    selectedDate = date;
    selectedSlot = null;
    slotsStatus = RequestStatus.loading;
    update();

    final uri = Uri.parse(
      AppLink.availableSlots(currentDoctor!.id.toString()),
    ).replace(queryParameters: {'date': date});

    final result = await _crud.get(uri.toString());
    result.fold((failure) => slotsStatus = failure.status, (json) {
      slotsStatus = RequestStatus.success;
      final data = json['data'] as Map<String, dynamic>? ?? {};
      final slots = data['available_slots'] as List? ?? [];
      availableSlots = slots.map((s) => s['time'].toString()).toList();
    });
    update();
  }

  // ── Animals (pets) ─────────────────────────────────────────────────────────
  Future<void> fetchAnimals() async {
    animalsStatus = RequestStatus.loading;
    update();

    final result = await _crud.get(AppLink.myAnimals);
    result.fold((failure) => animalsStatus = failure.status, (json) {
      animalsStatus = RequestStatus.success;
      final raw = json['data'];
      List list = raw is List
          ? raw
          : (raw is Map && raw['data'] is List ? raw['data'] as List : []);
      animals = list
          .map((e) => AnimalModel.fromJson(e as Map<String, dynamic>))
          .toList();
      if (animals.isNotEmpty) selectedAnimal = animals.first;
    });
    update();
  }

  void onSlotSelected(String slot) {
    selectedSlot = slot;
    update();
  }

  void onAnimalSelected(AnimalModel animal) {
    selectedAnimal = animal;
    update();
  }

  void onSessionTypeChanged(String type) {
    sessionType = type;
    update();
  }

  // ── Submit booking ─────────────────────────────────────────────────────────
  Future<void> confirmBooking() async {
    if (currentDoctor == null ||
        selectedDate == null ||
        selectedSlot == null ||
        selectedAnimal == null) {
      Get.snackbar('Missing Info', 'Please select a date, time slot and pet.');
      return;
    }

    bookingStatus = RequestStatus.loading;
    update();

    final dateTime = '$selectedDate $selectedSlot';

    try {
      final response = await _appointmentDatasource.bookAppointment(
        doctorId: currentDoctor!.id.toString(),
        animalId: selectedAnimal!.id.toString(),
        dateTime: dateTime,
        type: sessionType == 'in-person' ? 'clinic' : sessionType,
        reason: notesController.text.trim().length >= 5
            ? notesController.text.trim()
            : 'General Consultation',
        notes: notesController.text.trim().isNotEmpty
            ? notesController.text.trim()
            : null,
      );

      if (response['status'] == true) {
        bookingStatus = RequestStatus.success;
        Get.snackbar('Success', 'Appointment booked successfully!');

        final appointmentId = response['data']['id'];

        Get.toNamed(
          AppRoutesName.rPayment,
          arguments: {
            "appointmentId": appointmentId.toString(),
            "doctorName": currentDoctor!.name,
            "sessionType": sessionType,
            "price": sessionType == 'online'
                ? (currentDoctor!.consultationFeeOnline ?? 0.0)
                : (currentDoctor!.consultationFeeOffline ?? 0.0),
          },
        );
      } else {
        bookingStatus = RequestStatus.failure;
        Get.snackbar(
          'Error',
          response['message']?.toString() ?? 'Booking failed',
        );
      }
    } catch (e) {
      bookingStatus = RequestStatus.failure;
      Get.snackbar('Error', e.toString());
    }
    update();
  }

  // ── Navigate to booking screen ─────────────────────────────────────────────
  void bookAppointment() {
    Get.toNamed(AppRoutesName.rBookAppointment, arguments: currentDoctor);
  }
}
