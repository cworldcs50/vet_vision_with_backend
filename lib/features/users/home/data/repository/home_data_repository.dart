import 'package:dartz/dartz.dart';
import '../../../../../core/classes/failure_model.dart';
import '../../../booking/model/doctor_model.dart';
import '../models/user_dashboard_model.dart';

abstract class IHomeRepository {
  Future<Either<FailureModel, UserDashboardModel>> getUserDashboard();

  Future<Either<FailureModel, Map>> getDoctors({Map<String, dynamic>? queryParams});
  Future<Either<FailureModel, List<DoctorModel>>> getNearestDoctors({
    required double lat,
    required double lng,
    int limit = 10,
  });
  Future<Either<FailureModel, List<DoctorModel>>> getNearbyDoctors({
    required double lat,
    required double lng,
    int distance = 10,
  });
  Future<Either<FailureModel, DoctorModel>> getDoctor(String id);
  Future<Either<FailureModel, List<String>>> getAvailableSlots({
    required String doctorId,
    required String date, // "Y-m-d"
  });
  Future<Either<FailureModel, List<Map<String, dynamic>>>>
  getAvailabilityCalendar(String doctorId);

  Future<Either<FailureModel, Map>> getSpecialization();
}
