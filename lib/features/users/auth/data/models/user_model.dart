import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../datasource/static/cache_user.dart';

class UserModel extends Equatable {
  const UserModel({
    required this.phone,
    required this.avater,
    required this.address,
    required this.avatarUrl,
    required this.id,
    required this.email,
    required this.fullName,
    required this.password,
    required this.role,
    required this.accessToken,
    required this.tokenType,
  });

  final String id,
      fullName,
      password,
      email,
      role,
      accessToken,
      tokenType,
      avater,
      address,
      phone,
      avatarUrl;

  factory UserModel.fromJson(Map<String, dynamic> json, String password) {
    final userMap = json['user'];
    return UserModel(
      password: password,
      tokenType: json["token_type"] ?? "",
      accessToken: json["access_token"] ?? "",
      id: userMap['id'].toString(),
      fullName: userMap['name'],
      email: userMap['email'],
      phone: userMap['phone'] ?? "",
      address: userMap['address'] ?? "",
      role: userMap['role'],
      avatarUrl: userMap['avatar_url'] ?? "",
      avater:
          userMap['avatar_url'] ??
          "", // Using avatar_url for both as per backend
    );
  }

  Future<Either<String, bool>> cacheUser(UserModel user) async =>
      await CacheUser()(user);

  @override
  List<Object?> get props => [
    id,
    fullName,
    password,
    email,
    role,
    accessToken,
    tokenType,
    avater,
    address,
    phone,
    avatarUrl,
  ];
}
