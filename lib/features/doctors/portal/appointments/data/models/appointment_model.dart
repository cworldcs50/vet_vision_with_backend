import 'package:equatable/equatable.dart';

import '../../../../../users/booking/model/doctor_model.dart';
import 'animal_model.dart';


/// Matches Laravel's AppointmentResource response shape.
class AppointmentModel extends Equatable {
  const AppointmentModel({
    required this.id,
    required this.userId,
    required this.doctorId,
    required this.animalId,
    required this.dateTime,
    required this.type,
    required this.status,
    this.reason,
    this.notes,
    this.location,
    this.latitude,
    this.longitude,
    this.rating,
    this.review,
    this.doctor,
    this.animal,
    this.userName,
  });

  final String  id;
  final String  userId;
  final String  doctorId;
  final String  animalId;
  final String  dateTime;   // kept as String — "Y-m-d H:i" from backend
  final String  type;       // online | clinic | home_visit
  final String  status;     // pending | confirmed | completed | cancelled
  final String? reason;
  final String? notes;
  final String? location;
  final double? latitude;
  final double? longitude;
  final int?    rating;
  final String? review;

  // Nested objects (loaded with 'with')
  final DoctorModel? doctor;
  final AnimalModel? animal;
  final String?      userName;

  factory AppointmentModel.fromJson(Map<String, dynamic> json) {
    final doctorMap = json['doctor'] as Map<String, dynamic>?;
    final animalMap = json['animal'] as Map<String, dynamic>?;
    final userMap   = json['user']   as Map<String, dynamic>?;

    return AppointmentModel(
      id:        (json['id'] ?? 0).toString(),
      userId:    (json['user_id']   ?? 0).toString(),
      doctorId:  (json['doctor_id'] ?? 0).toString(),
      animalId:  (json['animal_id'] ?? 0).toString(),
      dateTime:  json['date_time']?.toString() ?? '',
      type:      json['type']   ?? '',
      status:    json['status'] ?? '',
      reason:    json['reason'],
      notes:     json['notes'],
      location:  json['location'],
      latitude:  json['latitude']  != null ? (json['latitude']  as num).toDouble() : null,
      longitude: json['longitude'] != null ? (json['longitude'] as num).toDouble() : null,
      rating:    json['rating'],
      review:    json['review'],
      doctor:    doctorMap != null ? DoctorModel.fromJson(doctorMap) : null,
      animal:    animalMap != null ? AnimalModel.fromJson(animalMap) : null,
      userName:  userMap?['name'],
    );
  }

  bool get isUpcoming  => status == 'pending'   || status == 'confirmed';
  bool get isCompleted => status == 'completed';
  bool get isCancelled => status == 'cancelled';

  @override
  List<Object?> get props => [id, userId, doctorId, animalId, dateTime, type, status];
}
