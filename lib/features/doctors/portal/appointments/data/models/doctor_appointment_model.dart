import 'dart:convert';

class DoctorAppointmentModel {
  final String id;
  final String patientName;
  final String petName;
  final String petType;
  final DateTime date;
  final String time;
  final bool isOnline;
  final bool isPaid;
  final String status; // "upcoming", "completed", "cancelled"
  final String notes;

  DoctorAppointmentModel({
    required this.id,
    required this.patientName,
    required this.petName,
    required this.petType,
    required this.date,
    required this.time,
    required this.isOnline,
    required this.isPaid,
    required this.status,
    this.notes = '',
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'patientName': patientName,
      'petName': petName,
      'petType': petType,
      'date': date.toIso8601String(),
      'time': time,
      'isOnline': isOnline,
      'isPaid': isPaid,
      'status': status,
      'notes': notes,
    };
  }

  factory DoctorAppointmentModel.fromMap(Map<String, dynamic> map) {
    return DoctorAppointmentModel(
      id: map['id'] ?? '',
      patientName: map['patientName'] ?? '',
      petName: map['petName'] ?? '',
      petType: map['petType'] ?? '',
      date: DateTime.parse(map['date']),
      time: map['time'] ?? '',
      isOnline: map['isOnline'] ?? false,
      isPaid: map['isPaid'] ?? false,
      status: map['status'] ?? 'upcoming',
      notes: map['notes'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory DoctorAppointmentModel.fromJson(String source) => DoctorAppointmentModel.fromMap(json.decode(source));
}
