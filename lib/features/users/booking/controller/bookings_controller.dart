import 'package:get/get.dart';
import '../../../../core/classes/base_request_controller.dart';
import '../../../../core/network/request_status.dart';
import '../../../../core/services/app_service.dart';
import '../../../doctors/portal/appointments/data/datasource/appointment_datasource.dart';
import '../../../doctors/portal/appointments/data/models/appointment_model.dart';

class BookingsController extends BaseRequestController {
  BookingsController()
    : _appointmentDatasource = AppointmentDatasource(
        crud: Get.find<AppServices>().crud,
      );

  final AppointmentDatasource _appointmentDatasource;
  int selectedTabIndex = 0;
  List<AppointmentModel> appointments = [];

  List<AppointmentModel> get upcomingAppointments => appointments
      .where((a) => a.status == 'pending' || a.status == 'confirmed')
      .toList();

  List<AppointmentModel> get pastAppointments => appointments
      .where((a) => a.status == 'completed' || a.status == 'cancelled')
      .toList();

  @override
  void onInit() {
    super.onInit();
    loadAppointments();
  }

  Future<void> loadAppointments() async {
    setStatus(RequestStatus.loading);
    final result = await _appointmentDatasource.getMyAppointments();
    result.fold((failure) => setStatus(failure.status), (data) {
      appointments = data;
      setStatus(data.isEmpty ? RequestStatus.noData : RequestStatus.success);
    });
    update();
  }

  void changeTab(int index) {
    selectedTabIndex = index;
    update();
  }
}
