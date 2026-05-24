import 'package:dartz/dartz.dart';
import '../../../../../../core/classes/crud.dart';
import '../../../../../../core/classes/failure_model.dart';
import '../../../../../../core/constants/link_api.dart';
import '../../../../../../core/network/request_status.dart';
import '../models/appointment_model.dart';

class AppointmentDatasource {
  const AppointmentDatasource({required this.crud});
  final Crud crud;

  // ── POST /appointments ────────────────────────────────────────────────────────
  Future<Map> bookAppointment({
    required String doctorId,
    required String animalId,
    required String dateTime, // "Y-m-d H:i"
    required String type, // online | clinic | home_visit
    String? reason,
    String? notes,
    String? location,
    String? latitude,
    String? longitude,
  }) async {
    final body = <String, String>{
      'doctor_id': doctorId,
      'animal_id': animalId,
      'date_time': dateTime,
      'type': type,
    };
    if (reason != null) body['reason'] = reason;
    if (notes != null) body['notes'] = notes;
    if (location != null) body['location'] = location;
    if (latitude != null) body['latitude'] = latitude;
    if (longitude != null) body['longitude'] = longitude;

    return await crud.post(AppLink.appointments, body);
  }

  // ── GET /my-appointments ──────────────────────────────────────────────────────
  Future<Either<FailureModel, List<AppointmentModel>>>
  getMyAppointments() async {
    final result = await crud.get(AppLink.myAppointments);
    return result.fold(Left.new, (json) => _parseAppointmentList(json));
  }

  // ── GET /doctor/appointments ──────────────────────────────────────────────────
  Future<Either<FailureModel, List<AppointmentModel>>>
  getDoctorAppointments() async {
    final result = await crud.get(AppLink.doctorAppointments);
    return result.fold(Left.new, (json) => _parseAppointmentList(json));
  }

  // ── GET /appointments/{id} ────────────────────────────────────────────────────
  Future<Either<FailureModel, AppointmentModel>> getAppointment(
    String id,
  ) async {
    final result = await crud.get(AppLink.appointment(id));
    return result.fold(Left.new, (json) {
      try {
        return Right(
          AppointmentModel.fromJson(json['data'] as Map<String, dynamic>),
        );
      } catch (e) {
        return Left(
          FailureModel(status: RequestStatus.failure, message: e.toString()),
        );
      }
    });
  }

  // ── PUT /appointments/{id}/cancel ─────────────────────────────────────────────
  Future<Map> cancelAppointment(String id) async =>
      await crud.put(AppLink.cancelAppointment(id), {});

  // ── PUT /appointments/{id}/reschedule ────────────────────────────────────────
  Future<Map> rescheduleAppointment(String id, String newDateTime) async =>
      await crud.put(AppLink.rescheduleAppointment(id), {
        'date_time': newDateTime,
      });

  // ── PUT /appointments/{id}/status (doctor only) ───────────────────────────────
  Future<Map> updateStatus(String id, String status) async =>
      await crud.put(AppLink.updateAppointmentStatus(id), {'status': status});

  // ── POST /appointments/{id}/rate ──────────────────────────────────────────────
  Future<Map> rateAppointment(String id, int rating, {String? comment}) async {
    final body = <String, String>{'rating': rating.toString()};
    if (comment != null && comment.isNotEmpty) body['comment'] = comment;
    return await crud.post(AppLink.rateAppointment(id), body);
  }

  // ── POST /appointments/check-availability ────────────────────────────────────
  Future<Map> checkAvailability(String doctorId, String dateTime) async =>
      await crud.post(AppLink.checkAvailability, {
        'doctor_id': doctorId,
        'date_time': dateTime,
      });

  // ── helper ──────────────────────────────────────────────────────────────────
  Either<FailureModel, List<AppointmentModel>> _parseAppointmentList(Map json) {
    try {
      final raw = json['data'];
      List list;
      if (raw is Map && raw.containsKey('data')) {
        list = raw['data'] as List;
      } else if (raw is List) {
        list = raw;
      } else {
        list = [];
      }
      return Right(
        list
            .map((e) => AppointmentModel.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
    } catch (e) {
      return Left(
        FailureModel(status: RequestStatus.failure, message: e.toString()),
      );
    }
  }
}
