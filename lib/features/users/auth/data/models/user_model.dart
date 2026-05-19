import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../datasource/static/cache_user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel extends Equatable {
  const UserModel({
    required this.id,
    required this.role,
    required this.email,
    required this.phone,
    required this.avatar,
    required this.address,
    required this.fullName,
    required this.password,
    required this.tokenType,
    required this.avatarUrl,
    required this.accessToken,
  });

  final String id;
  @JsonKey(name: 'name')
  final String fullName;
  final String password;
  final String email;
  final String role;
  @JsonKey(name: 'access_token')
  final String accessToken;
  @JsonKey(name: 'token_type')
  final String tokenType;
  final String avatar;
  final String address;
  final String phone;
  @JsonKey(name: 'avatar_url')
  final String avatarUrl;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  factory UserModel.fromApiData(Map<String, dynamic> data, String password) {
    final userMap = Map<String, dynamic>.from(data['user'] ?? {});
    return UserModel(
      password: password,
      tokenType: data["token_type"]?.toString() ?? "",
      accessToken: data["access_token"]?.toString() ?? "",
      id: userMap['id']?.toString() ?? "",
      fullName: userMap['name']?.toString() ?? "",
      email: userMap['email']?.toString() ?? "",
      phone: userMap['phone'] ?? "",
      address: userMap['address'] ?? "",
      role: userMap['role']?.toString() ?? "user",
      avatarUrl: userMap['avatar_url'] ?? "",
      avatar: userMap['avatar_url'] ?? "",
    );
  }

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  Future<Either<String, bool>> cacheUser(UserModel user) async =>
      await CacheUser()(user);

  @override
  List<Object?> get props => [
    id,
    role,
    phone,
    email,
    avatar,
    address,
    fullName,
    password,
    avatarUrl,
    tokenType,
    accessToken,
  ];
}
