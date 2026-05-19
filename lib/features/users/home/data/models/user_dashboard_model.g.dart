// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_dashboard_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDashboardModel _$UserDashboardModelFromJson(
  Map<String, dynamic> json,
) => UserDashboardModel(
  totalAppointments: (json['total_appointments'] as num).toInt(),
  upcomingAppointments: (json['upcoming_appointments'] as num).toInt(),
  completedAppointments: (json['completed_appointments'] as num).toInt(),
  cancelledAppointments: (json['cancelled_appointments'] as num).toInt(),
  pendingAppointments: (json['pending_appointments'] as num).toInt(),
  nextAppointment: json['next_appointment'] == null
      ? null
      : DashboardNextAppointment.fromJson(
          json['next_appointment'] as Map<String, dynamic>,
        ),
  totalAnimals: (json['total_animals'] as num).toInt(),
  animals: (json['animals'] as List<dynamic>)
      .map((e) => DashboardAnimalItem.fromJson(e as Map<String, dynamic>))
      .toList(),
  recentDiagnoses: (json['recent_diagnoses'] as List<dynamic>)
      .map((e) => DashboardDiagnosisItem.fromJson(e as Map<String, dynamic>))
      .toList(),
  favoriteDoctors: (json['favorite_doctors'] as List<dynamic>)
      .map((e) => DashboardFavoriteDoctor.fromJson(e as Map<String, dynamic>))
      .toList(),
  medicalAlerts: (json['medical_alerts'] as List<dynamic>)
      .map((e) => DashboardMedicalAlert.fromJson(e as Map<String, dynamic>))
      .toList(),
);

DashboardNextAppointment _$DashboardNextAppointmentFromJson(
  Map<String, dynamic> json,
) => DashboardNextAppointment(
  id: (json['id'] as num).toInt(),
  dateTime: json['date_time'] as String,
  type: json['type'] as String,
  status: json['status'] as String,
  doctor: DashboardDoctorSummary.fromJson(
    json['doctor'] as Map<String, dynamic>,
  ),
  animal: DashboardAnimalSummary.fromJson(
    json['animal'] as Map<String, dynamic>,
  ),
);

DashboardDoctorSummary _$DashboardDoctorSummaryFromJson(
  Map<String, dynamic> json,
) => DashboardDoctorSummary(
  name: json['name'] as String,
  specialization: json['specialization'] as String,
);

DashboardAnimalSummary _$DashboardAnimalSummaryFromJson(
  Map<String, dynamic> json,
) => DashboardAnimalSummary(
  name: json['name'] as String,
  species: json['species'] as String,
);

DashboardAnimalItem _$DashboardAnimalItemFromJson(Map<String, dynamic> json) =>
    DashboardAnimalItem(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      species: json['species'] as String,
      breed: json['breed'] as String?,
      age: (json['age'] as num?)?.toInt(),
      gender: json['gender'] as String?,
      imagePath: json['image_path'] as String?,
    );

DashboardDiagnosisItem _$DashboardDiagnosisItemFromJson(
  Map<String, dynamic> json,
) => DashboardDiagnosisItem(
  id: (json['id'] as num).toInt(),
  animalId: (json['animal_id'] as num).toInt(),
  result: json['result'] as String?,
  confidence: (json['confidence'] as num?)?.toDouble(),
  recommendations: json['recommendations'] as String?,
  createdAt: json['created_at'] as String?,
  animal: json['animal'] == null
      ? null
      : DashboardAnimalBrief.fromJson(json['animal'] as Map<String, dynamic>),
);

DashboardAnimalBrief _$DashboardAnimalBriefFromJson(
  Map<String, dynamic> json,
) => DashboardAnimalBrief(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  species: json['species'] as String,
);

DashboardFavoriteDoctor _$DashboardFavoriteDoctorFromJson(
  Map<String, dynamic> json,
) => DashboardFavoriteDoctor(
  doctorId: (json['doctor_id'] as num).toInt(),
  name: json['name'] as String,
  specialization: json['specialization'] as String,
  visitsCount: (json['visits_count'] as num).toInt(),
  avgRating: (json['avg_rating'] as num).toDouble(),
);

DashboardMedicalAlert _$DashboardMedicalAlertFromJson(
  Map<String, dynamic> json,
) => DashboardMedicalAlert(
  type: json['type'] as String,
  message: json['message'] as String,
);
