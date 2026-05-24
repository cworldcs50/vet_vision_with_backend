class DoctorAuthModel {
  final int? userId;
  final String? name;
  final String? role;
  final String? email;
  final String? tokenType;
  final String? accessToken;

  const DoctorAuthModel({
    this.name,
    this.role,
    this.email,
    this.userId,
    this.tokenType,
    this.accessToken,
  });

  factory DoctorAuthModel.fromJson(Map<String, dynamic> json) {
    // Handling standard response format from ApiResponseTrait
    final data = json['data'] ?? json;
    final userData = data['user'] ?? {};

    return DoctorAuthModel(
      userId: userData['id'],
      name: userData['name'],
      role: userData['role'],
      email: userData['email'],
      tokenType: data['token_type'],
      accessToken: data['access_token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'token_type': tokenType,
      'access_token': accessToken,
      'user': {'id': userId, 'name': name, 'email': email, 'role': role},
    };
  }
}
