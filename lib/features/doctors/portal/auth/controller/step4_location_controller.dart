import 'dart:async';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:dio/dio.dart' as dio;
import '../../../../../../core/services/app_service.dart';
import '../../../../../../core/constants/caching_keys_constants.dart';
import '../../../../../../core/routes/app_routes_name.dart';
import '../../../../../../core/network/request_status.dart';
import '../data/repository/doctor_auth_repository.dart';
import 'step2_professional_details_controller.dart';
import 'step3_practice_details_controller.dart';

class Step4LocationController extends GetxController {
  final DoctorAuthRepository _repository = DoctorAuthRepository();
  
  List<Marker> markers = [];
  CameraPosition? currentPos;
  Rx<RequestStatus> requestStatus = RequestStatus.success.obs;
  late double lat, long;
  final Completer<GoogleMapController> googleMapcontroller =
      Completer<GoogleMapController>();

  void addMarker(LatLng latLng) {
    markers.clear();
    markers.add(Marker(
      markerId: MarkerId("${latLng.latitude}"),
      position: latLng,
    ));
    lat = latLng.latitude;
    long = latLng.longitude;
    update();
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    await getCurrentPos();
  }

  Future<void> getCurrentPos() async {
    requestStatus.value = RequestStatus.loading;
    update();
    try {
      // Check permission
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      
      if (permission == LocationPermission.deniedForever) {
        Get.snackbar("Permission Denied", "Location permissions are permanently denied.");
        requestStatus.value = RequestStatus.failure;
        return;
      }

      final Position pos = await Geolocator.getCurrentPosition();
      currentPos = CameraPosition(
        target: LatLng(pos.latitude, pos.longitude),
        zoom: 15,
      );
      lat = pos.latitude;
      long = pos.longitude;
      addMarker(LatLng(lat, long));
      requestStatus.value = RequestStatus.success;
    } catch (e) {
      requestStatus.value = RequestStatus.failure;
      Get.snackbar("Error", "Could not get current location: $e");
    }
    update();
  }

  Future<void> completeRegistration() async {
    try {
      Get.dialog(
        const Center(child: CircularProgressIndicator(color: Color(0xFF009689))),
        barrierDismissible: false,
      );

      final step2Controller = Get.find<Step2ProfessionalDetailsController>();
      final step3Controller = Get.find<Step3PracticeDetailsController>();
      final prefs = Get.find<AppServices>().appSharedPrefs;
      final token = prefs.getString(CachingKeysConstants.kUserToken) ?? "";

      final profileData = {
        'specialization': step2Controller.specializationController.text,
        'experience_years': step2Controller.experienceController.text,
        'bio': step2Controller.bioController.text,
        'consultation_fee': step3Controller.sessionCostController.text,
        'clinic_address': step3Controller.clinicAddressController.text,
        'latitude': lat,
        'longitude': long,
      };

      final response = await _repository.completeDoctorProfile(
        profileData: profileData,
        imagePath: step2Controller.profileImage?.path,
        token: token,
      );
      Get.back(); // close loading

      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.snackbar(
          "Success",
          "Registration completed successfully!",
          snackPosition: SnackPosition.BOTTOM,
        );
        Get.offAllNamed(AppRoutesName.rDoctorPortal);
      }
    } on dio.DioException catch (e) {
      Get.back();
      final responseData = e.response?.data;
      String errorMsg = "Profile completion failed";
      if (responseData != null) {
        errorMsg = responseData['message'] ?? errorMsg;
      }
      Get.snackbar("Error", errorMsg, snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      Get.back();
      Get.snackbar("Error", e.toString(), snackPosition: SnackPosition.BOTTOM);
    }
  }
}
