class DoctorProfileModel {
  final String fullName;
  final String email;
  final String phone;
  final String specialization;
  final int experienceYears;
  final String bio;
  final double consultationFee;
  final String clinicAddress;
  final bool isOnline;
  final bool isInPerson;
  final String imageUrl;
  final double latitude;
  final double longitude;

  final List<Map<String, dynamic>> availabilities;

  DoctorProfileModel({
    required this.fullName,
    required this.email,
    required this.phone,
    required this.specialization,
    required this.experienceYears,
    required this.bio,
    required this.consultationFee,
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
    return DoctorProfileModel(
      fullName: user?['name'] ?? '',
      email: user?['email'] ?? '',
      phone: user?['phone'] ?? '',
      specialization: map['specialization'] ?? '',
      experienceYears: map['experience_years'] ?? 0,
      bio: map['bio'] ?? '',
      consultationFee: (map['consultation_fee'] ?? 0).toDouble(),
      clinicAddress: map['clinic_address'] ?? '',
      isOnline: map['is_online'] ?? true,
      isInPerson: map['is_in_person'] ?? true,
      imageUrl: map['image_url'] ?? '',
      latitude: (map['latitude'] ?? 30.05).toDouble(),
      longitude: (map['longitude'] ?? 31.233).toDouble(),
      availabilities: List<Map<String, dynamic>>.from(
        (map['availabilities'] as List?)?.map(
          (e) => {
            'day': e['day'] ?? 'Monday',
            'start_time': _formatTime(e['start_time']),
            'end_time': _formatTime(e['end_time']),
          },
        ) ?? [],
      ),
    );
  }
}
