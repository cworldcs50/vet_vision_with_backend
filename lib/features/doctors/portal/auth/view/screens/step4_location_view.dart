import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../../../core/classes/adaptive_layout.dart';
import '../../../../../../core/network/request_status.dart';
import '../../../../widgets/step_title.dart';
import '../../../custom_auth_button.dart';
import '../../controller/step4_location_controller.dart';

class Step4LocationView extends GetView<Step4LocationController> {
  const Step4LocationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Clinic Location",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF009689),
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      body: GetBuilder<Step4LocationController>(
        init: Step4LocationController(),
        builder: (controller) {
          if (controller.requestStatus.value == RequestStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xFF009689)),
            );
          }

          return Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: AdaptiveLayout.getResponsiveFontSize(
                    context,
                    fontSize: 12,
                  ),
                ),
                child: StepTitle(
                  title: "Where is your clinic?",
                  subtitle: "Tap on the map to set your precise location",
                ),
              ),
              Expanded(
                child: controller.currentPos == null
                    ? const Center(
                        child: Text("Could not determine current location"),
                      )
                    : GoogleMap(
                        mapType: MapType.normal,
                        onTap: (latLng) => controller.addMarker(latLng),
                        markers: controller.markers.toSet(),
                        initialCameraPosition: controller.currentPos!,
                        myLocationEnabled: true,
                        onMapCreated: (GoogleMapController ctrl) {
                          controller.googleMapcontroller.complete(ctrl);
                        },
                      ),
              ),
              Padding(
                padding: EdgeInsets.all(
                  AdaptiveLayout.getResponsiveFontSize(context, fontSize: 16),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Get.back(),
                        style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                            vertical: AdaptiveLayout.getResponsiveFontSize(
                              context,
                              fontSize: 14,
                            ),
                          ),
                          side: const BorderSide(color: Color(0xFF009689)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              AdaptiveLayout.getResponsiveFontSize(
                                context,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                        child: const Text(
                          "Back",
                          style: TextStyle(color: Color(0xFF009689)),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: AdaptiveLayout.getResponsiveFontSize(
                        context,
                        fontSize: 16,
                      ),
                    ),
                    Expanded(
                      child: CustomAuthButton(
                        onPressed: () => controller.completeRegistration(),
                        backgroundColor: const Color(0xFF009689),
                        child: const Text(
                          "Complete",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
