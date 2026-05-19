import 'package:json_annotation/json_annotation.dart';

part 'user_dashboard_model.g.dart';

@JsonSerializable(createToJson: false)
class UserDashboardModel {
  const UserDashboardModel({
    required this.totalAppointments,
    required this.upcomingAppointments,
    required this.completedAppointments,
    required this.cancelledAppointments,
    required this.pendingAppointments,
    this.nextAppointment,
    required this.totalAnimals,
    required this.animals,
    required this.recentDiagnoses,
    required this.favoriteDoctors,
    required this.medicalAlerts,
  });

  @JsonKey(name: 'total_appointments')
  final int totalAppointments;

  @JsonKey(name: 'upcoming_appointments')
  final int upcomingAppointments;

  @JsonKey(name: 'completed_appointments')
  final int completedAppointments;

  @JsonKey(name: 'cancelled_appointments')
  final int cancelledAppointments;

  @JsonKey(name: 'pending_appointments')
  final int pendingAppointments;

  @JsonKey(name: 'next_appointment')
  final DashboardNextAppointment? nextAppointment;

  @JsonKey(name: 'total_animals')
  final int totalAnimals;

  final List<DashboardAnimalItem> animals;

  @JsonKey(name: 'recent_diagnoses')
  final List<DashboardDiagnosisItem> recentDiagnoses;

  @JsonKey(name: 'favorite_doctors')
  final List<DashboardFavoriteDoctor> favoriteDoctors;

  @JsonKey(name: 'medical_alerts')
  final List<DashboardMedicalAlert> medicalAlerts;

  factory UserDashboardModel.fromJson(Map<String, dynamic> json) =>
      _$UserDashboardModelFromJson(json);
}

@JsonSerializable(createToJson: false)
class DashboardNextAppointment {
  const DashboardNextAppointment({
    required this.id,
    required this.dateTime,
    required this.type,
    required this.status,
    required this.doctor,
    required this.animal,
  });

  final int id;

  @JsonKey(name: 'date_time')
  final String dateTime;

  final String type;
  final String status;
  final DashboardDoctorSummary doctor;
  final DashboardAnimalSummary animal;

  factory DashboardNextAppointment.fromJson(Map<String, dynamic> json) =>
      _$DashboardNextAppointmentFromJson(json);
}

@JsonSerializable(createToJson: false)
class DashboardDoctorSummary {
  const DashboardDoctorSummary({
    required this.name,
    required this.specialization,
  });

  final String name;
  final String specialization;

  factory DashboardDoctorSummary.fromJson(Map<String, dynamic> json) =>
      _$DashboardDoctorSummaryFromJson(json);
}

@JsonSerializable(createToJson: false)
class DashboardAnimalSummary {
  const DashboardAnimalSummary({
    required this.name,
    required this.species,
  });

  final String name;
  final String species;

  factory DashboardAnimalSummary.fromJson(Map<String, dynamic> json) =>
      _$DashboardAnimalSummaryFromJson(json);
}

@JsonSerializable(createToJson: false)
class DashboardAnimalItem {
  const DashboardAnimalItem({
    required this.id,
    required this.name,
    required this.species,
    this.breed,
    this.age,
    this.gender,
    this.imagePath,
  });

  final int id;
  final String name;
  final String species;
  final String? breed;
  final int? age;
  final String? gender;

  @JsonKey(name: 'image_path')
  final String? imagePath;

  factory DashboardAnimalItem.fromJson(Map<String, dynamic> json) =>
      _$DashboardAnimalItemFromJson(json);
}

@JsonSerializable(createToJson: false)
class DashboardDiagnosisItem {
  const DashboardDiagnosisItem({
    required this.id,
    required this.animalId,
    this.result,
    this.confidence,
    this.recommendations,
    this.createdAt,
    this.animal,
  });

  final int id;

  @JsonKey(name: 'animal_id')
  final int animalId;

  final String? result;
  final double? confidence;
  final String? recommendations;

  @JsonKey(name: 'created_at')
  final String? createdAt;

  final DashboardAnimalBrief? animal;

  factory DashboardDiagnosisItem.fromJson(Map<String, dynamic> json) =>
      _$DashboardDiagnosisItemFromJson(json);
}

@JsonSerializable(createToJson: false)
class DashboardAnimalBrief {
  const DashboardAnimalBrief({
    required this.id,
    required this.name,
    required this.species,
  });

  final int id;
  final String name;
  final String species;

  factory DashboardAnimalBrief.fromJson(Map<String, dynamic> json) =>
      _$DashboardAnimalBriefFromJson(json);
}

@JsonSerializable(createToJson: false)
class DashboardFavoriteDoctor {
  const DashboardFavoriteDoctor({
    required this.doctorId,
    required this.name,
    required this.specialization,
    required this.visitsCount,
    required this.avgRating,
  });

  @JsonKey(name: 'doctor_id')
  final int doctorId;

  final String name;
  final String specialization;

  @JsonKey(name: 'visits_count')
  final int visitsCount;

  @JsonKey(name: 'avg_rating')
  final double avgRating;

  factory DashboardFavoriteDoctor.fromJson(Map<String, dynamic> json) =>
      _$DashboardFavoriteDoctorFromJson(json);
}

@JsonSerializable(createToJson: false)
class DashboardMedicalAlert {
  const DashboardMedicalAlert({
    required this.type,
    required this.message,
  });

  final String type;
  final String message;

  factory DashboardMedicalAlert.fromJson(Map<String, dynamic> json) =>
      _$DashboardMedicalAlertFromJson(json);
}
