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
  final String avatarUrl;
  final double? distanceKm;
  final int experienceYears;
  final String specialization;

  DoctorModel({
    this.bio = '',
    this.id = 0,
    required this.role,
    required this.name,
    required this.email,
    required this.phone,
    required this.userId,
    required this.address,
    this.experienceYears = 0,
    this.specialization = '',
    required this.distanceKm,
    this.avatarUrl = ImagesConstants.doctorProfile,
    this.imageUrl = ImagesConstants.doctorProfile,
  });

  factory DoctorModel.fromJson(Map<String, dynamic> json) {
    final userInfo = json['user_info'] ?? {};

    return DoctorModel(
      id: json['id'],
      specialization: json['specialization'],
      experienceYears: json['experience_years'],
      bio: json['bio'],
      userId: userInfo['id'],
      name: userInfo['name'],
      email: userInfo['email'],
      phone: userInfo['phone'],
      address: userInfo['address'],
      role: userInfo['role'],
      imageUrl: json['image_url'] ?? ImagesConstants.doctorProfile,
      avatarUrl: userInfo['avatar_url'] ?? ImagesConstants.doctorProfile,
      distanceKm: json['distance_km'] != null
          ? (json['distance_km'] as num).toDouble()
          : null,
    );
  }
}
