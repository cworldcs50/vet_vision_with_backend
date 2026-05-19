class DoctorAnalyticsModel {
  final double monthlyEarnings;
  final String growthPercentage;
  final int totalPatients;
  final int todayAppointmentsCount;
  final int totalConsultations;

  DoctorAnalyticsModel({
    required this.monthlyEarnings,
    required this.growthPercentage,
    required this.totalPatients,
    required this.todayAppointmentsCount,
    required this.totalConsultations,
  });

  factory DoctorAnalyticsModel.fromMap(Map<String, dynamic> map) {
    return DoctorAnalyticsModel(
      monthlyEarnings: (map['this_month_earnings'] ?? 0.0).toDouble(),
      growthPercentage: map['earnings_growth']?.toString() ?? "0%",
      totalPatients: map['total_patients'] ?? 0,
      todayAppointmentsCount: map['today_appointments_count'] ?? 0,
      totalConsultations: map['total_consultations'] ?? 0,
    );
  }
}
