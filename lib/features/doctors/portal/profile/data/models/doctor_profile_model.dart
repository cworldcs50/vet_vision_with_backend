import 'dart:developer';

class DoctorProfileModel {
  final String bio;
  final String email;
  final String phone;
  final bool isOnline;
  final String fullName;
  final bool isInPerson;
  final String imageUrl;
  final double latitude;
  final double longitude;
  final int experienceYears;
  final String licenseNumber;
  final String clinicAddress;
  final String specialization;
  final double consultationFeeOnline;
  final double consultationFeeOffline;

  final List<Map<String, dynamic>> availabilities;

  DoctorProfileModel({
    required this.fullName,
    required this.email,
    required this.phone,
    required this.specialization,
    required this.experienceYears,
    required this.licenseNumber,
    required this.bio,
    required this.consultationFeeOnline,
    required this.consultationFeeOffline,
    required this.clinicAddress,
    required this.isOnline,
    required this.isInPerson,
    required this.imageUrl,
    required this.latitude,
    required this.longitude,
    required this.availabilities,
  });

  static String _formatTime(dynamic time) {
    if (time == null) return '09:00';
    final str = time.toString();
    if (str.length >= 5) {
      return str.substring(0, 5);
    }
    return str;
  }

  factory DoctorProfileModel.fromMap(Map<String, dynamic> map) {
    final user = map['user'] ?? map['user_info'];
    log(map['image_url'].toString().split("/").last);
    return DoctorProfileModel(
      fullName: user?['name'] ?? '',
      email: user?['email'] ?? '',
      phone: user?['phone'] ?? '',
      specialization: map['specialization'] ?? '',
      experienceYears: map['experience_years'] ?? 0,
      licenseNumber: map['license_number'] ?? '',
      bio: map['bio'] ?? '',
      consultationFeeOnline: (map['consultation_fee_online'] ?? 0).toDouble(),
      consultationFeeOffline: (map['consultation_fee_offline'] ?? 0).toDouble(),
      clinicAddress: map['clinic_address'] ?? '',
      isOnline:
          (map['is_online_available'] == 1 ||
              map['is_online_available'] == true) ||
          (map['is_online'] == 1 || map['is_online'] == true),
      isInPerson:
          (map['is_offline_available'] == 1 ||
              map['is_offline_available'] == true) ||
          (map['is_in_person'] == 1 || map['is_in_person'] == true),
      imageUrl: map['image_url'] != null
          ? "http://10.0.2.2/VetVision-API/VetVision-API/storage/app/public/doctors/${map['image_url'].toString().split("/").last}"
          : '',
      latitude: (map['latitude'] ?? 30.05).toDouble(),
      longitude: (map['longitude'] ?? 31.233).toDouble(),
      availabilities: List<Map<String, dynamic>>.from(
        (map['availabilities'] as List?)?.map((e) {
              if (e is! Map) return <String, dynamic>{};
              return <String, dynamic>{
                'day': e['day'] ?? 'Monday',
                'start_time': _formatTime(e['start_time']),
                'end_time': _formatTime(e['end_time']),
              };
            }) ??
            [],
      ),
    );
  }
}
