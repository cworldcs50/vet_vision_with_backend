import 'package:dartz/dartz.dart';
import '../../../../../core/classes/crud.dart';
import '../../../../../core/network/request_status.dart';
import '../../../../../core/constants/link_api.dart';
import '../../../../../core/classes/failure_model.dart';
import '../../../booking/model/doctor_model.dart';
import '../models/user_dashboard_model.dart';
import '../repository/home_data_repository.dart';

class HomeDatasource implements IHomeRepository {
  const HomeDatasource({required this.crud});

  final Crud crud;

  @override
  Future<Either<FailureModel, UserDashboardModel>> getUserDashboard() async {
    final result = await crud.get(AppLink.userDashboard);
    return result.fold(Left.new, (json) {
      try {
        final ok = json['status'] == true;
        final raw = json['data'];
        if (ok && raw is Map) {
          final data = Map<String, dynamic>.from(raw);
          data['animals'] ??= <dynamic>[];
          data['recent_diagnoses'] ??= <dynamic>[];
          data['favorite_doctors'] ??= <dynamic>[];
          data['medical_alerts'] ??= <dynamic>[];
          return Right(UserDashboardModel.fromJson(data));
        }
        return Left(
          FailureModel(
            message: json['message']?.toString() ?? 'Could not load dashboard',
            status: RequestStatus.serverFailure,
          ),
        );
      } catch (e) {
        return Left(
          FailureModel(
            message: e.toString(),
            status: RequestStatus.failure,
          ),
        );
      }
    });
  }

  @override
  Future<Either<FailureModel, Map>> getDoctors({
    Map<String, dynamic>? queryParams,
  }) async {
    final base = Uri.parse(AppLink.doctors);
    final uri = queryParams == null || queryParams.isEmpty
        ? base
        : base.replace(
            queryParameters: queryParams.map(
              (key, value) => MapEntry(key, value.toString()),
            ),
          );
    final result = await crud.get(uri.toString());

    return result;
  }

  @override
  Future<Either<FailureModel, Map>> getSpecialization() async {
    final result = await crud.get(AppLink.specialization);

    return result;
  }

  // ── GET /doctors/nearest ─────────────────────────────────────────────────────
  @override
  Future<Either<FailureModel, List<DoctorModel>>> getNearestDoctors({
    required double lat,
    required double lng,
    int limit = 10,
  }) async {
    final uri = Uri.parse(AppLink.nearestDoctors).replace(
      queryParameters: {
        'lat': lat.toString(),
        'lng': lng.toString(),
        'limit': limit.toString(),
      },
    );
    final result = await crud.get(uri.toString());
    return result.fold(Left.new, (json) => _parseDoctorList(json));
  }

  // ── GET /doctors/nearby ───────────────────────────────────────────────────────
  @override
  Future<Either<FailureModel, List<DoctorModel>>> getNearbyDoctors({
    required double lat,
    required double lng,
    int distance = 10,
  }) async {
    final uri = Uri.parse(AppLink.nearbyDoctors).replace(
      queryParameters: {
        'lat': lat.toString(),
        'lng': lng.toString(),
        'distance': distance.toString(),
      },
    );
    final result = await crud.get(uri.toString());
    return result.fold(Left.new, (json) => _parseDoctorList(json));
  }

  // ── GET /doctors/{id} ────────────────────────────────────────────────────────
  @override
  Future<Either<FailureModel, DoctorModel>> getDoctor(String id) async {
    final result = await crud.get(AppLink.doctor(id));
    return result.fold(Left.new, (json) {
      try {
        return Right(
          DoctorModel.fromJson(json['data'] as Map<String, dynamic>),
        );
      } catch (e) {
        return Left(
          FailureModel(status: RequestStatus.failure, message: e.toString()),
        );
      }
    });
  }

  // ── GET /doctors/{id}/available-slots?date=Y-m-d ─────────────────────────────
  @override
  Future<Either<FailureModel, List<String>>> getAvailableSlots({
    required String doctorId,
    required String date, // "Y-m-d"
  }) async {
    final uri = Uri.parse(
      AppLink.availableSlots(doctorId),
    ).replace(queryParameters: {'date': date});
    final result = await crud.get(uri.toString());
    return result.fold(Left.new, (json) {
      try {
        final data = json['data'] as Map<String, dynamic>? ?? {};
        final slots = data['available_slots'] as List? ?? [];
        return Right(slots.map((s) => s['time'].toString()).toList());
      } catch (e) {
        return Left(
          FailureModel(status: RequestStatus.failure, message: e.toString()),
        );
      }
    });
  }

  // ── GET /doctors/{id}/availability-calendar ───────────────────────────────────
  @override
  Future<Either<FailureModel, List<Map<String, dynamic>>>>
  getAvailabilityCalendar(String doctorId) async {
    final result = await crud.get(AppLink.availabilityCalendar(doctorId));
    return result.fold(Left.new, (json) {
      try {
        final list = json['data'] as List? ?? [];
        return Right(
          list.map((e) => Map<String, dynamic>.from(e as Map)).toList(),
        );
      } catch (e) {
        return Left(
          FailureModel(status: RequestStatus.failure, message: e.toString()),
        );
      }
    });
  }

  // ── helper ──────────────────────────────────────────────────────────────────
  Either<FailureModel, List<DoctorModel>> _parseDoctorList(Map json) {
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
            .map((e) => DoctorModel.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
    } catch (e) {
      return Left(
        FailureModel(status: RequestStatus.failure, message: e.toString()),
      );
    }
  }
}
