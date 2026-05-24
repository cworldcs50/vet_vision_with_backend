import '../../../../core/constants/images_constants.dart';

class DoctorModel {
  final int id;
  final String bio;
  final int userId;
  final String role;
  final String name;
  final String email;
  final String? phone;
  final String imageUrl;
  final String? address;
  final String? clinicAddress;
  final String avatarUrl;
  final double? distanceKm;
  final int experienceYears;
  final String specialization;

  // ── Backend fields ──────────────────────────────────────────────────────────
  final double? rating;          // average_rating from backend
  final double? consultationFee; // consultation_fee (single fee)
  final bool isOnline;           // is_online
  final bool isInPerson;         // is_in_person
  final bool isVerified;         // is_verified

  DoctorModel({
    this.bio = '',
    this.id = 0,
    required this.role,
    required this.name,
    required this.email,
    required this.phone,
    required this.userId,
    required this.address,
    this.clinicAddress,
    this.experienceYears = 0,
    this.specialization = '',
    required this.distanceKm,
    this.avatarUrl = ImagesConstants.doctorProfile,
    this.imageUrl = ImagesConstants.doctorProfile,
    this.rating,
    this.consultationFee,
    this.isOnline = true,
    this.isInPerson = true,
    this.isVerified = false,
  });

  factory DoctorModel.fromJson(Map<String, dynamic> json) {
    final userInfo = (json['user_info'] ?? json['user'] ?? {}) as Map;

    return DoctorModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      specialization: json['specialization']?.toString() ?? '',
      experienceYears: (json['experience_years'] as num?)?.toInt() ?? 0,
      bio: json['bio']?.toString() ?? '',
      clinicAddress: json['clinic_address']?.toString(),
      userId: (userInfo['id'] as num?)?.toInt() ?? 0,
      name: userInfo['name']?.toString() ?? '',
      email: userInfo['email']?.toString() ?? '',
      phone: userInfo['phone']?.toString(),
      address: userInfo['address']?.toString(),
      role: userInfo['role']?.toString() ?? 'doctor',
      imageUrl: json['image_url']?.toString() ?? ImagesConstants.doctorProfile,
      avatarUrl: userInfo['avatar_url']?.toString() ?? ImagesConstants.doctorProfile,
      distanceKm: json['distance_km'] != null
          ? (json['distance_km'] as num).toDouble()
          : null,
      rating: json['average_rating'] != null
          ? (json['average_rating'] as num).toDouble()
          : null,
      consultationFee: json['consultation_fee'] != null
          ? (json['consultation_fee'] as num).toDouble()
          : null,
      isOnline: json['is_online'] == true || json['is_online'] == 1,
      isInPerson: json['is_in_person'] == true || json['is_in_person'] == 1,
      isVerified: json['is_verified'] == true || json['is_verified'] == 1,
    );
  }

  /// Formatted rating string e.g. "4.5" or "—"
  String get ratingDisplay =>
      rating != null ? rating!.toStringAsFixed(1) : '—';

  /// Formatted fee string e.g. "EGP 200" or "—"
  String get feeDisplay =>
      consultationFee != null ? 'EGP ${consultationFee!.toStringAsFixed(0)}' : '—';

  /// Session types label
  String get sessionTypeLabel {
    if (isOnline && isInPerson) return 'Online & In-Person';
    if (isOnline) return 'Online';
    if (isInPerson) return 'In-Person';
    return 'N/A';
  }

  /// Whether the imageUrl is a network URL
  bool get isNetworkImage =>
      imageUrl.startsWith('http://') || imageUrl.startsWith('https://');
}
