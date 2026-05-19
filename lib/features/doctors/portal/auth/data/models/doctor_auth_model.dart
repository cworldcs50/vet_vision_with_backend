class DoctorAuthModel {
  final String? accessToken;
  final String? tokenType;
  final int? userId;
  final String? name;
  final String? email;
  final String? role;

  const DoctorAuthModel({
    this.accessToken,
    this.tokenType,
    this.userId,
    this.name,
    this.email,
    this.role,
  });

  factory DoctorAuthModel.fromJson(Map<String, dynamic> json) {
    // Handling standard response format from ApiResponseTrait
    final data = json['data'] ?? json;
    final userData = data['user'] ?? {};
    
    return DoctorAuthModel(
      accessToken: data['access_token'],
      tokenType: data['token_type'],
      userId: userData['id'],
      name: userData['name'],
      email: userData['email'],
      role: userData['role'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'access_token': accessToken,
      'token_type': tokenType,
      'user': {
        'id': userId,
        'name': name,
        'email': email,
        'role': role,
      },
    };
  }
}
