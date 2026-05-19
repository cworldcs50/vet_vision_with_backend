// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
  phone: json['phone'] as String,
  avatar: json['avatar'] as String,
  address: json['address'] as String,
  avatarUrl: json['avatar_url'] as String,
  id: json['id'] as String,
  email: json['email'] as String,
  fullName: json['name'] as String,
  password: json['password'] as String,
  role: json['role'] as String,
  accessToken: json['access_token'] as String,
  tokenType: json['token_type'] as String,
);

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.fullName,
  'password': instance.password,
  'email': instance.email,
  'role': instance.role,
  'access_token': instance.accessToken,
  'token_type': instance.tokenType,
  'avatar': instance.avatar,
  'address': instance.address,
  'phone': instance.phone,
  'avatar_url': instance.avatarUrl,
};
