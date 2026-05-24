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
    // Normalize: backend sends 'pending'; controller filters on 'upcoming'
    final rawStatus = (map['status'] ?? 'pending').toString();
    final status = rawStatus == 'pending' ? 'upcoming' : rawStatus;

    return DoctorAppointmentModel(
      id:          map['id']?.toString() ?? '',
      // Doctor-facing API returns 'user', not 'client' — try both
      patientName: map['user']?['name'] ?? map['client']?['name'] ?? map['patientName'] ?? '',
      petName:     map['animal']?['name'] ?? map['petName'] ?? '',
      petType:     map['animal']?['species'] ?? map['animal']?['type'] ?? map['petType'] ?? '',
      date: map['date_time'] != null
          ? DateTime.parse(map['date_time'])
          : (map['date'] != null ? DateTime.parse(map['date']) : DateTime.now()),
      time: map['date_time'] != null
          ? map['date_time'].toString().split('T').last.substring(0, 5)
          : (map['time'] ?? ''),
      isOnline: map['type'] == 'online' || (map['isOnline'] ?? false),
      isPaid:   map['payment_status'] == 'paid' || (map['isPaid'] ?? false),
      status:   status,
      notes:    map['notes'] ?? map['reason'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory DoctorAppointmentModel.fromJson(String source) => DoctorAppointmentModel.fromMap(json.decode(source));
}
