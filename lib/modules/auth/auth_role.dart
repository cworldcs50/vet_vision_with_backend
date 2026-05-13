enum AuthRole {
  user('user'),
  doctor('doctor');

  const AuthRole(this.value);
  final String value;

  bool get isDoctor => this == AuthRole.doctor;

  static AuthRole fromValue(String? rawRole) {
    final normalized = (rawRole ?? '').trim().toLowerCase();
    if (normalized == AuthRole.doctor.value) {
      return AuthRole.doctor;
    }
    return AuthRole.user;
  }
}
