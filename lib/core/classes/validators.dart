import 'package:get/get.dart';

class Validators {
  static String? emailValidator(String? email) {
    if (email == null || email.isEmpty) return "Enter Your Email";
    if (!GetUtils.isEmail(email)) return "Invalid Email";
    return null;
  }

  static String? passwordValidator(String? password) {
    if (password == null || password.isEmpty) return "Enter Your password";
    if (!RegExp(
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$',
    ).hasMatch(password)) {
      return "Password must be at least 8 characters \nlong and include an uppercase letter, a lowercase letter, \na number, and a special character.";
    }
    return null;
  }

  static String? fullNameValidator(String? fullName) {
    if (fullName == null || fullName.isEmpty) return "Enter Your Full Name";
    if (fullName.length < 3) {
      return "Name length should be greater than or equal 3";
    }
    return null;
  }

  static String? confirmedPasswordValidator(
    String password,
    String? confirmedPassword,
  ) {
    if (confirmedPassword == null || confirmedPassword.isEmpty) {
      return "Confirm your password";
    }
    if (password != confirmedPassword) {
      return "Password mismatch";
    }
    return null;
  }

  static String? phoneValidator(String? phone) {
    if (phone == null || phone.isEmpty) return "Enter your phone number";
    if (!GetUtils.isPhoneNumber(phone)) return "Invalid phone number";
    return null;
  }

  static String? commonValidator(String? value, String fieldName) {
    if (value == null || value.isEmpty) return "Enter $fieldName";
    return null;
  }
}
